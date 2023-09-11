import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/extensions/string_extensions.dart';

class CustomValidation {
  static String? validatePasswordEmpty(String? value) {
    if ((value ?? "").isEmpty) {
      return AppStrings.passwordEmptyError;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if ((value ?? "").isEmpty) {
      return AppStrings.emailIdEmptyError;
    } else if (!(value ?? "").isValidEmail) {
      return AppStrings.emailIdValidError;
    } else {
      return null;
    }
  }

  static String? validateNonEmpty(String name, String? value) {
    if (value?.isEmpty ?? true) {
      return AppStrings.nonEmptyError(name);
    }
    return null;
  }

  static String? validateZeroEmpty(String name, String? value) {
    if (value?.isEmpty ?? true) {
      return AppStrings.nonEmptyError(name);
    } else if (double.tryParse(value ?? "0") == 0) {
      return AppStrings.validWorkExperienceError;
    }
    return null;
  }
}
