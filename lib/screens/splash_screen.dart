import 'package:flutter/material.dart';
import 'package:pos_lab/style/color.dart';
import 'package:pos_lab/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Splash screen delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      final isAuthenticated = await AuthService.isUserAuthenticated();

      if (!mounted) return;

      if (isAuthenticated) {
        // Navigate to home (NavWiget)
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Navigate to login
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      print('Error checking auth status: $e');
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0.0, 0.3, 0.6],
              ),
            ),
          ),

          // Logo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD2B48C),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 9,
                        spreadRadius: 5,
                        offset: Offset(3, 8),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(
                        text: 'Evelyn Unmech\n',
                        style: TextStyle(fontSize: 30, letterSpacing: 2),
                      ),
                      TextSpan(text: 'Café', style: TextStyle(fontSize: 25)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'ButterChicken',
                    height: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 1,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                CircularProgressIndicator(color: AppColor.col4, strokeWidth: 3),
                const SizedBox(height: 20),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 1,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
