import 'package:flutter/material.dart';
// import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'template_quote_list.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/quote__craft/create_template.dart';

class CreateQuote extends StatefulWidget {
  const CreateQuote({super.key});

  @override
  State<CreateQuote> createState() => _CreateQuoteState();
}

class _CreateQuoteState extends State<CreateQuote> {
  final AppService service = getIt<AppService>();
  
// Future<List<Template>> _getAllTemplates() async {
//     // List<Template> templates = await service.template.getAllTemplates();
//     // // Do something with the templates, e.g., print them
//     // for (var template in templates) {
//     //   print('Template ID: ${template.id}, Name: ${template.name}');
//     // }
//     // return templates;
//     return await service.template.getAllTemplates();
//   }


  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Create Quote from Template'),
    //   ),
    //   body: TemplateList(templateService: service.template),
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote from Template'),
      ),

      body: Center(
        child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle button press to create a new template
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DynamicFieldsForm()),
              );
            },
            child: const Text('Create New Template'),
          ),
          Expanded(
            child: TemplateList(service: service),
          ),
        ],
            ),
      ),
    );
  }




      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       // Example usage of createQuoteFromTemplate
      //       String result = await service.quote.createQuoteFromTemplate(1, 1, 1000.0, ['Client Name', 'Project Description', 'hourly rate', 'square footage']);
      //       print(result);
      //     },
      //     child: const Text('Create Quote'),
      //   ),
      // ),
  //   );
  // }
}