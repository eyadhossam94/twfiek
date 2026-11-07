import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthColors {
  static const card = Color.fromARGB(255, 50, 23, 94);
  static const pill = Color.fromARGB(255, 255, 253, 253);
  static const pillSelected = Color.fromARGB(255, 236, 222, 15);
  static const pillText = Color.fromARGB(255, 0, 0, 0);
  static const line = Color(0xFF4A4646);
  static const button = Color.fromARGB(255, 236, 222, 15);
  static const accent = Color(0xFFB8F27C);
  static const error = Color(0xFFFF8A80);
}

Route<T> fadeRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

class AuthValidators {
  static String? required(String? v, String message) =>
      (v == null || v.trim().isEmpty) ? message : null;

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Enter your email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }
}

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.isLogin,
    required this.onSwitch,
    required this.child,
    required this.footer,
  });

  final bool isLogin;
  final VoidCallback onSwitch;
  final Widget child;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.18,
                child: const Center(
                  child: Image(
                    image: AssetImage(
                      'assets/logo/Glossy Purple and Gold Arabic Wordmark.png',
                    ),
                    width: 200,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                decoration: BoxDecoration(
                  color: AuthColors.card,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthToggle(isLogin: isLogin, onSwitch: onSwitch),
                    const SizedBox(height: 32),
                    child,
                  ],
                ),
              ),
              footer,
            ],
          ),
        ),
      ),
    );
  }
}

class AuthToggle extends StatefulWidget {
  const AuthToggle({super.key, required this.isLogin, required this.onSwitch});
  final bool isLogin;
  final VoidCallback onSwitch;

  @override
  State<AuthToggle> createState() => _AuthToggleState();
}

class _AuthToggleState extends State<AuthToggle> {
  late bool _atLogin = !widget.isLogin;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _atLogin = widget.isLogin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AuthColors.pill,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: _atLogin ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AuthColors.pillSelected,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Row(children: [_tab('Login', true), _tab('Sign up', false)]),
        ],
      ),
    );
  }

  Widget _tab(String text, bool forLogin) {
    final selected = _atLogin == forLogin;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.isLogin == forLogin ? null : widget.onSwitch,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              color: selected ? Colors.black87 : AuthColors.pillText,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.suffix,
  });

  final String label;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          cursorColor: Colors.white,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            suffixIcon: suffix,
            suffixIconConstraints:
                const BoxConstraints(minWidth: 36, minHeight: 36),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthColors.line),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthColors.error),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AuthColors.error, width: 1.2),
            ),
            errorStyle:
                GoogleFonts.poppins(color: AuthColors.error, fontSize: 11),
          ),
        ),
      ],
    );
  }
}

class PasswordToggleButton extends StatelessWidget {
  const PasswordToggleButton({
    super.key,
    required this.hidden,
    required this.onPressed,
  });
  final bool hidden;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      splashRadius: 16,
      onPressed: onPressed,
      icon: Icon(
        hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        size: 18,
        color: Colors.white54,
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AuthColors.button,
          foregroundColor: Colors.black,
          disabledBackgroundColor: AuthColors.button.withValues(alpha: 0.65),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              )
            : Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class AuthSwitchRow extends StatelessWidget {
  const AuthSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 6),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: const WidgetStatePropertyAll(Colors.white),
              trackColor: WidgetStateProperty.resolveWith(
                (s) => s.contains(WidgetState.selected)
                    ? AuthColors.accent
                    : AuthColors.card,
              ),
              trackOutlineColor:
                  const WidgetStatePropertyAll(AuthColors.card),
            ),
          ),
        ],
      ),
    );
  }
}
