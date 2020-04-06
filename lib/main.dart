import 'package:flutter/material.dart';
import 'package:netclick/routes/login_route.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        appBarTheme: AppBarTheme(
          color: Colors.grey[850],
        ),
        backgroundColor: Colors.grey[850],
        brightness: Brightness.dark,
        hintColor: Colors.grey[400],
        focusColor: Colors.grey[400],
        inputDecorationTheme: InputDecorationTheme(
          focusColor: Colors.grey[400],
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginRoute(),
      },
    );
  }
}

class LoginInfo extends InheritedWidget {
  LoginInfo({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return null;
  }
}
