
import 'package:flutter/material.dart';
import 'package:job_estate/main.dart';
import 'package:job_estate/views/account_screen/publish_job_screen.dart';


import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';
import '../../utils/size_utils.dart';
import '../../widgets/custom_image_view.dart';
import '../home_container_screen/home_container_screen.dart';
import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeContainerScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.v),
              CustomImageView(
                imagePath: ImageConstant.imgLogo,
                height: 100.adaptSize,
                width: 100.adaptSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
