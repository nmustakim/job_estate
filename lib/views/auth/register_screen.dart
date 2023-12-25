import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/controllers/auth/auth_controller.dart';

import '../../core/states/base_states.dart';
import '../../routes/app_routes.dart';
import '../../services/navigation_service.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';
import '../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController retypePasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPageHeader(context),
                          SizedBox(height: 30.v),
                          _buildFullName(context),
                          SizedBox(height: 8.v),
                          _buildEmail(context),
                          SizedBox(height: 8.v),
                          _buildPassword(context),
                          SizedBox(height: 8.v),
                          _buildPasswordAgain(context),
                          SizedBox(height: 20.v),
                          _buildSignUp(context),
                          SizedBox(height: 20.v),
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
                          SizedBox(height: 5.v)
                        ])))));
  }

  Widget _buildPageHeader(BuildContext context) {
    return Column(children: [
      CustomIconButton(
          height: 72.adaptSize,
          width: 72.adaptSize,
          padding: EdgeInsets.all(20.h),
          decoration: IconButtonStyleHelper.fillPrimary,
          child: CustomImageView(imagePath: ImageConstant.imgLogo)),
      SizedBox(height: 16.v),
      Text("Let's get started", style: theme.textTheme.titleMedium),
      SizedBox(height: 9.v),
      Text("Create new account", style: theme.textTheme.bodySmall)
    ]);
  }

  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
        controller: fullNameController,
        hintText: "Full name",
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgUser,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        contentPadding: EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgMail,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        contentPadding: EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
  }

  Widget _buildPasswordAgain(BuildContext context) {
    return CustomTextFormField(
        controller: retypePasswordController,
        hintText: "Password again",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLock,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(top: 15.v, right: 30.h, bottom: 15.v));
  }

  Widget _buildSignUp(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
    final  authState = ref.watch(authenticationProvider);
      return CustomElevatedButton(
          buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: authState is LoadingState
                  ? Colors.grey : theme.primaryColor
          ),
          text: authState is LoadingState ?"Please wait...":"Sign up",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (!(authState is LoadingState)) {
                await ref.read(authenticationProvider.notifier).signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    fullName: fullNameController.text);
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
