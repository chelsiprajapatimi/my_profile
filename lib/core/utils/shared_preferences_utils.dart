import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_profile/constants/preferences_constant.dart';
import 'package:my_profile/features/models/user_details_model.dart';

class SharedPrefUtils {
  final FlutterSecureStorage _pref;

  UserDetailsData? _userDetails;

  SharedPrefUtils(this._pref);

  UserDetailsData? get userDetails => _userDetails;

  UserDetailsData defaultUserData = UserDetailsData(
      emailId: "chelsi.prajapati@mindinventory.com",
      password: "chelsi",
      name: "chelsi",
      skills: [
        "Flutter",
        "Dart"
      ],
      workExperience: [
        WorkExperienceData(
            companyName: "MindInventory",
            experience: 0.5,
            designation: "Trainee"),
        WorkExperienceData(
            companyName: "MindInventory",
            experience: 2,
            designation: "Associate Engineer"),
        WorkExperienceData(
            companyName: "MindInventory",
            experience: 2,
            designation: "Software Engineer"),
        WorkExperienceData(
            companyName: "MindInventory", experience: 1, designation: "Senior"),
      ]);

  Future<void> setUserDetails(
      {required UserDetailsData userDetailsData}) async {
    _userDetails = userDetailsData;
    return await _pref.write(
        key: SharedPreferencesConstants.userDetails,
        value: jsonEncode(userDetailsData.toJson()));
  }

  Future<UserDetailsData?> getUserDetails() async {
    final data = await _pref.read(key: SharedPreferencesConstants.userDetails);
    if (data?.isNotEmpty ?? false) {
      _userDetails = UserDetailsData.fromJson(jsonDecode(data!));
      return _userDetails;
    }
    return null;
  }

  Future deletePreferences() async {
    await _pref.delete(key: SharedPreferencesConstants.userDetails);
  }
}
