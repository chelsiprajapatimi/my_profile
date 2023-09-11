part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class SkillsUpdatedState extends EditProfileState {}

class UpdateDetailsSuccess extends EditProfileState {}

class ImageSuccessState extends EditProfileState {
  final Uint8List selectedImage;

  ImageSuccessState(this.selectedImage);
}

class ImageErrorState extends EditProfileState {}

class LogoutState extends EditProfileState {}

class DeletedSuccessfulState extends EditProfileState {}
