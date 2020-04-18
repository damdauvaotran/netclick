import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/api/repo/auth_repository.dart';
import 'package:netclick/blocs/auth/auth_bloc.dart';
import 'package:netclick/blocs/auth/auth_event.dart';
import 'package:netclick/blocs/sign_up/sign_up_event.dart';
import 'package:netclick/blocs/sign_up/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationBloc authenticationBloc;

  SignUpBloc({@required this.authenticationBloc});

  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();
      try {
        final Map<String, dynamic> response = await UserRepository.signUp(
            username: event.username, password: event.password);
        if (response['success']){
          authenticationBloc.add(LoggedOut());
        }
      } catch (error) {
        yield SignUpFailure(error: error.toString());
      }
    }
  }
}
