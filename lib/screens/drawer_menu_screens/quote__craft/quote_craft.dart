import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/quote__craft/create_template.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/quote__craft/edit_template.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/quote__craft/delete_template.dart';


class QuoteCraft extends StatelessWidget {
  const QuoteCraft({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Craft'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              // navigate to create template screen
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => CreateTemplate()),
                MaterialPageRoute(builder: (context) => DynamicFieldsForm()),
              );
              // Example usage of createQuoteFromTemplate
              // final service = Service();
              // String result = await service.createQuoteFromTemplate(1, 1, 1000.0, ['Client Name', 'Project Description']);
              // print(result);
            },
            child: const Text('CREATE TEMPLATE'),
          ),
          ElevatedButton(onPressed: () async {
              // Example usage of createQuoteFromTemplate
              // final service = Service();
              // String result = await service.createQuoteFromTemplate(1, 1, 1000.0, ['Client Name', 'Project Description']);
              // print(result);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditTemplate()),
              );
            },
            child: const Text('EDIT TEMPLATE'),
          ),
          ElevatedButton(onPressed: () async {
              // Example usage of createQuoteFromTemplate
              // final service = Service();
              // String result = await service.createQuoteFromTemplate(1, 1, 1000.0, ['Client Name', 'Project Description']);
              // print(result);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeleteTemplate()),
              );
            },
            child: const Text('DELETE TEMPLATE'),
          ),
          ],
        ),
      ),
    );
  }
}