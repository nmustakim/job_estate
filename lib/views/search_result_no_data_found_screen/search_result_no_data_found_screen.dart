import 'package:flutter/material.dart';


import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';
import '../../utils/size_utils.dart';
import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';

class SearchResultNoDataFoundScreen extends StatelessWidget {
  SearchResultNoDataFoundScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 11.v),
          child: Column(
            children: [
              Divider(),
              SizedBox(height: 15.v),
              _buildResultCounter(context),
              Spacer(
                flex: 31,
              ),
              _buildNoData(context),
              SizedBox(height: 16.v),
              CustomElevatedButton(
                text: "lbl_back_to_home",
                margin: EdgeInsets.symmetric(horizontal: 16.h),
              ),
              Spacer(
                flex: 68,
              ),
            ],
          ),
        ),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitleSearchview(
        margin: EdgeInsets.only(left: 16.h),
        hintText: "lbl_search_product",
        controller: searchController,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgSort,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 16.v,
            right: 16.h,
          ),
        ),
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilter,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 16.v,
            right: 32.h,
          ),
        ),
      ],
    );
  }


  Widget _buildResultCounter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.5,
            child: Padding(
              padding: EdgeInsets.only(bottom: 4.v),
              child: Text(
                "lbl_0_result",
                style: CustomTextStyles.labelLargeOnPrimary,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 2.v,
              bottom: 3.v,
            ),
            child: Text(
              "lbl_man_shoes",
              style: theme.textTheme.labelLarge,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgDownIcon,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.only(left: 8.h),
          ),
        ],
      ),
    );
  }


  Widget _buildNoData(BuildContext context) {
    return Column(
      children: [
        CustomIconButton(
          height: 72.adaptSize,
          width: 72.adaptSize,
          padding: EdgeInsets.all(28.h),
          decoration: IconButtonStyleHelper.outlinePrimary,
          child: CustomImageView(
            imagePath: ImageConstant.imgCloseOnprimarycontainer,
          ),
        ),
        SizedBox(height: 15.v),
        Text(
          "msg_product_not_found",
          style: CustomTextStyles.headlineSmallOnPrimary,
        ),
        SizedBox(height: 11.v),
        Text(
          "msg_thank_you_for_shopping",
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
