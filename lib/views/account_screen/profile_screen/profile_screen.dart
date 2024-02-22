import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_estate/controllers/user/user_controller.dart';

import 'package:job_estate/views/account_screen/profile_screen/widgets/profile_item.dart';

import '../../../constants/image_constant.dart';
import '../../../controllers/user/userStates.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../utils/lists.dart';

import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_image_view.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      String formattedDate =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      ref
          .read(userProvider.notifier)
          .updateProfileField('birthDate', formattedDate, context);
    }
  }

  Future<void> _showGenderPickerDialog(BuildContext context) async {
    String? selectedGender = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Gender'),
          children: Lists()
              .genderType
              .map(
                (gender) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, gender);
                  },
                  child: Text(gender),
                ),
              )
              .toList(),
        );
      },
    );

    if (selectedGender != null) {
      ref
          .read(userProvider.notifier)
          .updateProfileField('gender', selectedGender, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final user = userState is FetchUserSuccessState ? userState.user : null;
    // mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                leadingWidth: 40.h,
                leading: AppbarLeadingImage(
                    imagePath: ImageConstant.imgArrowLeftBlueGray300,
                    margin:
                        EdgeInsets.only(left: 16.h, top: 16.h, bottom: 15.h),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                title: AppbarSubtitle(
                    text: "Profile", margin: EdgeInsets.only(left: 12.h))),
            body: user == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 36.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (!isEditing) {
                                      ref
                                          .read(userProvider.notifier)
                                          .updateProfilePicture(context);
                                    }
                                  },
                                  child: CustomImageView(
                                    imagePath: user.profileImageUrl ??
                                        ImageConstant.imageNotFound,
                                    height: 72.h,
                                    width: 72.h,
                                    radius: BorderRadius.circular(36.h),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.h, top: 9.h, bottom: 14.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          isEditing
                                              ? SizedBox(
                                                  width: 200.h,
                                                  child: TextField(
                                                    controller:
                                                        _textEditingController,
                                                  ),
                                                )
                                              : Text(
                                                  user.fullName,
                                                  style: theme
                                                      .textTheme.titleSmall,
                                                ),
                                          SizedBox(
                                            width: 16.h,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isEditing = !isEditing;
                                                if (isEditing) {
                                                  _textEditingController.text =
                                                      user.fullName;
                                                } else {
                                                  ref
                                                      .read(
                                                          userProvider.notifier)
                                                      .updateProfileField(
                                                          'fullName',
                                                          _textEditingController
                                                              .text,
                                                          context);
                                                }
                                              });
                                            },
                                            child: CustomImageView(
                                              imagePath: isEditing
                                                  ? ImageConstant.imgCheck
                                                  : ImageConstant.imgEdit,
                                              height: 16.h,
                                              width: 16.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(user.email ?? '',
                                          style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.h),
                          ProfileItem(
                            icon: ImageConstant.imgGenderIcon,
                            title: "Gender",
                            value: user.gender ?? "",
                            onTapProfileDetailOption: () {
                              _showGenderPickerDialog(context);
                            },
                          ),
                          ProfileItem(
                            icon: ImageConstant.imgDateIcon,
                            title: "Birthday",
                            value: user.birthDate != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(user.birthDate!)
                                : '',
                            onTapProfileDetailOption: () {
                              _showDatePickerDialog(context);
                            },
                          ),
                          SizedBox(height: 5.h),
                          ProfileItem(
                              icon: ImageConstant.imgLockPrimary,
                              title: "Change password",
                              value: "",
                              onTapProfileDetailOption: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.changePasswordScreen);
                              })
                        ]))));
  }
}
