import 'package:flutter/material.dart';

class DeleteTemplate extends StatelessWidget {
  const DeleteTemplate({super.key});

  //display list of templates to delete
  // on tap of a template, navigate to delete confirmation screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Template'),
      ),
      body: const Center(
        child: Text('Delete Template Screen'),
      ),
    );
  }
}