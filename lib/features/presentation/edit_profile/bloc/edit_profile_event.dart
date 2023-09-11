part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditProfile extends EditProfileEvent {
  final EditFields editFields;
  final String? value;
  final List<String>? skills;
  final WorkExperienceData? workExperience;
  final int? index;

  EditProfile(this.editFields,
      {this.value, this.skills, this.workExperience, this.index});
}

class UpdateSkillsEvent extends EditProfileEvent {}

class PickImageEvent extends EditProfileEvent {}

class LogoutEvent extends EditProfileEvent {}

class DeleteWorkExperienceEvent extends EditProfileEvent {
  final int index;
  DeleteWorkExperienceEvent(this.index);
}
