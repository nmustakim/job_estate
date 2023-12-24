import 'package:flutter/material.dart';
import 'package:job_estate/app_export/app_export.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_estate/core/states/base_states.dart';
import 'package:job_estate/utils/lists.dart';
import 'package:job_estate/utils/validator.dart';
import 'package:job_estate/widgets/custom_elevated_button.dart';

import '../../controllers/jobs/add_job_controller.dart';

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
  final _postedByController = TextEditingController();
  final _skillsRequiredController = TextEditingController();
  final _employmentTypeController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _organizationTypeController = TextEditingController();
  final _jobSummaryController = TextEditingController();
  final _educationController = TextEditingController();
  String skillTitle = 'Software';

  List<String> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leadingWidth: 50.v,
          leading: AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeftBlueGray300,
              margin: EdgeInsets.only(left: 16.h, top: 16.v, bottom: 15.v),
              onTap: () {
                Navigator.pop(context);
              }),
          height: 50.v,
          title: AppbarSubtitle(
              text: "Publish job", margin: EdgeInsets.only(left: 12.h))),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.h, 24.v, 16.h, 0),
          children: <Widget>[
            CustomHeader(title: 'Organization Name'),
            CustomTextFormField(
                controller: _organizationNameController,
                hintText: 'Enter organization name',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Organization type'),
            CustomTextFormField(
                suffix: CustomDropdownFormField(
                  items: Lists().organizationType,
                  onChanged: (value) {
                    setState(() {
                      _organizationTypeController.text = value ?? '';
                      skillTitle = value;
                    });
                  },
                ),
                controller: _organizationTypeController,
                hintText: 'Select organization type',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Logo'),
            ImagePickerWidget(
              onImagePicked: (String imageUrl) {
                setState(() {
                  _logoNameController.text = imageUrl;
                });
              },
            ),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Job Title'),
            CustomTextFormField(
                controller: _titleController,
                hintText: 'Enter job title',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Job Summary'),
            CustomTextFormField(
                controller: _jobSummaryController,
                hintText: 'Enter job summary',
                maxLines: 4,
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Description'),
            CustomTextFormField(
                controller: _descriptionController,
                hintText: 'Enter description',
                maxLines: 10,
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Location'),
            CustomTextFormField(
                controller: _locationController,
                hintText: 'Enter location',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
            CustomHeader(title: 'Salary'),
            CustomTextFormField(
                textInputType: TextInputType.number,
                controller: _salaryController,
                hintText: 'Salary',
                validator: (value) => Validator.validateField(value: value)),
            SizedBox(height: 16.v),
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
            SizedBox(height: 16.v),
            CustomHeader(title: 'Skills'),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
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
                      _skillsRequiredController.text = selectedSkills.join(',');
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
            SizedBox(height: 20.v),
            Consumer(builder: (context, ref, _) {
              final publishJobState = ref.watch(publishJobProvider);
              return CustomElevatedButton(
                onPressed: () async {
                  if (!(publishJobState is! LoadingState)) {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(publishJobProvider.notifier)
                          .publishJob(Job(
                            title: _titleController.text,
                            location: _locationController.text,
                            salary: int.parse(_salaryController.text),
                            postedBy: _postedByController.text,
                            skills: _skillsRequiredController.text
                                .split(',')
                                .toList(),
                            employmentType: _employmentTypeController.text,
                            postedDate: DateTime.now(),
                            logo: _logoNameController.text,
                            organizationName: _organizationNameController.text,
                            organizationType: _organizationTypeController.text,
                            jobSummary: _jobSummaryController.text,
                            rolesAndResponsibilities: [],
                            education: _educationController.text,
                            certification: [],
                          ));
                    }
                  }
                },
                buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: publishJobState is LoadingState
                        ? Colors.grey
                        : theme.primaryColor),
                text: publishJobState is LoadingState ? 'Please wait...' : 'Submit',
              );
            }),
            SizedBox(height: 12.h,)
          ],
        ),
      ),
    );
  }
}
