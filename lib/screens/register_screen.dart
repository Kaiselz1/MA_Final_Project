import 'package:flutter/material.dart';
import 'package:pos_lab/screens/login_screen.dart';
import 'package:pos_lab/style/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _darkenToTop = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(_darkenToTop ? 0.3 : 0.4),
                  Colors.black.withOpacity(_darkenToTop ? 0.6 : 0.7),
                  Colors.black.withOpacity(_darkenToTop ? 0.9 : 1),
                ],
                stops: _darkenToTop ? [0.0, 0.3, 0.6] : [0.2, 0.5, 0.8],
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 120,
                height: 120,
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
            ),
          ),

          Positioned(
            top: 190,
            left: 20,
            right: 20,
            child: Column(
              children: const [
                Text(
                  'Welcome To Our Café',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 1,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  'Your daily orders are waiting, and everything is ready for you to jump right in. Let\'s make today productive and enjoyable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
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
              ],
            ),
          ),

          Positioned(
            top: 290,
            child: Container(
              width: screenWidth,
              height: 555,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.col4.withOpacity(0.7),
                    AppColor.col5.withOpacity(0.6),
                    AppColor.col6.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                            fontSize: 20,
                            color: AppColor.col4,
                            fontWeight: FontWeight.w500,
                            shadows: const [
                              Shadow(
                                offset: Offset(2, 1),
                                blurRadius: 1.5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          hintText: 'Enter your username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                      const SizedBox(height: 25),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                            fontSize: 20,
                            color: AppColor.col4,
                            fontWeight: FontWeight.w500,
                            shadows: const [
                              Shadow(
                                offset: Offset(2, 1),
                                blurRadius: 1.5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Password
                      TextFormField(
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                            fontSize: 20,
                            color: AppColor.col4,
                            fontWeight: FontWeight.w500,
                            shadows: const [
                              Shadow(
                                offset: Offset(2, 1),
                                blurRadius: 1.5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      TextFormField(
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                            fontSize: 20,
                            color: AppColor.col4,
                            fontWeight: FontWeight.w500,
                            shadows: const [
                              Shadow(
                                offset: Offset(2, 1),
                                blurRadius: 1.5,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          hintText: 'Re-enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: () {
                          // TODO: handle register logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.col4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: AppColor.col4,
                      fontWeight: FontWeight.bold,
                    ),
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
