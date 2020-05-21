import 'package:netclick/models/app_state.dart';

import 'actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is UpdateToken) {
    return AppState(token: action.token);
  }
  return state;
}
