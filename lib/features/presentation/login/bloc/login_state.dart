abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginError extends LoginState {
  String errorMessage;

  LoginError(this.errorMessage);
}

class LoginSuccess extends LoginState {}
