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

import org.gradle.configurationcache.extensions.uncheckedCast
import org.gradle.configurationcache.serialization.Codec
import org.gradle.configurationcache.serialization.ReadContext
import org.gradle.configurationcache.serialization.WriteContext
import org.gradle.configurationcache.serialization.readCollection
import org.gradle.configurationcache.serialization.writeCollection
import org.gradle.internal.event.AnonymousListenerBroadcast
import org.gradle.internal.event.ListenerManager


internal
class ListenerBroadcastCodec(private val listenerManager: ListenerManager) :
    Codec<AnonymousListenerBroadcast<*>> {
    override suspend fun WriteContext.encode(value: AnonymousListenerBroadcast<*>) {
        val broadcast: AnonymousListenerBroadcast<Any> = value.uncheckedCast()
        writeClass(value.type)
        val listeners = mutableListOf<Any>()
        broadcast.visitListeners {
            listeners.add(this)
        }
        writeCollection(listeners) {
            write(it)
        }
    }

    override suspend fun ReadContext.decode(): AnonymousListenerBroadcast<*> {
        val type: Class<Any> = readClass().uncheckedCast()
        val broadcast = listenerManager.createAnonymousBroadcaster(type)
        readCollection {
            val listener = read()
            broadcast.add(listener)
        }
        return broadcast
    }
}
