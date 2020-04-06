import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _usernameFocusNode;

  FocusNode _passwordFocusNode;

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

  void _onLogin() {}

  void initState() {
    super.initState();
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
    return Column(
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
            onPressed: _onLogin,
          ),
        ),
      ],
    );
  }
}
