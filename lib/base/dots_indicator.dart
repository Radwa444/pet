import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    Key? key,
    this.controller,
    this.itemCount,
    this.selectedPos,
    this.onPageSelected,
    this.selectedColor = Colors.black,
    this.size = 10,
    this.color = Colors.white,
  }) : super(key: key, listenable: controller!);

  final PageController? controller;

  final int? itemCount;
  final int? selectedPos;
  final double size;

  final ValueChanged<int>? onPageSelected;

  final Color color;
  final Color selectedColor;

  Widget _buildDot(int index) {
    return SizedBox(
      width: size.h,
      child: Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          color: (selectedPos == index) ? selectedColor : color,
          // type: MaterialType.circle,
          child: SizedBox(
            width: size.h,
            height: size.h,
            child: InkWell(
              onTap: () => onPageSelected!(index),
            ),
          ),
        ),
      ),
    ).marginSymmetric(horizontal: 6.w);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount!, _buildDot),
    );
  }
}
