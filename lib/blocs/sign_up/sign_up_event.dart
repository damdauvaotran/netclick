import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent{
  final String username;
  final String password;
  const SignUpButtonPressed({ @required this.username, @required this.password});
}