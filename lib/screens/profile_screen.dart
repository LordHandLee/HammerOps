import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      backgroundColor: const Color.fromARGB(255, 84, 125, 157), // 23, 26, 50
          //   appBar: AppBar(
          // leading: Image.asset(
          //   'images/logo.png', // URL for network image
          //   width: 40,
          //   height: 40,
          // ),
          // title: Center(child: const Text('\t
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("[NAME HERE]", style: TextStyle(color: Colors.white, fontSize: 24),),
                  Text("[JOB TITLE HERE]", style: TextStyle(color: Colors.white, fontSize: 18),),
                  Text("[COMPANY NAME HERE]", style: TextStyle(color: Colors.white, fontSize: 18),),
                  
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CERTIFICATIONS", style: TextStyle(color: Colors.white, fontSize: 18),),
              Text("EDIT PROFILE", style: TextStyle(color: Colors.white, fontSize: 18),),
            ],
          ),
        ],
      )
    );
  }
}