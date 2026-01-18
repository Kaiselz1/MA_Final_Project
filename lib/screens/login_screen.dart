import "package:flutter/material.dart";
import "package:pos_lab/screens/register_screen.dart";
import "package:pos_lab/services/auth_service.dart";
import "package:pos_lab/style/color.dart";
import "package:pos_lab/widgets/nav_wiget.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _logoMoved = false;
  bool _darkenToTop = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _showForm = false;
  bool _isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar('Please enter email and password', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    final result = await AuthService.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (result['success']) {
      if (!mounted) return;

      // Show debug mode message if applicable
      if (result['isDebugMode'] == true) {
        _showSnackBar('Debug mode login successful!');
      }

      // Navigate to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavWiget()),
      );
    } else {
      _showSnackBar(result['message'] ?? 'Login failed', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppColor.col4,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Dark overlay that animates
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(_darkenToTop ? 0.3 : 0.0),
                  Colors.black.withOpacity(_darkenToTop ? 0.6 : 0.2),
                  Colors.black.withOpacity(_darkenToTop ? 0.9 : 0.7),
                ],
                stops: _darkenToTop ? [0.0, 0.3, 0.6] : [0.2, 0.5, 0.8],
              ),
            ),
          ),

          /// Logo
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _logoMoved ? 50 : screenHeight / 2 - 270,
            left: 0,
            right: 0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              scale: _logoMoved ? 0.8 : 1.0,
              child: Center(
                child: Container(
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
              ),
            ),
          ),

          /// Name Text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            top: _logoMoved ? 240 : screenHeight / 2 - 100,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _logoMoved ? 0.0 : 1.0,
              child: Text.rich(
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
            ),
          ),

          /// Welcome Text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _logoMoved ? 220 : screenHeight - 320,
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

          /// Sign In Form
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: _logoMoved ? 330 : screenHeight,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 520,
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
                  horizontal: 24,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
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
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
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
                            color: AppColor.col4,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              checkColor: Colors.white,
                              activeColor: AppColor.col4,
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Sign In Button
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (!_showForm) {
                        setState(() {
                          _logoMoved = true;
                          _darkenToTop = true;
                          _showForm = true;
                        });
                      } else {
                        _handleLogin();
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.col4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
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
