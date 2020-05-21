import 'package:netclick/data_providers/shared_prefs_auth_data_provider.dart';
import 'package:netclick/models/app_state.dart';

import 'actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is UpdateToken) {
    SharedPrefsAuthDataProvider.setToken(action.token);
    return AppState(token: action.token);
  }
  return state;
}
