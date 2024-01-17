import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String? id;
  final String title;
  final String location;
  final int salary;
  final String postedBy;
  final List<String>? applicants;
  final List<String>? favoredBy;
  final List<String> skills;
  final String employmentType;
  final DateTime postedDate;
  final String logo;
  final String organizationName;
  final String professionType;
  final String jobSummary;
  final List<String> rolesAndResponsibilities;
  final String education;

  Job({
    this.id,
    this.favoredBy,
    required this.title,
    required this.location,
    required this.salary,
    required this.postedBy,
    this.applicants,
    required this.skills,
    required this.employmentType,
    required this.postedDate,
    required this.logo,
    required this.organizationName,
    required this.professionType,
    required this.jobSummary,
    required this.rolesAndResponsibilities,
    required this.education,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['id'],
    title: json['title'],
    location: json['location'],
    salary: json['salary'],
    postedBy: json['postedBy'],
    applicants: json['applicants'] != null
        ? List<String>.from(json['applicants'])
        : null,
    favoredBy:json['favoredBy'] != null
        ? List<String>.from(json['favoredBy'])
        : null,
    skills: List<String>.from(json['skillsRequired']),
    employmentType: json['employmentType'],
    postedDate: DateTime.parse(json['postedDate']),
    logo: json['logo'],
    organizationName: json['organizationName'],
    professionType: json['professionType'],
    jobSummary: json['jobSummary'],
    rolesAndResponsibilities:
    List<String>.from(json['rolesAndResponsibilities']),
    education: json['education'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'location': location,
    'salary': salary,
    'postedBy': postedBy,
    'applicants': applicants,
    'favoredBy':favoredBy,
    'skillsRequired': skills,
    'employmentType': employmentType,
    'postedDate': postedDate.toIso8601String(),
    'logo': logo,
    'organizationName': organizationName,
    'professionType': professionType,
    'jobSummary': jobSummary,
    'rolesAndResponsibilities': rolesAndResponsibilities,
    'education': education,
  };

  Job copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    int? salary,
    String? postedBy,
    List<String>? applicants,
    final List<String>? favoredBy,
    List<String>? skillsRequired,
    String? employmentType,
    DateTime? postedDate,
    String? logo,
    String? organizationName,
    String? professionType,
    String? jobSummary,
    List<String>? rolesAndResponsibilities,
    List<String>? requirements,
    String? education,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      postedBy: postedBy ?? this.postedBy,
      applicants: applicants ?? this.applicants,
      favoredBy: favoredBy??this.favoredBy,
      skills: skillsRequired ?? this.skills,
      employmentType: employmentType ?? this.employmentType,
      postedDate: postedDate ?? this.postedDate,
      logo: logo ?? this.logo,
      organizationName: organizationName ?? this.organizationName,
      professionType: professionType ?? this.professionType,
      jobSummary: jobSummary ?? this.jobSummary,
      rolesAndResponsibilities:
      rolesAndResponsibilities ?? this.rolesAndResponsibilities,
      education: education ?? this.education,
    );
  }

  factory Job.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    json['id'] = doc.id;
    return Job.fromJson(json);
  }

  // New method to convert a Job object into a Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'salary': salary,
      'postedBy': postedBy,
      'applicants': applicants,
      'favoredBy': favoredBy,
      'skillsRequired': skills,
      'employmentType': employmentType,
      'postedDate': postedDate.toIso8601String(),
      'logo': logo,
      'organizationName': organizationName,
      'professionType': professionType,
      'jobSummary': jobSummary,
      'rolesAndResponsibilities': rolesAndResponsibilities,
      'education': education,
    };
  }
}
