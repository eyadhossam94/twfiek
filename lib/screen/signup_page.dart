import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twfiek/app%20%20widgets/auth_widgets.dart';
import 'package:twfiek/auth_service.dart';
import 'package:twfiek/screen/home.dart';


import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _hidePassword = true;
  bool _agreed = false;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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

    if (!_agreed) {
      _showError('Please agree to the terms to continue');
      return;
    }

    setState(() => _loading = true);
    try {
      await AuthService.instance.signUp(
        name: _name.text,
        email: _email.text,
        password: _password.text,
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
      isLogin: false,
      onSwitch: () =>
          Navigator.of(context).pushReplacement(fadeRoute(const LoginPage())),
      footer: AuthSwitchRow(
        label: 'I agree to the terms',
        value: _agreed,
        onChanged: (v) => setState(() => _agreed = v),
      ),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthField(
                  label: 'Full name',
                  controller: _name,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      AuthValidators.required(v, 'Enter your name'),
                ),
                const SizedBox(height: 16),
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
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter your password';
                    if (v.length < 6) return 'Use at least 6 characters';
                    return null;
                  },
                  suffix: PasswordToggleButton(
                    hidden: _hidePassword,
                    onPressed: () =>
                        setState(() => _hidePassword = !_hidePassword),
                  ),
                ),
                const SizedBox(height: 16),
                AuthField(
                  label: 'Confirm password',
                  controller: _confirm,
                  obscure: _hidePassword,
                  textInputAction: TextInputAction.done,
                  validator: (v) =>
                      v != _password.text ? 'Passwords do not match' : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          AuthButton(text: 'Sign up', loading: _loading, onPressed: _submit),
        ],
      ),
    );
  }
}