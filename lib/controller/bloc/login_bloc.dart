import 'package:bloc_learning/data/model/login_model.dart';
import 'package:bloc_learning/data/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());
  
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is LoginErrorHasRetrieve) {
      yield* _mapLoginErrorHasRetrieveToState(event, state);
    }
  }
  
  LoginState _mapUsernameChangedToState(LoginUsernameChanged event, LoginState state) {
    final String username = event.username;

    return state.copyWith(
      username: username
    );
  }

  LoginState _mapPasswordChangedToState(LoginPasswordChanged event, LoginState state) {
    final String password = event.password;

    return state.copyWith(
      password: password
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(LoginSubmitted event, LoginState state) async* {
    yield state.copyWith(
      loading: true
    );
    
    final isSuccess = await LoginRepository().submitLogin(state);
  
    if (isSuccess) {
      yield state.copyWith(
        loading: false,
        success: true
      );
    } else {
      try {
        var error = new LoginErrorModel();
        error.status = true;
        error.value = "Username or password is not found";

        yield state.copyWith(
          loading: false,
          error: error
        );
      } catch(err) {
        print(err);
      }
    }
  }

  Stream<LoginState> _mapLoginErrorHasRetrieveToState(LoginErrorHasRetrieve event, LoginState state) async* {
    var error = new LoginErrorModel();
    error.status = false;
    error.value = null;

    yield state.copyWith(
      error: error
    );
  }
}