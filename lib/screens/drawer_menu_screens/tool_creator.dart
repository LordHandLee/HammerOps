import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

class ToolCreator extends StatefulWidget {
  const ToolCreator({super.key});

  @override
  State<ToolCreator> createState() => _JobCreatorState();
}

class _JobCreatorState extends State<ToolCreator> {
  final AppService service = getIt<AppService>();
  final TextEditingController _toolNameController = TextEditingController();
  final TextEditingController _toolDescriptionController = TextEditingController();

  void _saveJob() {
    final name = _toolNameController.text.trim();
    final desc = _toolDescriptionController.text.trim();

    if (name.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    service.tool.addTool(name, desc);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job saved successfully')),
    );

    Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Tool Creator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _toolNameController,
              decoration: const InputDecoration(
                labelText: 'Tool Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _toolDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Tool Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: _selectedQuote,
            //   items: _quotes.map((quote) {
            //     return DropdownMenuItem(value: quote, child: Text(quote));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedQuote = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Select Quote',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: _selectedUser,
            //   items: _users.map((user) {
            //     return DropdownMenuItem(value: user, child: Text(user));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedUser = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Assign to User',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveJob,
              child: const Text('Save Tool'),
            ),
          ],
        ),
      ),
    );
  }
}
