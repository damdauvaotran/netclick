import 'package:flutter/material.dart';
import 'package:netclick/routes/home_page_route.dart';

import 'package:netclick/routes/login_route.dart';


import 'data_providers/shared_prefs_auth_data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsAuthDataProvider.load();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
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
              focusedBorder: InputBorder.none),
        ),
        initialRoute: '/',
//      routes: {
//        '/': (context) => LoginRoute(),
//      },
        // home: LoginRoute());
      home: HomePage());
  }
}

class LoginInfo extends InheritedWidget {
  LoginInfo({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return null;
  }
}
