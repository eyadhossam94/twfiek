import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twfiek/app%20%20widgets/auth_widgets.dart';
import 'package:twfiek/auth_service.dart';
import 'package:twfiek/screen/home.dart';


import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _hidePassword = true;
  bool _rememberMe = false;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await AuthService.instance.signIn(
        email: _email.text,
        password: _password.text,
        rememberMe: _rememberMe,
      );
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        fadeRoute(const Home()),
        (_) => false,
      );
    } on FirebaseAuthException catch (e) {
      _showError(AuthService.errorMessage(e.code));
    } catch (_) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      isLogin: true,
      onSwitch: () => Navigator.of(context)
          .pushReplacement(fadeRoute(const SignupPage())),
      footer: AuthSwitchRow(
        label: 'Remember me',
        value: _rememberMe,
        onChanged: (v) => setState(() => _rememberMe = v),
      ),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthField(
                  label: 'Email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 16),
                AuthField(
                  label: 'Password',
                  controller: _password,
                  obscure: _hidePassword,
                  textInputAction: TextInputAction.done,
                  validator: (v) =>
                      AuthValidators.required(v, 'Enter your password'),
                  suffix: PasswordToggleButton(
                    hidden: _hidePassword,
                    onPressed: () =>
                        setState(() => _hidePassword = !_hidePassword),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          AuthButton(text: 'Login', loading: _loading, onPressed: _submit),
        ],
      ),
    );
  }
}