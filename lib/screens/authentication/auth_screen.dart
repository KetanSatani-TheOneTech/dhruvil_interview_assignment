import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (_isLogin) {
      auth.login(email, password);
    } else {
      auth.signup(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? "Login" : "Sign Up"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (email) {
                    final RegExp regExp = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                    if (email!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!regExp.hasMatch(email)) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (password) {
                  if (password!.trim().isEmpty) {
                    return 'Please enter your password';
                  } else if (password.length < 6) {
                    return 'Password field must be at least 6 characters.';
                  }
                  return null;
                },
              ),
              if (_isLogin) ...[
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(_isLogin ? "Forgot password?" : ""),
                    ),
                  ],
                )
              ],
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_isLogin ? "Login" : "Sign Up"),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _emailController.clear();
                  _passwordController.clear();
                  _isLogin = !_isLogin;
                }),
                child: Text(_isLogin ? "Create Account" : "Have an account? Login"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
