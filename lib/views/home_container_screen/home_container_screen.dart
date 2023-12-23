import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';
import 'package:job_estate/views/account_screen/account_screen.dart';
import 'package:job_estate/views/search_jobs_by_category_screen/search_jobs_by_category_screen.dart';


import '../favorite_screen/favorite_screen.dart';
import '../home_screen/home.dart';

class HomeContainerScreen extends StatefulWidget {
  HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  ValueNotifier<int> bottomNavigatorTrigger = ValueNotifier(0);

  final PageStorageBucket bucket = PageStorageBucket();

  Future<bool> onWillPopHandler() async {
    if (bottomNavigatorTrigger.value == 0) {
      bool confirmClose = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Do you really want to close the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes', style: theme.textTheme.titleSmall),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No', style: theme.textTheme.titleSmall),
              ),
            ],
          );
        },
      );

      return confirmClose;
    } else {
      bottomNavigatorTrigger.value =
          (bottomNavigatorTrigger.value - 1).clamp(0, 3);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopHandler,
      child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Stack(children: [
            ValueListenableBuilder(
                valueListenable: bottomNavigatorTrigger,
                builder: (BuildContext context, _, __) {
                  return PageStorage(
                      child: dashBoardScreens[bottomNavigatorTrigger.value],
                      bucket: bucket);
                })
          ]),
          bottomNavigationBar: Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(top: 16, right: 30, left: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.lightBlue),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BottomNavigationItem(
                        itemIndex: 0,
                        notifier: bottomNavigatorTrigger,
                        icon: ImageConstant.imgNavHome),
                    Spacer(),
                    BottomNavigationItem(
                        itemIndex: 1,
                        notifier: bottomNavigatorTrigger,
                        icon: ImageConstant.imgNavExplore),
                    Spacer(),
                    BottomNavigationItem(
                        itemIndex: 2,
                        notifier: bottomNavigatorTrigger,
                        icon: ImageConstant.imgLoveIcon),
                    Spacer(),
                    BottomNavigationItem(
                        itemIndex: 3,
                        notifier: bottomNavigatorTrigger,
                        icon: ImageConstant.imgNavAccount)
                  ]))),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  final String icon;
  final int itemIndex;

  final ValueNotifier<int> notifier;
  BottomNavigationItem(
      {Key? key,
      required this.itemIndex,
      required this.notifier,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notifier.value = itemIndex;
      },
      child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (BuildContext context, _, __) {
            return CustomImageView(
                imagePath: icon,
                height: 20.h,
                width: 20.h,
                color: notifier.value != itemIndex
                    ? Colors.grey.shade500
                    : Colors.white);
          }),
    );
  }
}

final List<Widget> dashBoardScreens = [
  Home(),
  SearchJobsByCategoryScreen(),
  FavoriteScreen(),
  AccountScreen()
];
