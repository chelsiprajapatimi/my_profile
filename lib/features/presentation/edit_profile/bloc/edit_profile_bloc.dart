import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/core/utils/enum_utils.dart';
import 'package:my_profile/core/utils/shared_preferences_utils.dart';
import 'package:my_profile/features/models/user_details_model.dart';
import 'package:permission_handler/permission_handler.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  SharedPrefUtils pref;
  EditProfileBloc(this.pref) : super(EditProfileInitial()) {
    on<EditProfile>(_editProfile);
    on<UpdateSkillsEvent>((event, emit) => emit(SkillsUpdatedState()));
    on<PickImageEvent>(_pickImage);
    on<LogoutEvent>(logout);
    on<DeleteWorkExperienceEvent>(deleteWorkExperienceEvent);
  }

  void _editProfile(EditProfile event, Emitter<EditProfileState> emit) {
    switch (event.editFields) {
      case EditFields.name:
        pref.userDetails?.name = event.value;
        break;
      case EditFields.emailId:
        pref.userDetails?.emailId = event.value;
        break;
      case EditFields.workExperience:
        if (event.workExperience != null) {
          (pref.userDetails?.workExperience ?? []).add(event.workExperience!);
        }
      default:
    }
    if (pref.userDetails != null) {
      pref.setUserDetails(userDetailsData: pref.userDetails!);
      emit(UpdateDetailsSuccess());
    }
  }

  final ImagePicker picker = ImagePicker();

  void _pickImage(PickImageEvent event, Emitter<EditProfileState> emit) async {
    if ((await Permission.photos.request().isGranted)) {
      await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 60)
          .then((value) async {
        if (value != null) {
          final image = await getImageBytes(value);
          if (image != null) {
            pref.userDetails?.userImage = base64Encode(image);
            pref.setUserDetails(userDetailsData: pref.userDetails!);
            emit(ImageSuccessState(image));
          }
        }
      });
    } else {
      emit(ImageErrorState());
    }
  }

  Future<Uint8List?> getImageBytes(XFile file) async {
    try {
      return await file.readAsBytes();
    } on Exception catch (_) {}
    return null;
  }

  void logout(LogoutEvent event, Emitter<EditProfileState> emit) async {
    pref.userDetails?.isLoggedIn = false;
    await pref.setUserDetails(userDetailsData: pref.userDetails!);
    emit(LogoutState());
  }

  void deleteWorkExperienceEvent(
      DeleteWorkExperienceEvent event, Emitter<EditProfileState> emit) async {
    pref.userDetails?.workExperience?.removeAt(event.index);
    await pref.setUserDetails(userDetailsData: pref.userDetails!);
    emit(DeletedSuccessfulState());
  }
}
