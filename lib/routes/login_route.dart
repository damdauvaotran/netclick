import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:netclick/api/repo/auth_repository.dart';
import 'package:netclick/components/shared/app_snackbar.dart';
import 'package:netclick/data_providers/shared_prefs_auth_data_provider.dart';
import 'package:netclick/models/app_state.dart';
import 'package:netclick/redux/actions.dart';
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
        child: LoginForm(),
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

  final _formKey = GlobalKey<FormState>();

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

  Future<void> _onLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        final token = await UserRepository.login(
            username: _usernameController.value.text,
            password: _passwordController.value.text);
        if (token != '' || token != null) {
          StoreProvider.of<AppState>(context)
              .dispatch(UpdateToken(token: token));
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(ErrorSnackBar(message: e));
      }
    }
  }

  void _onSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpRoute()));
  }

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
              // Todo: Change this
              onPressed: _onLogin,
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
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
