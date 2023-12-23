class Job {
  final String? id;
  final String title;
  final String location;
  final int salary;
  final String postedBy;
  final List<String>? applicants;
  final List<String> skills;
  final String employmentType;
  final DateTime postedDate;
  final String logo;
  final String organizationName;
  final String organizationType;
  final String jobSummary;
  final List<String> rolesAndResponsibilities;
  final String education;
  final List<String> certification;

  Job({ this.id, required this.title,  required this.location,
    required this.salary, required this.postedBy, this.applicants,
    required this.skills, required this.employmentType, required this.postedDate, required this.logo, required this.organizationName, required this.organizationType, required this.jobSummary, required this.rolesAndResponsibilities, required this.education, required this.certification});


  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'location': location,
    'salary': salary,
    'postedBy': postedBy,
    'applicants': applicants,
    'skillsRequired': skills,
    'employmentType': employmentType,
    'postedDate': postedDate.toIso8601String(),
    'logo': logo,
    'organizationName': organizationName,
    'organizationType': organizationType,
    'jobSummary': jobSummary,
    'rolesAndResponsibilities': rolesAndResponsibilities,
    'education': education,
    'certification': certification,
  };


  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['id'],
    title: json['title'],
    location: json['location'],
    salary: json['salary'],
    postedBy: json['postedBy'],
    applicants: json['applicants'] != null ? List<String>.from(json['applicants']) : null,
    skills: List<String>.from(json['skillsRequired']),
    employmentType: json['employmentType'],
    postedDate: DateTime.parse(json['postedDate']),
    logo: json['logo'],
    organizationName: json['organizationName'],
    organizationType: json['organizationType'],
    jobSummary: json['jobSummary'],
    rolesAndResponsibilities: List<String>.from(json['rolesAndResponsibilities']),
    education: json['education'],
    certification: List<String>.from(json['certification']),
  );
  Job copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    int? salary,
    String? postedBy,
    List<String>? applicants,
    List<String>? skillsRequired,
    String? employmentType,
    DateTime? postedDate,
    String? logo,
    String? organizationName,
    String? organizationType,
    String? jobSummary,
    List<String>? rolesAndResponsibilities,
    List<String>? requirements,
    String? education,
    List<String>? certification,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      postedBy: postedBy ?? this.postedBy,
      applicants: applicants ?? this.applicants,
      skills: skillsRequired ?? this.skills,
      employmentType: employmentType ?? this.employmentType,
      postedDate: postedDate ?? this.postedDate,
      logo: logo ?? this.logo,
      organizationName: organizationName ?? this.organizationName,
      organizationType: organizationType ?? this.organizationType,
      jobSummary: jobSummary ?? this.jobSummary,
      rolesAndResponsibilities: rolesAndResponsibilities ?? this.rolesAndResponsibilities,
      education: education ?? this.education,
      certification: certification ?? this.certification,
    );
  }

}
