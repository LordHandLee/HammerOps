import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';


class CreateTemplate extends StatelessWidget {
  // final TemplateService templateService;
  // CreateTemplate(this.templateService);
  const CreateTemplate({super.key});
 
  
  

  @override
  Widget build(BuildContext context) {
    // final service = getIt<AppService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Template'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: () async {
            // templateService.createTemplate('New Template', 'Template Content');
            // service.template.createTemplate('New Template', 'Template Content');
            },
            child: const Text('SAVE TEMPLATE'),
          ),
      ),
    );
  }
}