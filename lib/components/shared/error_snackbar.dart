
import 'package:flutter/material.dart';

SnackBar ErrorSnackBar({@required String message  , int duration = 1 }){
  return  SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    duration: Duration(seconds: duration),
  );
}