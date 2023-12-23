import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

class SearchSheet extends StatelessWidget {
   SearchSheet({super.key});
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 11.v),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(indent: 6.h),
              SizedBox(height: 26.v),
              GestureDetector(
                  onTap: () {
                    // onTapTxtNikeAirMaxReact(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text("qwertyu",
                          style: theme.textTheme.bodySmall))),
              SizedBox(height: 37.v),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("mnfgydydfyt",
                      style: theme.textTheme.bodySmall)),
              SizedBox(height: 34.v),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("vcvc",
                      style: theme.textTheme.bodySmall)),
              SizedBox(height: 36.v),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("hgu",
                      style: theme.textTheme.bodySmall)),
              SizedBox(height: 37.v),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("hgfuyf",
                      style: theme.textTheme.bodySmall)),
              SizedBox(height: 35.v),
              Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text("tuy",
                      style: theme.textTheme.bodySmall)),
              SizedBox(height: 5.v)
            ]));
  }

}
