import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:job_estate/controllers/user/user_controller.dart';
import 'package:job_estate/core/states/base_states.dart';
import 'package:job_estate/views/account_screen/profile_screen/widgets/profile_item.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../constants/image_constant.dart';
import '../../../controllers/user/userStates.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/theme_helper.dart';
import '../../../utils/size_utils.dart';
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
  TextEditingController _textEditingController = TextEditingController();
  bool isEditing = false;
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _updateProfileField(
      String fieldName, String fieldValue, BuildContext context) async {
    try {
      await ref
          .read(userProvider.notifier)
          .updateUserProfile({fieldName: fieldValue}).then(
              (value) => ref.read(userProvider.notifier).fetchUser());
      toast('Profile updated successfully');
    } catch (error) {
      toast('Failed to update profile');
    } finally {
      setState(() {
        isEditing = false;
      });
    }
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
      _updateProfileField('birthDate', formattedDate, context);
    }
  }

  Future<void> _showGenderPickerDialog(BuildContext context) async {
    List<String> genderOptions = ['Male', 'Female'];
    String? selectedGender = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Gender'),
          children: genderOptions
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
      _updateProfileField('gender', selectedGender, context);
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
                        EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                title: AppbarSubtitle(
                    text: "Profile", margin: EdgeInsets.only(left: 12.h))),
            body: user == null
                ? Center(child: CircularProgressIndicator())
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 36.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath:
                                  user.profileImageUrl ?? ImageConstant.imageNotFound,
                                  height: 72.adaptSize,
                                  width: 72.adaptSize,
                                  radius: BorderRadius.circular(36.h),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16.h, top: 9.v, bottom: 14.v),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          isEditing
                                              ? SizedBox(
                                            width:200.v,
                                            child: TextField(
                                              controller: _textEditingController,
                                            ),
                                          )
                                              : Text(
                                            user.fullName,
                                            style: theme.textTheme.titleSmall,
                                          ),
                                          SizedBox(
                                            width: 16.v,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isEditing = !isEditing;
                                                if (isEditing) {
                                                  _textEditingController.text =
                                                      user.fullName;
                                                }
                                                else {
                                                  _updateProfileField('fullName', _textEditingController.text, context);
                                                }
                                              });
                                            },
                                            child: CustomImageView(
                                              imagePath:isEditing?ImageConstant.imgCheck: ImageConstant.imgEdit,
                                              height: 16.adaptSize,
                                              width: 16.adaptSize,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 8.v),
                                      Text(user.userType ?? '', style: theme.textTheme.bodySmall),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 32.v),
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
                            value: user.birthDate != null ? DateFormat('dd-MM-yyyy').format(user.birthDate!):'',
                            onTapProfileDetailOption: () {
                              _showDatePickerDialog(context);
                            },
                          ),
                          ProfileItem(
                            icon: ImageConstant.imgMailPrimary,
                            title: "Email",
                            value: user.email,
                            onTapProfileDetailOption: () {},
                          ),
                          SizedBox(height: 5.v),
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
