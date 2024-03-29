import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/controllers/user/favorite_jobs_controller.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/routes/app_routes.dart';
import 'package:job_estate/services/navigation_service.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/jobs/job_controller.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';

import '../../widgets/custom_image_view.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key})
      : super(
    key: key,
  );

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      _authSubscription = ref
          .read(authenticationProvider.notifier)
          .authStateChange
          .listen((User? user) async {
        if (user != null) {
          final userId = FirebaseAuth.instance.currentUser!.uid;
          await ref.read(jobsProvider.notifier).fetchJobs();
          await ref.read(userProvider.notifier).fetchUser();
          await ref.read(favoriteJobsProvider.notifier).fetchFavorites(userId);
          print(ref.read(userProvider.notifier).user?.email);
          NavigationService.navigateAndRemoveUntil(
            AppRoutes.homeContainerScreen,
          );
        } else {
          NavigationService.navigateAndRemoveUntil(AppRoutes.loginScreen);
        }
      });
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary.withOpacity(1),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              CustomImageView(
                imagePath: ImageConstant.imgLogo,
                height: 100.h,
                width: 100.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}