import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_estate/app_export/app_export.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/core/states/base_states.dart';
import 'package:job_estate/utils/lists.dart';
import 'package:job_estate/utils/validator.dart';
import 'package:job_estate/widgets/custom_elevated_button.dart';

import '../../controllers/jobs/publish_job_controller.dart';

import '../../models/job_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/media_picker.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_form_field.dart';

class PublishJobScreen extends StatefulWidget {
  @override
  _PublishJobScreenState createState() => _PublishJobScreenState();
}

class _PublishJobScreenState extends State<PublishJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _logoNameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _skillsRequiredController = TextEditingController();
  final _employmentTypeController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _organizationTypeController = TextEditingController();
  final _jobSummaryController = TextEditingController();
  final _educationController = TextEditingController();
  final _rolesAndResponsibilitiesController = TextEditingController();

  String skillTitle = 'Software';
  List<String> selectedSkills = [];
  List<String> selectedRolesAndResponsibilities= [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leadingWidth: 50.w,
          leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeftBlueGray300,
              margin: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 15.h),
              onTap: () {
                Navigator.pop(context);
              }),
          height: 50.h,
          title: AppbarSubtitle(
              text: "Publish job", margin: EdgeInsets.only(left: 12.h))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
          children: <Widget>[
            CustomHeader(title: 'Organization Name'),
            CustomTextFormField(
                controller: _organizationNameController,
                hintText: 'Enter organization name',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Organization type'),
            CustomTextFormField(
                suffix: CustomDropdownFormField(
                  items: Lists().professionType,
                  onChanged: (value) {
                    setState(() {
                      _organizationTypeController.text = value ?? '';
                      skillTitle = value;
                    });
                  },
                ),
                controller: _organizationTypeController,
                hintText: 'Select profession type',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Logo'),
            ImagePickerWidget(
              onImagePicked: (String imageUrl) {
                setState(() {
                  _logoNameController.text = imageUrl;
                });
              },
            ),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Job Title'),
            CustomTextFormField(
                controller: _titleController,
                hintText: 'Enter job title',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Job Summary'),
            CustomTextFormField(
                controller: _jobSummaryController,
                hintText: 'Enter job summary',
                maxLines: 4,
                validator: (value) => Validator.validateField(value: value)),

            SizedBox(height: 16.h),
            CustomHeader(title: 'Location'),
            CustomTextFormField(
                controller: _locationController,
                hintText: 'Enter location',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Salary'),
            CustomTextFormField(
                textInputType: TextInputType.number,
                controller: _salaryController,
                hintText: 'Salary',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Employment type'),
            CustomTextFormField(
                suffix: CustomDropdownFormField(
                  items: Lists().employmentType,
                  onChanged: (value) {
                    setState(() {
                      _employmentTypeController.text = value ?? '';
                    });
                  },
                ),
                controller: _employmentTypeController,
                hintText: 'Select employment type',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Skills'),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                ...selectedSkills.map((skill) => Chip(
                      label: Text(skill),
                      onDeleted: () {
                        setState(() {
                          selectedSkills.remove(skill);
                          _skillsRequiredController.text =
                              selectedSkills.join(',');
                        });
                      },
                    )),
                CustomTextFormField(
                  controller: _skillsRequiredController,
                  hintText: 'Enter skills',
                  onSubmitted: (value) {
                    setState(() {
                      selectedSkills.add(value);
                      _skillsRequiredController.clear();
                    });
                  },
                ),
              ],
            ),
            CustomHeader(title: 'Education'),
            CustomTextFormField(
              suffix: CustomDropdownFormField(
                hintText: 'Select education',
                items: Lists().educationalDegrees,
                onChanged: (value) {
                  setState(() {
                    _educationController.text = value ?? '';
                  });
                },
              ),
              controller: _educationController,
            ),
            SizedBox(height: 16.h),
            CustomHeader(title: 'Roles and Responsibilities'),
            Wrap(
              spacing: 4.0,
              runSpacing: 0.0,
              children: [
                ...selectedRolesAndResponsibilities.map((role) => Chip(
                  label: Text(role),
                  onDeleted: () {
                    setState(() {
                      selectedRolesAndResponsibilities.remove(role);
                    });
                  },
                )),
                CustomTextFormField(
                  hintText: 'Enter role and responsibility',
                  onSubmitted: (value) {
                    setState(() {
                      selectedRolesAndResponsibilities.add(value);

                      _rolesAndResponsibilitiesController.clear();
                    });
                  },
                  controller: _rolesAndResponsibilitiesController,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Consumer(builder: (context, ref, _) {
              final publishJobState = ref.watch(publishJobProvider);
              return CustomElevatedButton(
                onPressed: () async {
                  if (publishJobState is! LoadingState) {
                    if (_formKey.currentState!.validate()) {

                      await ref
                          .read(publishJobProvider.notifier)
                          .publishJob(Job(
                            title: _titleController.text,
                            location: _locationController.text,
                            salary: int.parse(_salaryController.text),
                            postedBy: "User",
                            skills: selectedSkills,
                            employmentType: _employmentTypeController.text,
                            postedDate: DateTime.now(),
                            logo: _logoNameController.text,
                            organizationName: _organizationNameController.text,
                            professionType: _organizationTypeController.text,
                            jobSummary: _jobSummaryController.text,
                            rolesAndResponsibilities: selectedRolesAndResponsibilities,
                            education: _educationController.text,

                          ));

                      _titleController.clear();
                      _locationController.clear();
                      _salaryController.clear();
                      _skillsRequiredController.clear();
                      _employmentTypeController.clear();
                      _organizationNameController.clear();
                      _organizationTypeController.clear();
                      _jobSummaryController.clear();
                      _educationController.clear();
                      _rolesAndResponsibilitiesController.clear();
                      selectedSkills.clear();
                      selectedRolesAndResponsibilities.clear();
                      setState(() {

                      });
                    }
                  }
                },
                buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: publishJobState is LoadingState
                        ? Colors.grey
                        : theme.primaryColor),
                text: publishJobState is LoadingState
                    ? 'Please wait...'
                    : 'Submit',
              );
            }),
            SizedBox(
              height: 12.h,
            )
          ],
        ),
      ),
    );
  }
}
