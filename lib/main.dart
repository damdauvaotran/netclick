import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/routes/home_page_route.dart';
import 'package:netclick/routes/login_route.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'components/shared/loading_indicatior.dart';
import 'data_providers/shared_prefs_auth_data_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsAuthDataProvider.load();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc()..add(AppStarted());
      },
      child: MyApp(),
    ),
  );
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
            focusedBorder: InputBorder.none),
      ),
      initialRoute: '/',
//      routes: {
//        '/': (context) => LoginRoute(),
//      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        // ignore: missing_return
        builder: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            return LoginRoute();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          if (state is AuthenticationAuthenticated) {
            return HomepageRoute();
          }
        },
      ),
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
