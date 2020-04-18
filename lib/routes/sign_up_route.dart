import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netclick/blocs/sign_up/sign_up_bloc.dart';
import 'package:netclick/blocs/sign_up/sign_up_event.dart';

class SignUpRoute extends StatelessWidget {
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
        child: BlocProvider<SignUpBloc>(
            create: (context) {
              return SignUpBloc();
            },
            child: SignUpPage()),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignUpBloc _signUpBloc;

  FocusNode _usernameFocusNode;
  FocusNode _passwordFocusNode;
  FocusNode _rePasswordFocusNode;

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

  void _requestRePasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    });
  }

  void _onSignUp() {
    if (_formKey.currentState.validate()) {
      _signUpBloc.add(SignUpButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text));
    }
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _rePasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
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
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: TextFormField(
                onTap: _requestRePasswordFocus,
                focusNode: _rePasswordFocusNode,
                controller: _rePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  labelStyle: TextStyle(
                    color: _rePasswordFocusNode.hasFocus
                        ? Colors.white
                        : Colors.grey[400],
                  ),
                  fillColor: Colors.grey[700],
                  filled: true,
                ),
                validator: (val) {
                  if (val.isEmpty) return 'Empty';
                  if (val != _passwordController.text)
                    return 'Password not match';
                  return null;
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            width: double.infinity,
            child: OutlineButton(
              child: Container(
                  height: 45.0,
                  child: Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )),
              onPressed: _onSignUp,
            ),
          ),
        ],
      ),
    );
  }
}
