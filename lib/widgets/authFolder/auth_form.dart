import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  var _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
    }
    print(_userEmail);
    print(_userName);
    print(_userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'EmailAddress',
                      ),
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Please enter atleast 4 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'UserName'),
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                      ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be atleast 7 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RaisedButton(
                        child: Text(_isLogin ? 'Login' : 'SignUp'),
                        onPressed: _trySubmit),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
