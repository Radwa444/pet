import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pet_shop/base/color_data.dart';
import 'package:pet_shop/base/constant.dart';
import 'package:pet_shop/base/data_file.dart';
import 'package:pet_shop/base/get/bottom_selection_controller.dart';
import 'package:pet_shop/base/get/route_key.dart';
import 'package:pet_shop/base/widget_utils.dart';
import '../../../base/fetch_pixels.dart';
import '../../lists/best_selling_list.dart';
import '../../model_ui/model_favourite.dart';

class TabFavourite extends StatefulWidget {
  const TabFavourite({Key? key}) : super(key: key);

  @override
  State<TabFavourite> createState() => _TabFavouriteState();
}

class _TabFavouriteState extends State<TabFavourite> {
  @override
  void initState() {
    super.initState();
  }

  List<ModelFavourite> favouriteList = DataFile.getAllFavList();

  BottomItemSelectionController bottomController =
      Get.find<BottomItemSelectionController>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double margin = FetchPixels.getDefaultHorSpaceFigma(context);
    int crossCount = 2;
    double screenWidth = context.width - (margin * 2) + margin;
    double itemWidth = screenWidth / crossCount;
    double itemHeight = 220.h;

    return Column(
      children: [
        getDefaultHeader(context, "My Favourite", () {},
            isShowSearch: false, isShowBack: false),
        20.h.verticalSpace,
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            color: getCardColor(context),
            child: (favouriteList.isNotEmpty)
                ? GridView.count(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    crossAxisCount: crossCount,
                    mainAxisSpacing: margin,
                    crossAxisSpacing: margin,
                    childAspectRatio: itemWidth / itemHeight,
                    children: List.generate(favouriteList.length, (index) {
                      ModelFavourite favourite = favouriteList[index];
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
                          child: buildCommonProductView(context,
                              favourite.image, favourite.name, favourite.price,
                              isFav: true),
                        ),
                      );
                    }))
                : getEmptyWidget(
                    context,
                    "no_favourite.png",
                    "No Favourite Yet!",
                    "Explore more and shortlist some products.",
                    "Add", () {
                    bottomController.changePos(0);
                    // Constant.sendToNext(context, homeScreenRoute);
                  }),
          ),
        ),
      ],
    );
  }
}
