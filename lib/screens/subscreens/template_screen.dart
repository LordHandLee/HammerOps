import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/services/service.dart';

// class TemplateScreen extends StatelessWidget {
//   const TemplateScreen({super.key});

//   // needs to display all the fields given a template id
//   // fetch template fields from database using template id
//   // need future builder with nested list view builder or listview.seperated
//   // to get all template fields and then display them
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Template Screen'),
//       ),
//       body: const Center(
//         child: Text('Template Screen Content'),
//       ),
//     );
//   }
// }








// class QuoteList extends StatelessWidget {
//   final QuoteService quoteService;

//   const QuoteList({super.key, required this.quoteService});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Template>>(
//       future: quoteService.,
//       builder: (context, snapshot) {
//         // if (snapshot.hasData) {
//         //   print("Templates fetched: ${snapshot.data!.length}");
//         //   return const CircularProgressIndicator();
//         // }
//         // if (snapshot.hasError) {
//         //   return Center(child: Text('Error: ${snapshot.error}'));
//         // }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No templates found.'));
//         }
//         final templates = snapshot.data!;
//         return ListView.builder(
//           itemCount: templates.length,
//           itemBuilder: (context, i) => ListTile(title: Text(templates[i].name)),
//         );
//       },
//     );
//   }
// }




class TemplateScreen extends StatefulWidget {
  final int templateId;
  final TemplateService templateService;
  final QuoteService quoteService;

  const TemplateScreen({
    super.key,
    required this.templateId,
    required this.templateService,
    required this.quoteService,
  });

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final Map<int, TextEditingController> _controllers = {};
  double? _previewPrice;
  TextEditingController? name = TextEditingController(text: "John Doe");
  TextEditingController? contact = TextEditingController(text: "123-456-7890");

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _previewQuote(List<TemplateField> fields) async {
    // Build a map of fieldId -> user input value
    final inputValues = <int, double>{};
    for (final field in fields) {
      final text = _controllers[field.id]?.text ?? '';
      final value = double.tryParse(text) ?? 0.0;
      inputValues[field.id] = value;
    }

    final price = await widget.quoteService.previewQuotePrice(
      widget.templateId,
      inputValues,
    );
    setState(() {
      _previewPrice = price;
    });
  }

  Future<void> _saveQuote(userId, templateId, customerName, customerContact, List<String> fields) async {
    // Build a map of fieldId -> user input value

    // int userId, int templateId, amount, List<String> fieldValues
    
    if (_previewPrice == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please preview the quote before saving.')),
          );
        }
        return;
      }
    if (customerName.isEmpty || customerContact.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Customer name and contact cannot be empty.')),
          );
        }
        return;
      }
    print([userId, templateId, customerName, customerContact, _previewPrice, fields]);

    String success = await widget.quoteService.createQuoteFromTemplate(
      userId, customerName, customerContact, templateId, _previewPrice, fields
    );
    print(success);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quote saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Screen'),
      ),
      body: FutureBuilder<TemplateWithFields?>(
        future: widget.templateService.getTemplateWithFields(widget.templateId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.fields.isEmpty) {
            return const Center(child: Text('No fields found for this template.'));
          }

          final fields = snapshot.data!.fields;

          // Ensure we have controllers for all fields
          for (final field in fields) {
            _controllers.putIfAbsent(field.id, () => TextEditingController());
          }

          return Column(
            children: [
              TextFormField(
                controller: name,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
                // initialValue: "John Doe",
              ),
              TextFormField(
                controller: contact,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Customer Contact',
                  border: OutlineInputBorder(),
                ),
                // initialValue: "123-456-7890",
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12.0),
                  itemCount: fields.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final field = fields[index];
                    return TextFormField(
                      controller: _controllers[field.id],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: field.fieldName,
                        border: const OutlineInputBorder(),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _previewQuote(fields),
                    child: const Text('Preview Quote'),
                  ),
                  ElevatedButton(
                    onPressed: () => _saveQuote(
                      1,
                      widget.templateId,
                      name?.text,
                      contact?.text,
                      fields.map((f) => f.fieldName).toList(),
                    ),
                    child: const Text('Save Quote'),
                  ),
                ],
              ),
              if (_previewPrice != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Estimated Price: \$${_previewPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
