import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/services/navigation_service.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';
import '../../utils/size_utils.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                title: AppbarTitle(
                    text: "Account", margin: EdgeInsets.only(left: 16.h)),
                actions: [
                  AppbarTrailingImage(
                      imagePath: ImageConstant.imgNotificationIcon,
                      margin: EdgeInsets.fromLTRB(13.h, 15.v, 13.h, 16.v),
                      onTap: () {
                        onTapNotificationIcon(context);
                      })
                ]),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 11.v),
                child: Column(children: [
                  _buildAccountOption(context,
                      image: ImageConstant.imgProfile,
                      orderLabel: "Profile", onTapAccountOption: () {
                    NavigationService.navigateToNamedRoute(
                        AppRoutes.profileScreen);
                  }),
                  _buildAccountOption(context,
                      image: ImageConstant.imgCheckmark,
                      orderLabel: "Applied Jobs"),
                  SizedBox(height: 5.v),
                  _buildAccountOption(context,
                      image: ImageConstant.imgSave,
                      orderLabel: "Saved Jobs", onTapAccountOption: () {
                    onTapAccountOption1(context);
                  }),
                  SizedBox(height: 5.v),
                  _buildAccountOption(context,
                      image: ImageConstant.imgPublish,
                      orderLabel: "Publish job", onTapAccountOption: () {
                    onTapPublishJob(context);
                  }),
                  Consumer(builder: (context, ref, _) {
                    return OutlinedButton(
                        onPressed: () {
                          ref.read(authenticationProvider.notifier).signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoutes.loginScreen, (route) => false);
                        },
                        child: Text("Log out",
                            style: theme.textTheme.labelLarge!.copyWith(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(1))));
                  })
                ]))));
  }

  Widget _buildAccountOption(
    BuildContext context, {
    required String image,
    required String orderLabel,
    Function? onTapAccountOption,
  }) {
    return GestureDetector(
        onTap: () {
          onTapAccountOption?.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomImageView(
                  imagePath: image, height: 24.adaptSize, width: 24.adaptSize,color: Colors.grey,),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 2.v, bottom: 3.v),
                  child: Text(orderLabel,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1))))
            ])));
  }

  onTapNotificationIcon(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.notificationScreen);
  }

  onTapAccountOption1(BuildContext context) {}
  onTapPublishJob(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.publishJobScreen);
  }
}
