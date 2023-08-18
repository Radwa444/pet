import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/app/home/tabs/tab_home.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';

import '../model_ui/model_blog.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BlogScreen();
  }
}

class _BlogScreen extends State<BlogScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelBlog> blogList = DataFile.getAllBlog();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        backgroundColor: getScaffoldColor(context),
        body: Column(
          children: [
            getDefaultHeader(context, "Blog", () {
              backClick();
            }, isShowSearch: false),
            20.h.verticalSpace,
            Expanded(
                child: Container(
              color: getCardColor(context),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: blogList.length,
                itemBuilder: (context, index) {
                  ModelBlog blog = blogList[index];
                  return GestureDetector(
                    onTap: () {
                      Constant.sendToNext(context, blogDetailScreenRoute);
                    },
                    child: buildCommonBlogView(
                        horSpace, context, blog.name, blog.image, blog.date),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return getDivider(
                          setColor: Colors.grey.shade300, dividerHeight: 1)
                      .marginSymmetric(vertical: 20.h, horizontal: 20.h);
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
