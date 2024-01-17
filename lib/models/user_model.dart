class UserModel {
  final String userId;
  final String email;
  final String fullName;
  final String? address;
  final String? bio;
  final String? city;
  final String? country;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? resumeUrl;
  final String? state;
  final List<String>? skills;
  final List<Education>? educations;
  final List<Experience>? experiences;
  final DateTime? birthDate;
  final String? gender;
  final String? userType;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    this.address,
    this.bio,
    this.city,
    this.country,
    this.phoneNumber,
    this.profileImageUrl,
    this.resumeUrl,
    this.state,
    this.skills,
    this.educations,
    this.experiences,
    this.birthDate,
    this.gender,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      fullName: json['fullName'],
      address: json['address'],
      bio: json['bio'],
      city: json['city'],
      country: json['country'],
      phoneNumber: json['phoneNumber'],
      profileImageUrl: json['profileImageUrl'],
      resumeUrl: json['resumeUrl'],
      state: json['state'],
      skills: List<String>.from(json['skills'] ?? []),
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e))
          .toList(),
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e))
          .toList(),
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null,
      gender: json['gender'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'address': address,
      'bio': bio,
      'city': city,
      'country': country,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'resumeUrl': resumeUrl,
      'state': state,
      'skills': skills,
      'educations': educations?.map((e) => e.toJson()).toList(),
      'experiences': experiences?.map((e) => e.toJson()).toList(),
      'birthDate': birthDate?.toIso8601String(),
      'gender': gender,
      'userType': userType,
    };
  }
}

class Experience {
  final String title;
  final String company;
  final String startDate;
  final String endDate;

  Experience({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'],
      company: json['company'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class Education {
  final String degree;
  final String institution;
  final String graduationYear;

  Education({
    required this.degree,
    required this.institution,
    required this.graduationYear,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      institution: json['institution'],
      graduationYear: json['graduationYear'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'graduationYear': graduationYear,
    };
  }
}