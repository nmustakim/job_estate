import 'package:flutter/material.dart';
import 'package:job_estate/views/account_screen/applied_jobs_screen.dart';
import 'package:job_estate/views/account_screen/profile_screen/profile_screen.dart';
import 'package:job_estate/views/account_screen/publish_job_screen.dart';
import 'package:job_estate/views/auth/change_password_screen.dart';
import 'package:job_estate/views/home_container_screen/home_container_screen.dart';
import 'package:job_estate/views/recent_jobs_screen/recent_jobs_screen.dart';
import 'package:job_estate/widgets/job_details.dart';

import '../views/home_screen/widgets/search_sheet.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/register_screen.dart';
import '../views/search_jobs_by_category_screen/search_jobs_by_category_screen.dart';
import '../views/search_result_no_data_found_screen/search_result_no_data_found_screen.dart';
import '../views/search_result_screen/search_result_screen.dart';

import '../views/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String recentJobsScreen = '/recent_jobs_screen';
  static const String typeWiseJobsScreen = '/typewise_jobs_screen';
  static const String jobDetailsScreen = '/job_details';

  static const String loginScreen = '/login_screen';

  static const String registerScreen = '/register_screen';

  static const String home = '/home';

  static const String homeContainerScreen = '/home_container_screen';

  static const String favoriteProductScreen = '/favorite_product_screen';

  static const String notificationScreen = '/notification_screen';

  static const String notificationFeedScreen = '/notification_feed_screen';

  static const String notificationActivityScreen =
      '/notification_activity_screen';

  static const String searchJobsByCategoryScreen =
      '/search_jobs_by_category_screen';

  static const String searchResultScreen = '/search_result_screen';

  static const String searchResultNoDataFoundScreen =
      '/search_result_no_data_found_screen';

  static const String listCategoryScreen = '/list_category_screen';

  static const String sortByScreen = '/sort_by_screen';

  static const String filterScreen = '/filter_screen';
  static const String searchScreen = '/search_screen';
  static const String paymentMethodScreen = '/payment_method_screen';
  static const String changePassScreen = '/change_password_screen';
  static const String accountScreen = '/account_page';
  static const String publishJobScreen = '/publish_job_screen';

  static const String profileScreen = '/profile_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String appliedJobsScreen = '/applied_jobs_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homeContainerScreen: (context) => HomeContainerScreen(),
    splashScreen: (context) => SplashScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    recentJobsScreen: (context) => RecentJobsScreen(),
    publishJobScreen: (context) => PublishJobScreen(),
    profileScreen: (context) => ProfileScreen(),
    appliedJobsScreen:(context)=>AppliedJobsScreen(),
    changePassScreen: (context) => ChangePasswordScreen(),
    searchScreen: (context) => SearchSheet(),
    searchJobsByCategoryScreen: (context) => SearchJobsByCategoryScreen(),
    searchResultScreen: (context) => SearchResultScreen(),
    searchResultNoDataFoundScreen: (context) => SearchResultNoDataFoundScreen(),

    //
  };
}
