import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netclick/models/app_state.dart';
import 'package:netclick/redux/reducer.dart';
import 'package:netclick/routes/home_page_route.dart';
import 'package:netclick/routes/sign_up_route.dart';
import 'package:netclick/routes/watch_route.dart';
import 'package:redux/redux.dart';

import 'package:netclick/routes/login_route.dart';

import 'data_providers/shared_prefs_auth_data_provider.dart';

enum Actions { UpdateToken }

// The reducer, which takes the previous count and increments it in response
// to an Increment action.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsAuthDataProvider.load();
  final store = new Store<AppState>(appStateReducer,
      initialState: AppState(token: SharedPrefsAuthDataProvider.getToken()));
  runApp(StoreProvider<AppState>(store: store, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String token = StoreProvider.of<AppState>(context).state.token;
    String initialPage = (token == null || token == '') ? '/login' : '/';
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
      initialRoute: initialPage,
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginRoute(),
        '/sign-up': (context) => SignUpRoute(),
        '/watch': (context) => WatchRoute(),
      },
      // home: LoginRoute());
    );
  }
}

class LoginInfo extends InheritedWidget {
  LoginInfo({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return null;
  }
}
