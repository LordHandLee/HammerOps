import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
      backgroundColor: const Color.fromARGB(255, 32, 43, 62),
      body: GridView.count(
          primary: false,
          crossAxisCount: 2,
          padding: const EdgeInsets.all(4),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('CHECKLISTS', style: TextStyle(color: Colors.white),),
              color: Color.fromARGB(255, 86, 124, 155),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('TOOL TRACKER', style: TextStyle(color: Colors.white),),
              color: Color.fromARGB(255, 59, 87, 110),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('FLEET MAINTENANCE', style: TextStyle(color: Colors.white),),
              color: Color.fromARGB(255, 44, 95, 139),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('FLAGGED TASKS', style: TextStyle(color: Colors.white),),
              color: Color.fromARGB(255, 39, 63, 82),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('CUSTOMER COMPLAINTS', style: TextStyle(color: Colors.white),),
              color: Color.fromARGB(255, 12, 50, 80),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Center(child: const Text('INJURY LOG', style: TextStyle(color: Colors.white),)),
              color: Color.fromARGB(255, 18, 24, 33),
            ),
          ],
      )
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     Column(
      //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       // mainAxisSize: MainAxisSize.min,
      //       children: [
      //       Expanded(child: Container(child: Text("hello world"),
      //         decoration: BoxDecoration(
      //           color: Colors.blue,
      //           border: Border.all(width: 10, color: Colors.black38),),
      //         )),
      //       Expanded(child: Text("hello world")),
      //       Expanded(child: Text("hello world")),
      //     ],),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //       Text("hello world"),
      //       Text("hello world"),
      //       Text("hello world"),
      //     ],)
      //   ],
      // )
    );
  }
}