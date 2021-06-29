part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged(this.username);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted();
}

class LoginErrorHasRetrieve extends LoginEvent {
  LoginErrorHasRetrieve();
}