import 'package:flutter/material.dart';

class EditTemplate extends StatelessWidget {
  const EditTemplate({super.key});

  //display list of templates to edit
  // on tap of a template, navigate to edit screen with template details
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Template'),
      ),
      body: const Center(
        child: Text('Edit Template Screen'),
      ),
    );
  }
}