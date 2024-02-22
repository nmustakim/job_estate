import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/services/navigation_service.dart';


import '../../controllers/auth/auth_controller.dart';
import '../../core/states/base_states.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.only(left: 16.w, top: 68.h, right: 16.w),
                    child: Column(children: [
                      SizedBox(height: 50.h),
                      _buildPageHeader(context),
                      SizedBox(height: 28.h),
                      CustomTextFormField(
                          validator:(value)=> Validator.validateEmail(value: value),
                          controller: emailController,
                          hintText: "Your email",
                          textInputType: TextInputType.emailAddress,
                          prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgMail,
                                  height: 24.h,
                                  width: 24.w)),
                          prefixConstraints: BoxConstraints(maxHeight: 48.h),
                          contentPadding: EdgeInsets.only(
                              top: 15.h, right: 30.h, bottom: 15.h)),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        validator:(value)=> Validator.validatePassword(value: value),
                          controller: passwordController,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgLock,
                                  height: 24.h,
                                  width: 24.w)),
                          prefixConstraints: BoxConstraints(maxHeight: 48.h),
                          obscureText: true,
                          contentPadding: EdgeInsets.only(
                              top: 15.h, right: 30.h, bottom: 15.h)),
                      SizedBox(height: 16.h),
                      Consumer(
                        builder:(context,ref,_) {
                          final authState = ref.watch(authenticationProvider);
                          return CustomElevatedButton(
                              buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: authState is LoadingState
                                      ? Colors.grey : theme.primaryColor
                              ),
                              text: authState is LoadingState
                                  ? "PLease wait..."
                                  : "Sign in",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (!(authState is LoadingState)) {
                                    await ref
                                        .read(authenticationProvider.notifier)
                                        .signIn(context,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                    emailController.clear();
                                    passwordController.clear();
                                  }
                                }
                              });

                        }
                      ),
                      SizedBox(height: 17.h),
                      Text("Forgot password",
                          style: CustomTextStyles.labelLargePrimary),
                      SizedBox(height: 7.h),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Don't have an account",
                            style: theme.textTheme.bodySmall,
                          ),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "Register",
                            style: CustomTextStyles.labelLargePrimary_1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              NavigationService.navigateToNamedRoute(AppRoutes.registerScreen);

                              },
                          )
                        ]),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5.h)
                    ])))));
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
      Text("Welcome to JobEstate", style: theme.textTheme.titleMedium),
      SizedBox(height: 10.h),
      Text("Sign in to continue", style: theme.textTheme.bodySmall)
    ]);
  }


}
