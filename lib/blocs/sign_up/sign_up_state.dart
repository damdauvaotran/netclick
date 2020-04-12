import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpState extends Equatable {
  const SignUpState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState{
  final String error;

  const SignUpFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Sign up failure { error: $error }';
}