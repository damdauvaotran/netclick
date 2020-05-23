import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppState {
  String token;
  AppState({this.token = ''});

  AppState.fromAppState(AppState another) {
    this.token = another.token;
  }
  bool get isAuth => token != '';
}

class Action{
  final dynamic payload;
  Action(this.payload);
}

class Login implements Action {
  final dynamic payload;
  Login(this.payload);
}

AppState reducer(AppState prevState, Action action) {
  AppState newState = AppState.fromAppState(prevState);
  if (action is Login) {
    newState.token = action.payload;
  }
  return newState;
}
