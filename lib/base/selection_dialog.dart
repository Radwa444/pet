import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/widget_utils.dart';

import 'color_data.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool? showCountryOnly;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;
  final double flagWidth;
  final Decoration? flagDecoration;

  // final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;

  /// Background color of SelectionDialog
  final Color? backgroundColor;

  /// Boxshaow color of SelectionDialog that matches CountryCodePicker barrier color
  final Color? barrierColor;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(
    this.elements,
    this.favoriteElements, {
    Key? key,
    this.showCountryOnly,
    this.emptySearchBuilder,
    InputDecoration searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.textStyle,
    this.boxDecoration,
    this.showFlag,
    this.flagDecoration,
    this.flagWidth = 32,
    // this.size,
    this.backgroundColor,
    this.barrierColor,
    this.hideSearch = false,
    this.closeIcon,
  })  : searchDecoration = searchDecoration.prefixIcon == null
            ? searchDecoration.copyWith(prefixIcon: const Icon(Icons.search))
            : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  late List<CountryCode> filteredElements;
  TextEditingController searchController = TextEditingController();
  RxBool isSearch = false.obs;

  backClick(BuildContext context) {
    if (isSearch.value) {
      isSearch.value = false;
    } else {
      Constant.backToFinish(context);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
              leading: getBackIcon(context, () {
                backClick(context);
              }, colors: getFontColor(context)),
              title: ObxValue<RxBool>(
                  (p0) => (p0.value)
                      ? TextField(
                          onChanged: _filterElements,
                          key: Key('SearchBarTextField'),
                          keyboardType: TextInputType.text,
                          style: buildTextStyle(context, getFontColor(context),
                              FontWeight.w700, 16),
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: buildTextStyle(context,
                                  getFontHint(context), FontWeight.w700, 16),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none),
                          onSubmitted: (String val) async {
                            // if (closeOnSubmit) {
                            //   await Navigator.maybePop(context);
                            // }
                            //
                            // if (clearOnSubmit) {
                            //   controller.clear();
                            // }
                            // onSubmitted?.call(val);
                          },
                          autofocus: true,
                          controller: searchController,
                        )
                      : getCustomFont(
                          "Select Country", 22, getFontColor(context), 1,
                          fontWeight: FontWeight.w700),
                  isSearch),
              actions: [
                ObxValue<RxBool>(
                        (p0) => (p0.value)
                            ? InkWell(
                                onTap: () {
                                  isSearch.value = false;
                                  searchController.clear();
                                },
                                child: getSvgImageWithSize(
                                    context, "close.svg", 24.h, 24.h,
                                    fit: BoxFit.scaleDown),
                              )
                            : InkWell(
                                onTap: () {
                                  isSearch.value = true;
                                },
                                child: getSvgImageWithSize(
                                    context, "search.svg", 24.h, 24.h,
                                    fit: BoxFit.scaleDown)),
                        isSearch)
                    .paddingOnly(
                        right: FetchPixels.getDefaultHorSpaceFigma(context))
              ]),
          backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
          // body: Column(
          //   children: [
          //     if (!widget.hideSearch)
          //       getDefaultTextFiled(context, "Search", searchController,
          //           getFontColor(context), _filterElements,
          //           withPrefix: true, imgName: "search.svg"),
          //
          //     widget.favoriteElements.isEmpty
          //         ? const DecoratedBox(decoration: BoxDecoration())
          //         : Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               ...widget.favoriteElements.map(
          //                 (f) => SimpleDialogOption(
          //                   child: _buildOption(f),
          //                   onPressed: () {
          //                     _selectItem(f);
          //                   },
          //                 ),
          //               ),
          //               // const Divider(),
          //             ],
          //           ),
          //     if (filteredElements.isEmpty)
          //       _buildEmptySearchWidget(context)
          //     else
          //       ...filteredElements.map(
          //         (e) => SimpleDialogOption(
          //           child: _buildOption(e),
          //           onPressed: () {
          //             _selectItem(e);
          //           },
          //         ),
          //       )
          //     // Expanded(
          //     //   child: ListView(
          //     //     children: [
          //     //       widget.favoriteElements.isEmpty
          //     //           ? const DecoratedBox(decoration: BoxDecoration())
          //     //           : Column(
          //     //               crossAxisAlignment: CrossAxisAlignment.start,
          //     //               children: [
          //     //                 ...widget.favoriteElements.map(
          //     //                   (f) => SimpleDialogOption(
          //     //                     child: _buildOption(f),
          //     //                     onPressed: () {
          //     //                       _selectItem(f);
          //     //                     },
          //     //                   ),
          //     //                 ),
          //     //                 const Divider(),
          //     //               ],
          //     //             ),
          //     //       if (filteredElements.isEmpty)
          //     //         _buildEmptySearchWidget(context)
          //     //       else
          //     //         ...filteredElements.map(
          //     //           (e) => SimpleDialogOption(
          //     //             child: _buildOption(e),
          //     //             onPressed: () {
          //     //               _selectItem(e);
          //     //             },
          //     //           ),
          //     //         ),
          //     //     ],
          //     //   ),
          //     // ),
          //   ],
          body: ListView(
            children: [
              widget.favoriteElements.isEmpty
                  ? const DecoratedBox(decoration: BoxDecoration())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...widget.favoriteElements.map(
                          (f) => SimpleDialogOption(
                            child: _buildOption(f),
                            onPressed: () {
                              _selectItem(f);
                            },
                          ),
                        ),
                        // const Divider(),
                      ],
                    ),
              if (filteredElements.isEmpty)
                _buildEmptySearchWidget(context)
              else
                ...filteredElements.map(
                  (e) => SimpleDialogOption(
                    child: _buildOption(e),
                    onPressed: () {
                      _selectItem(e);
                    },
                  ),
                )
              // Expanded(
              //   child: ListView(
              //     children: [
              //       widget.favoriteElements.isEmpty
              //           ? const DecoratedBox(decoration: BoxDecoration())
              //           : Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 ...widget.favoriteElements.map(
              //                   (f) => SimpleDialogOption(
              //                     child: _buildOption(f),
              //                     onPressed: () {
              //                       _selectItem(f);
              //                     },
              //                   ),
              //                 ),
              //                 const Divider(),
              //               ],
              //             ),
              //       if (filteredElements.isEmpty)
              //         _buildEmptySearchWidget(context)
              //       else
              //         ...filteredElements.map(
              //           (e) => SimpleDialogOption(
              //             child: _buildOption(e),
              //             onPressed: () {
              //               _selectItem(e);
              //             },
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
            ],
          )),

      // ),

      onWillPop: () async {
        backClick(context);

        return false;
      });

