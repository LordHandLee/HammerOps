import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';


// class CreateTemplate extends StatelessWidget {
//   // final TemplateService templateService;
//   // CreateTemplate(this.templateService);
//   const CreateTemplate({super.key});
 
  
  

//   @override
//   Widget build(BuildContext context) {
//     // final service = getIt<AppService>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create Template'),
//       ),
//       body: Center(
//         child: ElevatedButton(onPressed: () async {
//             // templateService.createTemplate('New Template', 'Template Content');
//             // service.template.createTemplate('New Template', 'Template Content');
//             },
//             child: const Text('SAVE TEMPLATE'),
//           ),
//       ),
//     );
//   }
// }

// class TemplateForm extends StatefulWidget {
//   const TemplateForm({super.key});
  
//   @override
//   _TemplateFormState createState() => _TemplateFormState();
//   }

// class _TemplateFormState extends State<TemplateForm> {
//   final List<TemplateField> _fields = [];

//   void _addField() {
//     setState(() {
//       _fields.add(TemplateField());
//     });
//   }

//   void _removeField(int index) {
//     setState(() {
//       _fields.removeAt(index);
//     });
//   }

//   void _saveTemplate() {
//     final names = _fields.map((f) => f.controller.text).toList();
//     print("Template fields: $names");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Create Template")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
        
//             children: [Flexible(
//                 child: _fields.isEmpty ? const Center(child: Text('no fields yet'))
//                 : ListView.separated(
//                   padding: EdgeInsets.all(16),
//                   // shrinkWrap: true,
//                   itemCount: _fields.length,
//                   separatorBuilder: (_, __) => SizedBox(height: 8),
//                   itemBuilder: (context, index) {
//                     return Row(
//                       children: [
//                         Expanded(
//                           child: TextField(
//                             controller: _fields[index].controller,
//                             decoration: InputDecoration(
//                               labelText: "Field name ${index + 1}",
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _removeField(index),
//                         ),
//                         // ElevatedButton.icon(
//                         //   onPressed: _addField,
//                         //   icon: Icon(Icons.add),
//                         //   label: Text("Add Field"),
//                         // ),
//                         // SizedBox(height: 16),
//                         // ElevatedButton(
//                         //   onPressed: _saveTemplate,
//                         //   child: Text("Save Template"),
//                         // ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             const SizedBox(height: 12),
//             Row(
//              children: [
//                 ElevatedButton.icon(
//                 onPressed: _addField,
//                 icon: Icon(Icons.add),
//                 label: Text("Add Field"),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _saveTemplate,
//                   child: Text("Save Template"),
//                 ),
//              ],
//             ),
//             ],
//         ),
//       ),
      
//     );
//   }
// }

// class TemplateField {
//   final TextEditingController controller;
//   TemplateField() : controller = TextEditingController();
// }

// class TemplateForm extends StatefulWidget {
//   const TemplateForm({super.key});

//   @override
//   _TemplateFormState createState() => _TemplateFormState();
// }

// class _TemplateFormState extends State<TemplateForm> {
//   final List<TemplateField> _fields = [];

//   void _addField() {
//     setState(() => _fields.add(TemplateField()));
//   }

//   void _removeField(int index) {
//     setState(() => _fields.removeAt(index));
//   }

//   void _saveTemplate() {
//     final names = _fields.map((f) => f.controller.text).toList();
//     print("Template fields: $names");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Template")),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             // scrollable list of fields
//             Flexible(
//               child: _fields.isEmpty
//                   ? const Center(child: Text("No fields yet"))
//                   : ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: _fields.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 8),
//                       itemBuilder: (context, index) {
//                         return Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 controller: _fields[index].controller,
//                                 decoration: InputDecoration(
//                                   labelText: "Field name ${index + 1}",
//                                 ),
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () => _removeField(index),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//             ),

//             const SizedBox(height: 12),

//             // buttons stay visible under the list
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: _addField,
//                     icon: const Icon(Icons.add),
//                     label: const Text("Add Field"),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _saveTemplate,
//                     child: const Text("Save Template"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class DynamicFieldsForm extends StatefulWidget {
  const DynamicFieldsForm({super.key});

  @override
  State<DynamicFieldsForm> createState() => _DynamicFieldsFormState();
}

class _DynamicFieldsFormState extends State<DynamicFieldsForm> {
  final List<TextEditingController> _controllers = [];
  final TextEditingController templateName = TextEditingController();
  final TextEditingController calculationName = TextEditingController();
  // String? _selectedCalculation;
  final service = getIt<AppService>();

  void _addField() {
    setState(() => _controllers.add(TextEditingController()));
  }

  Future<void> _saveTemplate() async {
    final names = _controllers.map((c) => c.value.text).toList();
    // print("Calculation name: ${_selectedCalculation}");
    names.add(calculationName.value.text);
    // print("Template name: ${templateName.text}");
    // print("Template fields: $names");
    // Call service to save template
    // int userid = service.user.getCurrentUser();
    // // int userid = 1; // replace with actual user id
    // final company = await service.company.addCompany("New Company");
    // final user = await service.user.addUser("johndoe", company);
    service.template.createTemplate(templateName.text, 1, names);
  }

  void _removeField(int index) {
    setState(() {
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dynamic Fields')),
      // bottomNavigationBar: NavigationBar(
      //   // selectedIndex: selectedIndex,
      //   // onDestinationSelected: onNavTap,
      //   destinations: const [
      //     NavigationDestination(icon: Icon(Icons.home), label: ''),
      //     NavigationDestination(icon: Icon(Icons.apps), label: ''),
      //     NavigationDestination(icon: Icon(Icons.edit), label: ''),
      //     NavigationDestination(icon: Icon(Icons.person), label: ''),
      //   ],
      // ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 12.0,
            bottom: 104, //MediaQuery.of(context).viewInsets.bottom + 104.0, // extra bottom padding
          ),
          child: Column(
            children: [
              TextField(
                controller: templateName,
                decoration: InputDecoration(
                  labelText: 'Template Name',
                ),
              ),
              DropdownMenu(
                controller: calculationName,
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 'hourly rate', label: 'hourly rate'),
                  DropdownMenuEntry(value: 'square footage', label: 'square footage'),
                  DropdownMenuEntry(value: 'both', label: 'both'),
                ],
                // onSelected: (String? value) {
                //   setState(() {
                //     _selectedCalculation = value;
                //   });
                // },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _controllers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              labelText: 'Field ${index + 1}',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeField(index),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addField,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Field'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _saveTemplate(),
                      icon: const Icon(Icons.add),
                      label: const Text('Save Template'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}