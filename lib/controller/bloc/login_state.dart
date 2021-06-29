part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String? username;
  final String? password;
  final bool? loading;
  final bool? success;
  final LoginErrorModel? error;

  LoginState({this.username, this.password, this.loading, this.success, this.error});

  LoginState copyWith({
    username,
    password,
    loading,
    success,
    error
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      loading: loading ?? this.loading ?? false,
      success: success ?? this.success ?? false,
      error: error ?? this.error
    );
  }

  @override
  List<Object?> get props => [username, password, loading, success, error];
}