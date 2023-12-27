class UserModel {
  final String userId;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? resumeUrl;
  final String? profileImageUrl;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final List<String>? skills;
  final String? bio;
  final String? educationLevel;
  final List<Experience>? experiences;
  final List<Education>? educations;
  final String? gender;
  final String? userType;
  final DateTime? birthDate;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.resumeUrl,
    this.profileImageUrl,
    this.address,
    this.city,
    this.state,
    this.country,
    this.skills,
    this.bio,
    this.educationLevel,
    this.experiences,
    this.educations,
    this.gender,
    this.userType,
    this.birthDate,
  });



  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      resumeUrl: json['resumeUrl'],
      profileImageUrl: json['profileImageUrl'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      skills: List<String>.from(json['skills'] ?? []),
      bio: json['bio'],
      educationLevel: json['educationLevel'],
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => Experience.fromJson(e))
          .toList(),
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e))
          .toList(),
      gender: json['gender'],
      userType: json['userType'],
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'resumeUrl': resumeUrl,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'skills': skills,
      'bio': bio,
      'educationLevel': educationLevel,
      'experiences': experiences?.map((e) => e.toJson()).toList(),
      'educations': educations?.map((e) => e.toJson()).toList(),
      'gender': gender,
      'userType': userType,
      'birthDate': birthDate?.toIso8601String(), // Serialize birthDate
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
