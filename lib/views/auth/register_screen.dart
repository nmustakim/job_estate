import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/controllers/auth/auth_controller.dart';

import '../../core/states/base_states.dart';
import '../../routes/app_routes.dart';
import '../../services/navigation_service.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';
import '../../utils/lists.dart';

import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController usertypeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 50.h),
                            _buildPageHeader(context),
                            SizedBox(height: 30.h),
                            _buildFullName(context),
                            SizedBox(height: 8.h),
                            _buildEmail(context),
                            SizedBox(height: 8.h),
                            _buildGender(context),
                            SizedBox(height: 8.h),
                            _buildUserType(context),
                            SizedBox(height: 8.h),
                            _buildPassword(context),
                            SizedBox(height: 8.h),
                            _buildPasswordAgain(context),
                            SizedBox(height: 20.h),
                            _buildSignUp(context),
                            SizedBox(height: 20.h),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Have an account",
                                  style: theme.textTheme.bodySmall,
                                ),
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: "Sign in",
                                  style: CustomTextStyles.labelLargePrimary_1,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      NavigationService.navigateToNamedRoute(
                                          AppRoutes.loginScreen);
                                    },
                                )
                              ]),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 5.h)
                          ]))),
            )));
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(children: [
      CustomIconButton(
          height: 72.h,
          width: 72.w,
          padding: EdgeInsets.all(20.h),
          decoration: IconButtonStyleHelper.fillPrimary,
          child: CustomImageView(imagePath: ImageConstant.imgLogo)),
      SizedBox(height: 16.h),
      Text("Let's get started", style: theme.textTheme.titleMedium),
      SizedBox(height: 9.h),
      Text("Create new account", style: theme.textTheme.bodySmall)
    ]);
  }

  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
        controller: fullNameController,
        hintText: "Full name",
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgUser,
                height: 24.h,
                width: 24.w)),
        prefixConstraints: BoxConstraints(maxHeight: 48.h),
        contentPadding: EdgeInsets.only(top: 15.w, right: 30.w, bottom: 15.h));
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgMail,
                height: 24.h,
                width: 24.w)),
        prefixConstraints: BoxConstraints(maxHeight: 48.h),
        contentPadding: EdgeInsets.only(top: 15.h, right: 30.w, bottom: 15.h));
  }

  Widget _buildUserType(BuildContext context) {
    return CustomTextFormField(
        controller: usertypeController,

        textInputType: TextInputType.text,
        suffix: CustomDropdownFormField(
          leftPadding: 46.h,
          hintText: "User type",
          items: Lists().userType,
          onChanged: (value) {
            setState(() {
              usertypeController.text = value ?? '';
            });
          },
        ),
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgUserPrimary,
                color: Colors.grey,
                height: 24.h,
                width: 24.w)),
        prefixConstraints: BoxConstraints(maxHeight: 48.h),
        contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h));
  }

  Widget _buildGender(BuildContext context) {
    return CustomTextFormField(
        controller: genderController,

        textInputType: TextInputType.text,
        suffix: CustomDropdownFormField(
          leftPadding: 46.h,
          hintText: "Gender",
          items: Lists().genderType,
          onChanged: (value) {
            setState(() {
              genderController.text = value ?? '';
            });
          },
        ),
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgGenderIcon,
                color: Colors.grey,
                height: 24.h,
                width: 24.w)),
        prefixConstraints: BoxConstraints(maxHeight: 48.h),
        contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h));
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.h, 10.h, 12.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.h,
                width: 24.w)),
        prefixConstraints: BoxConstraints(maxHeight: 48.h),
        obscureText: true,
        contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h));
  }

  Widget _buildPasswordAgain(BuildContext context) {
    return CustomTextFormField(
        controller: retypePasswordController,
        hintText: "Password again",
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
        contentPadding: EdgeInsets.only(top: 15.h, right: 30.h, bottom: 15.h));
  }

  Widget _buildSignUp(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final authState = ref.watch(authenticationProvider);
      return CustomElevatedButton(
          buttonStyle: ElevatedButton.styleFrom(
              backgroundColor:
                  authState is LoadingState ? Colors.grey : theme.primaryColor),
          text: authState is LoadingState ? "Please wait..." : "Sign up",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (!(authState is LoadingState)) {
                await ref.read(authenticationProvider.notifier).signUp(userType: usertypeController.text,gender:genderController.text,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    fullName: fullNameController.text,

                );
                fullNameController.clear();
                emailController.clear();
                passwordController.clear();
              }
            }
          });
    });
  }

  onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
