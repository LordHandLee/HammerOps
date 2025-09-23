import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/screens/subscreens/template_screen.dart';

class TemplateList extends StatelessWidget {
  final AppService service;

  const TemplateList({super.key, required this.service});
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Template>>(
      future: service.template.getAllTemplates(),
      builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   print("Templates fetched: ${snapshot.data!.length}");
        //   return const CircularProgressIndicator();
        // }
        // if (snapshot.hasError) {
        //   return Center(child: Text('Error: ${snapshot.error}'));
        // }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No templates found.'));
        }
        final templates = snapshot.data!;
        return ListView.builder(
          itemCount: templates.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(templates[i].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemplateScreen(
                    templateId: templates[i].id,
                    templateService: service.template,
                    quoteService: service.quote,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
