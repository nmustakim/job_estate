import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/services/navigation_service.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/user/applied_jobs_controller.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/theme_helper.dart';
import '../../constants/image_constant.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_image_view.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                title: AppbarTitle(
                    text: "Account", margin: EdgeInsets.only(left: 16.w)),
                actions: [
                  AppbarTrailingImage(
                      imagePath: ImageConstant.imgNotificationIcon,
                      margin: EdgeInsets.fromLTRB(13.w, 15.h, 13.w, 16.h),
                      onTap: () {
                        onTapNotificationIcon(context);
                      })
                ]),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: Column(children: [
                  _buildAccountOption(context,
                      image: ImageConstant.imgProfile,
                      orderLabel: "Profile", onTapAccountOption: () {
                    NavigationService.navigateToNamedRoute(
                        AppRoutes.profileScreen);
                  }),
                  Consumer(
                    builder: (context,ref,_) {
                      return _buildAccountOption(context,
                      image: ImageConstant.imgCheckmark,
                      orderLabel: "Applied Jobs",
                      onTapAccountOption: ()async{
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      await ref.read(appliedJobsProvider.notifier).fetchUserAppliedJobs(userId).then((value) => NavigationService.navigateToNamedRoute(AppRoutes.appliedJobsScreen));
                      }
                      );
                    }
                  ),

                  SizedBox(height: 5.h),
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
            padding: EdgeInsets.all(16.w),
            decoration: AppDecoration.fillOnPrimaryContainer,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomImageView(
                  imagePath: image, height: 24.h, width: 24.w,color: Colors.grey,),
              Padding(
                  padding: EdgeInsets.only(left: 16.w, top: 2.h, bottom: 3.h),
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
