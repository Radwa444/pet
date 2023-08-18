import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/widget_utils.dart';

class CheckOutSlider extends StatefulWidget {
  double itemSize;
  List<String> icons;
  List<String> filledIcons;
  int currentPos;
  Color completeColor;
  Color currentColor;

  CheckOutSlider(
      {Key? key,
      this.itemSize = 20,
      required this.icons,
      required this.filledIcons,
      required this.currentPos,
      required this.completeColor,
      required this.currentColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckOutSlider();
  }
}

class _CheckOutSlider extends State<CheckOutSlider> {
  @override
  Widget build(BuildContext context) {
    // List<Widget> widgetList=<Widget>...widget.icons.map((e) {}).toList();
    List<Widget> list = <Widget>[
      for (int i = 0; i < widget.icons.length; i++) ...<Widget>[
        getSvgImageWithSize(
          context,
          (i < widget.currentPos) ? widget.filledIcons[i] : widget.icons[i],
          widget.itemSize.h, widget.itemSize.h,
          // color:  (i < widget.currentPos)?:null
        ),
        // color: (i < widget.currentPos)
        //     ? widget.completeColor
        //     : widget.currentColor),
        (i != widget.icons.length - 1)
            ? Expanded(
                flex: 1,
                child: DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: (i < widget.currentPos)
                      ? widget.completeColor
                      : widget.currentColor,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ).marginSymmetric(horizontal: 5.w),
              )
            : 0.horizontalSpace
      ]
    ];
    // Container(
    //   child: Text(title),
    // ),
    // Container(
    //   child: Text(description),
    // ),

    Constant.setupSize(context);
    return Row(
      children: list,
    );
  }
}
