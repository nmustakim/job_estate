import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/app_export/app_export.dart';


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
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.only(left: 16.h, top: 68.v, right: 16.h),
                    child: Column(children: [
                      SizedBox(height: 50.v),
                      _buildPageHeader(context),
                      SizedBox(height: 28.v),
                      CustomTextFormField(
                          validator:(value)=> Validator.validateEmail(value: value),
                          controller: emailController,
                          hintText: "Your email",
                          textInputType: TextInputType.emailAddress,
                          prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgMail,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          prefixConstraints: BoxConstraints(maxHeight: 48.v),
                          contentPadding: EdgeInsets.only(
                              top: 15.v, right: 30.h, bottom: 15.v)),
                      SizedBox(height: 10.v),
                      CustomTextFormField(
                        validator:(value)=> Validator.validatePassword(value: value),
                          controller: passwordController,
                          hintText: "Password",
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          prefix: Container(
                              margin:
                                  EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
                              child: CustomImageView(
                                  imagePath: ImageConstant.imgLock,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize)),
                          prefixConstraints: BoxConstraints(maxHeight: 48.v),
                          obscureText: true,
                          contentPadding: EdgeInsets.only(
                              top: 15.v, right: 30.h, bottom: 15.v)),
                      SizedBox(height: 16.v),
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
                                  }
                                }
                              });

                        }
                      ),
                      SizedBox(height: 17.v),
                      Text("Forgot password",
                          style: CustomTextStyles.labelLargePrimary),
                      SizedBox(height: 7.v),
                      GestureDetector(
                          onTap: () {
                            onNotHaveAccountPress(context);
                          },
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account",
                                    style: theme.textTheme.bodySmall),
                                const TextSpan(text: " "),
                                TextSpan(
                                    text: "Register",
                                    style: CustomTextStyles.labelLargePrimary_1)
                              ]),
                              textAlign: TextAlign.left)),
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
          child: CustomImageView(imagePath: ImageConstant.imgClose)),
      SizedBox(height: 16.v),
      Text("Welcome to JobEstate", style: theme.textTheme.titleMedium),
      SizedBox(height: 10.v),
      Text("Sign in to continue", style: theme.textTheme.bodySmall)
    ]);
  }

  onNotHaveAccountPress(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerScreen);
  }
}
