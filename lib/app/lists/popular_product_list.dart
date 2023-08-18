import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/fetch_pixels.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';
import '../model_ui/model_popular_product.dart';
import 'best_selling_list.dart';

class PopularProductList extends StatefulWidget {
  const PopularProductList({Key? key}) : super(key: key);

  @override
  State<PopularProductList> createState() => _PopularProductListState();
}

class _PopularProductListState extends State<PopularProductList> {
  backClick(BuildContext context) {
    Constant.backToPrev(context);
  }

  List<ModelPopularProduct> popularProductList =
      DataFile.getAllPopularProductList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 220.h;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: getScaffoldColor(context),
          body: Column(
            children: [
              getDefaultHeader(context, "Popular Products", () {
                backClick(context);
              }, isShowSearch: false, withFilter: true),
              20.h.verticalSpace,
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
                  color: getCardColor(context),
                  child: GridView.count(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      crossAxisCount: crossCount,
                      mainAxisSpacing: margin,
                      crossAxisSpacing: margin,
                      childAspectRatio: itemWidth / itemHeight,
                      children:
                          List.generate(popularProductList.length, (index) {
                        ModelPopularProduct product = popularProductList[index];
                        return InkWell(
                          onTap: () {
                            Constant.sendToNext(
                                context, productDetailScreenRoute);
                          },
                          child: Container(
                            height: itemHeight,
                            width: itemWidth,
                            decoration: getButtonDecoration(
                              getCardColor(context),
                            ),
                            child: buildCommonProductView(context, product.img,
                                product.name, product.price),
                          ),
                        );
                      })),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          backClick(context);
          return false;
        });
  }
}
