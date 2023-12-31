/*
 * Copyright 2020 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.configurationcache.serialization.codecs

import org.gradle.api.file.FileVisitDetails
import org.gradle.api.file.FileVisitor
import org.gradle.api.internal.file.AbstractFileCollection
import org.gradle.api.internal.file.FileCollectionBackedFileTree
import org.gradle.api.internal.file.FileCollectionFactory
import org.gradle.api.internal.file.FileCollectionInternal
import org.gradle.api.internal.file.FileCollectionStructureVisitor
import org.gradle.api.internal.file.FileOperations
import org.gradle.api.internal.file.FileTreeInternal
import org.gradle.api.internal.file.FilteredFileTree
import org.gradle.api.internal.file.archive.TarFileTree
import org.gradle.api.internal.file.archive.ZipFileTree
import org.gradle.api.internal.file.collections.DirectoryFileTree
import org.gradle.api.internal.file.collections.DirectoryFileTreeFactory
import org.gradle.api.internal.file.collections.FileSystemMirroringFileTree
import org.gradle.api.internal.file.collections.FileTreeAdapter
import org.gradle.api.internal.file.collections.FilteredMinimalFileTree
import org.gradle.api.internal.file.collections.GeneratedSingletonFileTree
import org.gradle.api.internal.file.collections.MinimalFileTree
import org.gradle.api.provider.Provider
import org.gradle.api.tasks.util.PatternSet
import org.gradle.configurationcache.serialization.Codec
import org.gradle.configurationcache.serialization.ReadContext
import org.gradle.configurationcache.serialization.WriteContext
import org.gradle.configurationcache.serialization.decodePreservingIdentity
import org.gradle.configurationcache.serialization.encodePreservingIdentityOf
import org.gradle.configurationcache.serialization.readNonNull
import java.io.File


private
sealed class FileTreeSpec


private
class AdaptedFileTreeSpec(val tree: MinimalFileTree) : FileTreeSpec()


private
class WrappedFileCollectionTreeSpec(val collection: AbstractFileCollection) : FileTreeSpec()


private
class DirectoryTreeSpec(val file: File, val patterns: PatternSet) : FileTreeSpec()


private
class ZipTreeSpec(val file: Provider<File>) : FileTreeSpec()


private
class TarTreeSpec(val file: Provider<File>) : FileTreeSpec()


private
class GeneratedTreeSpec(val spec: GeneratedSingletonFileTree.Spec) : FileTreeSpec()


internal
class FileTreeCodec(
    private val fileCollectionFactory: FileCollectionFactory,
    private val directoryFileTreeFactory: DirectoryFileTreeFactory,
    private val fileOperations: FileOperations
) : Codec<FileTreeInternal> {

    override suspend fun WriteContext.encode(value: FileTreeInternal) {
        encodePreservingIdentityOf(value) {
            write(rootSpecOf(value))
        }
    }

    override suspend fun ReadContext.decode(): FileTreeInternal? =
        decodePreservingIdentity { id ->
            val specs = readNonNull<List<FileTreeSpec>>()
            val fileTrees = specs.map {
                when (it) {
                    is AdaptedFileTreeSpec -> fileCollectionFactory.treeOf(it.tree)
                    is WrappedFileCollectionTreeSpec -> it.collection.asFileTree
                    is DirectoryTreeSpec -> fileCollectionFactory.treeOf(
                        directoryFileTreeFactory.create(
                            it.file,
                            it.patterns
                        )
                    )

                    is GeneratedTreeSpec -> it.spec.run {
                        fileCollectionFactory.generated(
                            tmpDir,
                            fileName,
                            fileGenerationListener,
                            contentGenerator
                        )
                    }

                    is ZipTreeSpec -> fileOperations.zipTree(it.file) as FileTreeInternal
                    is TarTreeSpec -> fileOperations.tarTree(it.file) as FileTreeInternal
                }
            }
            val tree = fileCollectionFactory.treeOf(fileTrees)
            isolate.identities.putInstance(id, tree)
            tree
        }

    private
    fun rootSpecOf(value: FileTreeInternal): List<FileTreeSpec> {
        val visitor = FileTreeVisitor()
        value.visitStructure(visitor)
        return visitor.roots
    }

    private
    class FileTreeVisitor : FileCollectionStructureVisitor {
        var roots = mutableListOf<FileTreeSpec>()

        override fun startVisit(
            source: FileCollectionInternal.Source,
            fileCollection: FileCollectionInternal
        ): Boolean = when {
            fileCollection is FileTreeAdapter -> {
                toSpecOrNull(fileCollection.tree)?.let {
                    roots.add(it)
                    false
                } ?: true
            }

            fileCollection is FileCollectionBackedFileTree -> {
                roots.add(WrappedFileCollectionTreeSpec(fileCollection.collection))
                false
            }

            fileCollection is FilteredFileTree && fileCollection.patterns.isEmpty -> {
                // Optimize a common case, where fileCollection.asFileTree.matching(emptyPatterns) is used, eg in SourceTask and in CopySpec
                // Skip applying the filters to the tree
                fileCollection.tree.visitStructure(this)
                false
            }

            else -> {
                true
            }
        }

        override fun visitCollection(
            source: FileCollectionInternal.Source,
            contents: Iterable<File>
        ) =
            throw UnsupportedOperationException()

        override fun visitGenericFileTree(
            fileTree: FileTreeInternal,
            sourceTree: FileSystemMirroringFileTree
        ) {
            // Visit the contents to create the mirror
            sourceTree.visit(object : FileVisitor {
                override fun visitFile(fileDetails: FileVisitDetails) {
                    fileDetails.file
                }

                override fun visitDir(dirDetails: FileVisitDetails) {
                    dirDetails.file
                }
            })
            val mirror = sourceTree.mirror
            roots.add(DirectoryTreeSpec(mirror.dir, mirror.patterns))
        }

        override fun visitFileTree(root: File, patterns: PatternSet, fileTree: FileTreeInternal) {
            roots.add(DirectoryTreeSpec(root, patterns))
        }

        override fun visitFileTreeBackedByFile(
            file: File,
            fileTree: FileTreeInternal,
            sourceTree: FileSystemMirroringFileTree
        ) {
            roots.add(toSpec(sourceTree))
        }

        private
        fun toSpec(tree: MinimalFileTree): FileTreeSpec =
            toSpecOrNull(tree) ?: cannotCreateSpecFor(tree)

        private
        fun toSpecOrNull(tree: MinimalFileTree): FileTreeSpec? = when (tree) {
            // TODO - deal with tree that is not backed by a file
            is ZipFileTree -> ZipTreeSpec(tree.backingFileProvider)
            is TarFileTree -> TarTreeSpec(tree.backingFileProvider)
            // TODO - capture the patterns
            is FilteredMinimalFileTree -> toSpecOrNull(tree.tree)
            is GeneratedSingletonFileTree -> GeneratedTreeSpec(tree.toSpec())
            is DirectoryFileTree -> DirectoryTreeSpec(tree.dir, tree.patternSet)
            else -> null
        }

        private
        fun cannotCreateSpecFor(tree: MinimalFileTree): Nothing =
            throw UnsupportedOperationException("Cannot create spec for file tree '$tree' of type '${tree.javaClass}'.")
    }
}
