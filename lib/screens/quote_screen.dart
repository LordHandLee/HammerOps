import 'package:flutter/material.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Replace this with your real login logic
      String email = _emailController.text;
      String password = _passwordController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logging in as $email')),
      );
      if (email == "admin@admin" && password == "password") {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 87, 110),
      body: Center(
        child: Container(
              width: screenWidth * 0.6,
              decoration: BoxDecoration(
              color: Color.fromARGB(255, 39, 63, 82),
              border: Border.all(width: 25, color: Color.fromARGB(255, 39, 63, 82)),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          // padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("LOAD QUOTE", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
              Text("CREATE QUOTE", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      )
    );
  }
}