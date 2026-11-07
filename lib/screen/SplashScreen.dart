import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twfiek/screen/home.dart';

import 'package:twfiek/screen/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Fade Animation
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Up / Slide Animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start Splash
    _startSplash();
  }

  Future<void> _startSplash() async {
  await _controller.forward();

  await Future.delayed(
    const Duration(milliseconds: 700),
  );

  if (!mounted) return;

  final user = FirebaseAuth.instance.currentUser;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
          user == null ? const LoginPage() : const Home(),
    ),
  );
}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 248, 247, 248),
            ],
          ),
        ),

        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,

            child: SlideTransition(
              position: _slideAnimation,

              child: Container(
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  // Purple Glow
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 248, 248, 248).withOpacity(0.18),
                      blurRadius: 70,
                      spreadRadius: 15,
                    ),
                  ],
                ),

                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/Glossy Purple and Gold Arabic Wordmark.png',
                        width: 220,
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}