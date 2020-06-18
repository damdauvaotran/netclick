import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netclick/data_providers/shared_prefs_auth_data_provider.dart';

//const URL = 'http://todo.mottrieuangi.codes';
const baseUrl = '10.0.2.2:8000';

//Future<Map<String, dynamic> > createTodo({content, isDone}) {
//  return http.post('$URL/todoList', body: {content: content, isDone: isDone});
//}

dynamic parseResponse(http.Response res) {
  dynamic body = jsonDecode(res.body);
  if (body['success']) {
    return body['data'];
  } else {
    throw (body['message']);
  }
}

Future get({String url, query = const {}, header = const {}}) async {
  final uri = Uri.http(baseUrl, url, query);
  final res = await http.get(uri, headers: header);
  return parseResponse(res);
}

Future post(
    {String url,
    body = const {},
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final uri = Uri.http(baseUrl, url, query);
  final res = await http.post(uri, headers: header, body: body);
  return parseResponse(res);
}

Future put(
    {String url,
    body = const {},
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final uri = Uri.http(baseUrl, url, query);
  final res = await http.put(uri, headers: header, body: body);
  return parseResponse(res);
}

Future delete(
    {String url,
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final uri = Uri.http(baseUrl, url, query);
  final res = await http.delete(uri, headers: header);
  return parseResponse(res);
}

Future getAuth(
    {String url,
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final String token = SharedPrefsAuthDataProvider.getToken();
  return await get(
      url: url,
      query: query,
      header: {HttpHeaders.authorizationHeader: 'Bearer $token', ...header});
}

Future postAuth(
    {String url,
    body = const {},
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final String token = SharedPrefsAuthDataProvider.getToken();
  return await post(
      url: url,
      query: query,
      body: body,
      header: {HttpHeaders.authorizationHeader: 'Bearer $token', ...header});
}

Future putAuth(
    {String url,
    body = const {},
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final String token = SharedPrefsAuthDataProvider.getToken();
  return await put(
      url: url,
      query: query,
      body: body,
      header: {HttpHeaders.authorizationHeader: 'Bearer $token', ...header});
}

Future deleteAuth(
    {String url,
    Map<String, String> query = const {},
    Map<String, String> header = const {}}) async {
  final String token = SharedPrefsAuthDataProvider.getToken();
  return await delete(
      url: url,
      query: query,
      header: {HttpHeaders.authorizationHeader: 'Bearer $token', ...header});
}
