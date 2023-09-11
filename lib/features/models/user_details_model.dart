import 'package:json_annotation/json_annotation.dart';

part 'user_details_model.g.dart';

@JsonSerializable()
class UserDetailsData {
  String? emailId;
  String? password;
  String? name;
  List<String>? skills;
  List<WorkExperienceData>? workExperience;
  bool isLoggedIn;
  bool needToRemember;
  String? userImage;

  UserDetailsData(
      {this.emailId,
      this.password,
      this.name,
      this.skills,
      this.workExperience,
      this.isLoggedIn = false,
      this.needToRemember = false,
      this.userImage});

  factory UserDetailsData.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsDataToJson(this);
}

@JsonSerializable()
class WorkExperienceData {
  String? companyName;
  double? experience;
  String? designation;

  WorkExperienceData({this.companyName, this.experience, this.designation});

  factory WorkExperienceData.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkExperienceDataToJson(this);
}
