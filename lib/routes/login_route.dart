import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/blocs/auth/auth_bloc.dart';
import 'package:netclick/blocs/login/login_bloc.dart';
import 'package:netclick/blocs/login/login_event.dart';
import 'package:netclick/blocs/login/login_state.dart';
import 'package:netclick/routes/sign_up_route.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Container(
          height: 50,
          alignment: Alignment(-1.0, 0.0),
          child: Image(
            image: AssetImage('assets/images/ic_app_name.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: BlocProvider<LoginBloc>(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;

  final Key _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  void _requestUsernameFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_usernameFocusNode);
    });
  }

  void _requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    });
  }

  void _onLogin() {
    _loginBloc.add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text));
  }

  void _onSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpRoute()));
  }

  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: TextFormField(
                    onTap: _requestUsernameFocus,
                    focusNode: _usernameFocusNode,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Email or username',
                      labelStyle: TextStyle(
                        color: _usernameFocusNode.hasFocus
                            ? Colors.white
                            : Colors.grey[400],
                      ),
                      fillColor: Colors.grey[700],
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    onTap: _requestPasswordFocus,
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: _passwordFocusNode.hasFocus
                            ? Colors.white
                            : Colors.grey[400],
                      ),
                      fillColor: Colors.grey[700],
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  width: double.infinity,
                  child: OutlineButton(
                    child: Container(
                        height: 45.0,
                        child: Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        )),
                    onPressed: state is LoginLoading ? null : _onLogin,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: _onSignUp,
                    child: Container(
                      margin: EdgeInsets.only(top: 30.0),
                      height: 45.0,
                      child: Center(
                        child: Text(
                          'Need an account? Sign up now',
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child:
                      state is LoginLoading ? CircularProgressIndicator() : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
