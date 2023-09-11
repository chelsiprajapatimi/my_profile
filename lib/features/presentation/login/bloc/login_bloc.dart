import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/features/models/user_details_model.dart';
import 'package:my_profile/features/presentation/login/bloc/login_state.dart';

import 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  SharedPrefUtils pref;
  LoginBloc(this.pref) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    UserDetailsData? details = await pref.getUserDetails();

    if (details?.emailId != event.emailId) {
      emit(LoginError(AppStrings.userNotFound));
    } else if (details?.password != event.password) {
      emit(LoginError(AppStrings.invalidPassword));
    } else {
      pref.userDetails?.isLoggedIn = true;
      pref.userDetails?.needToRemember = event.needToRemember;
      await pref.setUserDetails(userDetailsData: pref.userDetails!);
      emit(LoginSuccess());
    }
  }
}
