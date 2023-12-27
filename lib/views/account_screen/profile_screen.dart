import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/core/states/base_states.dart';

import '../../constants/image_constant.dart';
import '../../controllers/user/userStates.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/theme_helper.dart';
import '../../utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final user = userState is FetchUserSuccessState ? userState.user:null;
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 36.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                    imagePath:
                                    user!.profileImageUrl,
                                    height: 72.adaptSize,
                                    width: 72.adaptSize,
                                    radius: BorderRadius.circular(36.h)),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.h, top: 9.v, bottom: 14.v),
                                    child: Column(children: [
                                      Text("dominic_ovo",
                                          style: theme.textTheme.titleSmall),
                                      SizedBox(height: 8.v),
                                      Text("dominic_ovo2",
                                          style: theme.textTheme.bodySmall)
                                    ]))
                              ])),
                      SizedBox(height: 32.v),
                      _buildProfileDetailOption(context,
                          dateIcon: ImageConstant.imgGenderIcon,
                          birthday: "gender",
                          birthDateValue: user.gender??""),
                      _buildProfileDetailOption(context,
                          dateIcon: ImageConstant.imgDateIcon,
                          birthday: "birthday",
                          birthDateValue:user.birthDate.toString()),
                      _buildProfileDetailOption(context,
                          dateIcon: ImageConstant.imgMailPrimary,
                          birthday: "email",
                          birthDateValue: user.email),
                      SizedBox(height: 5.v),
                      _buildProfileDetailOption(context,
                          dateIcon: ImageConstant.imgLockPrimary,
                          birthday: "change_password",
                          birthDateValue: "msg",
                          onTapProfileDetailOption: () {
                            onTapProfileDetailOption(context);
                          })
                    ]))));
  }

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
            text: "profile", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Common widget
  Widget _buildProfileDetailOption(
      BuildContext context, {
        required String dateIcon,
        required String birthday,
        required String birthDateValue,
        Function? onTapProfileDetailOption,
      }) {
    return GestureDetector(
        onTap: () {
          onTapProfileDetailOption!.call();
        },
        child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 15.v),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(children: [
              CustomImageView(
                  imagePath: dateIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 3.v, bottom: 2.v),
                  child: Text(birthday,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onPrimary.withOpacity(1)))),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 2.v, bottom: 3.v),
                  child: Text(birthDateValue,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: appTheme.blueGray300))),
              CustomImageView(
                  imagePath: ImageConstant.imgRightIcon,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  margin: EdgeInsets.only(left: 16.h))
            ])));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the changePasswordScreen when the action is triggered.
  onTapProfileDetailOption(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.changePasswordScreen);
  }
}
