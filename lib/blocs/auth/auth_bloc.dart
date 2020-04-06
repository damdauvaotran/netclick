import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/api/repo/user_repository.dart';

import 'package:netclick/blocs/auth/auth_event.dart';
import 'package:netclick/data_providers/auth_data_provider.dart';
import 'package:netclick/data_providers/shared_prefs_auth_data_provider.dart';

import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  get initialState => AuthenticationAuthenticated();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = SharedPrefsAuthDataProvider.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await UserRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await UserRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
