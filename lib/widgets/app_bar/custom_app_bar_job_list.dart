import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

class CustomAppBarForJobList extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double elevation;



  CustomAppBarForJobList({
    required this.title,
    this.backgroundColor = Colors.blue,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: this.backgroundColor,
      title: Text(this.title,style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),),
      elevation: this.elevation,
      leading: IconButton(
    
        icon: Icon(Icons.navigate_before,size:35.adaptSize,color: Colors.black,),onPressed:()=> Navigator.pop(context),)
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
