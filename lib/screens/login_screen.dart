import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hammer_ops/services/service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final service = GetIt.I<AppService>();
      await service.auth.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 42, 57), // 23, 26, 50
          //   appBar: AppBar(
          // leading: Image.asset(
          //   'images/logo.png', // URL for network image
          //   width: 40,
          //   height: 40,
          // ),
          // title: Center(child: const Text('\t\t\t\t\t\t\t\t\t\t\tWELCOME\n[COMPANY NAME HERE]')),
          // backgroundColor: Color.fromARGB(255, 195, 189, 170)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/hero.png', // URL for network image
                  width: 300,
                  height: 300,
                ),
                const SizedBox(height: 50),

                // Email input
                TextFormField(
                  controller: _emailController,
                  textAlign: TextAlign.center,
                  decoration:  InputDecoration(
                    label: Center(child: Text("\t\t\t\t\t\t\t\t\tUSERNAME")),
                    // labelText: "USERNAME",
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!value.contains("@")) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password input
                TextFormField(
                  controller: _passwordController,
                  textAlign: TextAlign.center,
                  decoration:  InputDecoration(
                    label: Center(child: Text("\t\t\t\t\t\t\t\t\tPASSWORD")),
                    // labelText: "PASSWORD",
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),

                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),

                // Login button
                SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: _submitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text("Login Now"),
                  ),
                ),

                const SizedBox(height: 50),
                Container(
                  width: screenWidth * 0.8,
                  child: const Text(
                    "No account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                  ),
                ),
                // const Text("No account?"),
                // const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text("CREATE ACCOUNT"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
