class AppState {
  String token;

  AppState({this.token= ''});

  AppState.fromAppState(AppState state) {
    token = state.token;
  }
}
