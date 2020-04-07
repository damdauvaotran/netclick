import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/api/repo/auth_repository.dart';
import 'package:netclick/blocs/auth/auth_bloc.dart';
import 'package:netclick/blocs/auth/auth_event.dart';
import 'package:netclick/blocs/login/login_event.dart';
import 'package:netclick/blocs/login/login_state.dart';
import 'package:netclick/models/user_info.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await UserRepository.login(
          username: event.username,
          password: event.password,
        );
//        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
