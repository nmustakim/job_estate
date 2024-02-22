import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/image_constant.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';


// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();

  TextEditingController newpasswordController = TextEditingController();

  TextEditingController newpasswordController1 = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar:  CustomAppBar(
                leadingWidth: 40.h,
                leading: AppbarLeadingImage(
                    imagePath: ImageConstant.imgArrowLeftBlueGray300,
                    margin: EdgeInsets.only(left: 16.h, top: 14.h, bottom: 17.h),
                    onTap: () {
                      onTapArrowLeft(context);
                    }),
                title: AppbarSubtitle(
                    text: "Change Password",
                    margin: EdgeInsets.only(left: 12.h))),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.h, vertical: 26.h),
                    child: Column(children: [
                      _buildOldPassword(context),
                      SizedBox(height: 23.h),
                      _buildNewPassword(context),
                      SizedBox(height: 24.h),
                      _buildConfirmPassword(context),
                      SizedBox(height: 5.h)
                    ]))),
            bottomNavigationBar: _buildSave(context)));
  }



  Widget _buildOldPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Old password", style: theme.textTheme.titleSmall),
      SizedBox(height: 12.h),
      CustomTextFormField(
          controller: passwordController,
          hintText: "Enter old password",
          hintStyle: CustomTextStyles.labelLargeBluegray300,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLock,
                  height: 24.h,
                  width: 24.w)),
          prefixConstraints: BoxConstraints(maxHeight: 48.h),
          obscureText: true,
          contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
          filled: false)
    ]);
  }


  Widget _buildNewPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("New password", style: theme.textTheme.titleSmall),
      SizedBox(height: 12.h),
      CustomTextFormField(
          controller: newpasswordController,
          hintText: "Enter new password",
          hintStyle: CustomTextStyles.labelLargeBluegray300,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLock,
                  height: 24.h,
                  width: 24.w)),
          prefixConstraints: BoxConstraints(maxHeight: 48.h),
          obscureText: true,
          contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
          filled: false)
    ]);
  }


  Widget _buildConfirmPassword(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("New password again", style: theme.textTheme.titleSmall),
      SizedBox(height: 11.h),
      CustomTextFormField(
          controller: newpasswordController1,
          hintText: "Enter new password again",
          hintStyle: CustomTextStyles.labelLargeBluegray300,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLock,
                  height: 24.h,
                  width: 24.w)),
          prefixConstraints: BoxConstraints(maxHeight: 48.h),
          obscureText: true,
          contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h),
          borderDecoration: TextFormFieldStyleHelper.outlineBlueTL5,
          filled: false)
    ]);
  }


  Widget _buildSave(BuildContext context) {
    return CustomElevatedButton(
        text: "Save",
        margin: EdgeInsets.only(left: 16.h, right: 16.h, bottom: 50.h));
  }


  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
