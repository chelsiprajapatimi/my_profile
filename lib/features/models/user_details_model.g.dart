// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsData _$UserDetailsDataFromJson(Map<String, dynamic> json) =>
    UserDetailsData(
      emailId: json['emailId'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      workExperience: (json['workExperience'] as List<dynamic>?)
          ?.map((e) => WorkExperienceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLoggedIn: json['isLoggedIn'] as bool? ?? false,
      needToRemember: json['needToRemember'] as bool? ?? false,
      userImage: json['userImage'] as String?,
    );

Map<String, dynamic> _$UserDetailsDataToJson(UserDetailsData instance) =>
    <String, dynamic>{
      'emailId': instance.emailId,
      'password': instance.password,
      'name': instance.name,
      'skills': instance.skills,
      'workExperience': instance.workExperience,
      'isLoggedIn': instance.isLoggedIn,
      'needToRemember': instance.needToRemember,
      'userImage': instance.userImage,
    };

WorkExperienceData _$WorkExperienceDataFromJson(Map<String, dynamic> json) =>
    WorkExperienceData(
      companyName: json['companyName'] as String?,
      experience: (json['experience'] as num?)?.toDouble(),
      designation: json['designation'] as String?,
    );

Map<String, dynamic> _$WorkExperienceDataToJson(WorkExperienceData instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'experience': instance.experience,
      'designation': instance.designation,
    };
