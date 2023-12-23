
import 'package:flutter/material.dart';
import 'package:job_estate/views/favorite_screen/widgets/favoriteproduct_item_widget.dart';

import '../../constants/image_constant.dart';
import '../../routes/app_routes.dart';
import '../../utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(left: 16.h, top: 8.v, right: 16.h),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 283.v,
                        crossAxisCount: 2,
                        mainAxisSpacing: 13.h,
                        crossAxisSpacing: 13.h),
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return FavoriteItemWidget(onTapProductItem: () {
                        onTapItem(context);
                      });
                    }))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 40.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftBlueGray300,
            margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarSubtitle(
            text: "msg_favorite_product",
            margin: EdgeInsets.only(left: 12.h)));
  }

  /// Navigates to the productDetailScreen when the action is triggered.
  onTapItem(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.jobDetailsScreen);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
