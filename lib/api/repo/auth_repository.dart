import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:netclick/api/common.dart';

class UserRepository {
  static Future<String> login({
    @required String username,
    @required String password,
  }) async {
    Map<String, dynamic> data = await post(
        url: 'auth/login', body: {'username': username, 'password': password});
    final token = data['token'];
    print(token);
    return token;
  }

  static Future<Map<String, dynamic>> signUp({
    @required String username,
    @required String password,
  }) async {
    Map<String, dynamic> data = await post(
        url: 'auth/signUp',
        body: {'username': username, 'password': password});
    return data;
  }
}
