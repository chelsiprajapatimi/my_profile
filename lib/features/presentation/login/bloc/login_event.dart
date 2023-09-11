abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  String emailId;
  String password;
  bool needToRemember;

  DoLoginEvent(this.emailId, this.password, this.needToRemember);
}