// buildTitleDefaultWidget(context, "Select Country", "", () {
//   Constant.backToPrev(context);
// },
//     Column(
//       children: [
//
//         if (!widget.hideSearch)
//           getDefaultTextFiled(context, "Search", searchController,
//               getFontColor(context), _filterElements,
//               withPrefix: true, imgName: "search.svg"),
//
//         widget.favoriteElements.isEmpty
//             ? const DecoratedBox(decoration: BoxDecoration())
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ...widget.favoriteElements.map(
//                     (f) => SimpleDialogOption(
//                       child: _buildOption(f),
//                       onPressed: () {
//                         _selectItem(f);
//                       },
//                     ),
//                   ),
//                   // const Divider(),
//                 ],
//               ),
//         if (filteredElements.isEmpty)
//           _buildEmptySearchWidget(context)
//         else
//           ...filteredElements.map(
//             (e) => SimpleDialogOption(
//               child: _buildOption(e),
//               onPressed: () {
//                 _selectItem(e);
//               },
//             ),
//           )
//         // Expanded(
//         //   child: ListView(
//         //     children: [
//         //       widget.favoriteElements.isEmpty
//         //           ? const DecoratedBox(decoration: BoxDecoration())
//         //           : Column(
//         //               crossAxisAlignment: CrossAxisAlignment.start,
//         //               children: [
//         //                 ...widget.favoriteElements.map(
//         //                   (f) => SimpleDialogOption(
//         //                     child: _buildOption(f),
//         //                     onPressed: () {
//         //                       _selectItem(f);
//         //                     },
//         //                   ),
//         //                 ),
//         //                 const Divider(),
//         //               ],
//         //             ),
//         //       if (filteredElements.isEmpty)
//         //         _buildEmptySearchWidget(context)
//         //       else
//         //         ...filteredElements.map(
//         //           (e) => SimpleDialogOption(
//         //             child: _buildOption(e),
//         //             onPressed: () {
//         //               _selectItem(e);
//         //             },
//         //           ),
//         //         ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     ));

// WillPopScope(
// child: Scaffold(
//     body: Padding(
//   padding: const EdgeInsets.all(0.0),
//   child: Container(
//     clipBehavior: Clip.hardEdge,
//     width: widget.size?.width ?? MediaQuery.of(context).size.width,
//     height:
//         widget.size?.height ?? MediaQuery.of(context).size.height * 0.85,
//     decoration: widget.boxDecoration ??
//         BoxDecoration(
//           color: widget.backgroundColor ?? Colors.white,
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//           boxShadow: [
//             BoxShadow(
//               color: widget.barrierColor ?? Colors.grey.withOpacity(1),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         IconButton(
//           padding: const EdgeInsets.all(0),
//           iconSize: 20,
//           icon: widget.closeIcon!,
//           onPressed: () => Navigator.pop(context),
//         ),
//         if (!widget.hideSearch)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: TextField(
//               style: widget.searchStyle,
//               decoration: widget.searchDecoration,
//               onChanged: _filterElements,
//             ),
//           ),
//         Expanded(
//           child: ListView(
//             children: [
//               widget.favoriteElements.isEmpty
//                   ? const DecoratedBox(decoration: BoxDecoration())
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ...widget.favoriteElements.map(
//                           (f) => SimpleDialogOption(
//                             child: _buildOption(f),
//                             onPressed: () {
//                               _selectItem(f);
//                             },
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     ),
//               if (filteredElements.isEmpty)
//                 _buildEmptySearchWidget(context)
//               else
//                 ...filteredElements.map(
//                   (e) => SimpleDialogOption(
//                     child: _buildOption(e),
//                     onPressed: () {
//                       _selectItem(e);
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// )),
// onWillPop: () async {
//   return false;
// });

  Widget _buildOption(CountryCode e) {
    return Container(
      decoration: getButtonDecoration(Colors.transparent,
          borderColor: getDividerColor(context),
          withCorners: true,
          withBorder: true,
          corner: 22.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.showFlag!)
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  decoration: widget.flagDecoration,
                  clipBehavior:
                      widget.flagDecoration == null ? Clip.none : Clip.hardEdge,
                  child: Image.asset(
                    e.flagUri!,
                    package: 'country_code_picker',
                    width: 40.h,
                    height: 28.h,
                  ),
                ),
              Expanded(
                flex: 1,
                child: getCustomFont(
                    e.toCountryStringOnly(), 16, getFontColor(context), 1,
                    fontWeight: FontWeight.w400),
              ),
              getCustomFont(e.dialCode ?? "", 16, getFontColor(context), 1,
                  fontWeight: FontWeight.w400)
              // Expanded(
              //   flex: 4,
              //   child: Text(
              //     widget.showCountryOnly!
              //         ? e.toCountryStringOnly()
              //         : e.toLongString(),
              //     overflow: TextOverflow.fade,
              //     style: widget.textStyle,
              //   ),
              // ),
            ],
          )
          // getDivider()
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text(CountryLocalizations.of(context)?.translate('no_country') ??
          'No country found'),
    );
  }

  @override
  void initState() {
    filteredElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements
          .where((e) =>
              e.code!.contains(s) ||
              e.dialCode!.contains(s) ||
              e.name!.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    print("getvals--back$e");
    Get.back(result: e);
    // Navigator.pop(context, e);
  }
}
