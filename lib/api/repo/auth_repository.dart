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
        url: '/auth/login', body: {'username': username, 'password': password});
    final token = data['token'];
    return token;
  }

  static Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  static Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  static Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
