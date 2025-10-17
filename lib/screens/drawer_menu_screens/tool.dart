import 'package:flutter/material.dart';
import 'package:hammer_ops/services/QR_generator.dart';

class Tool extends StatefulWidget {
  const Tool({super.key});

  @override
  State<Tool> createState() => _ToolCreatorState();
}

class _ToolCreatorState extends State<Tool> {
  bool _showQrCode = false;

  void _generateQR() {
    setState(() {
      _showQrCode = true; // triggers rebuild to show QR code widget
    });
    // QrCodeDisplayScreen(toolIdToDisplay: 12345);

    

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QR code generated')),
    );

    // Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Tool"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // TextField(
            //   controller: _jobTitleController,
            //   decoration: const InputDecoration(
            //     labelText: 'Job Title',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            Text("Tool Name: Circular Saw"),
            const SizedBox(height: 16),
            Text("Description: A circular saw is a versatile power tool used for cutting various materials like wood, plastic, masonry, and metal through a spinning blade. It is commonly used for making both long and short straight cuts, or rip cuts and crosscuts, as well as bevel and plunge cuts"),
            // TextField(
            //   controller: _customerNameController,
            //   decoration: const InputDecoration(
            //     labelText: 'Customer Name',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
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
              onPressed: _generateQR,
              child: const Text('Generate QR code'),
            ),
            const SizedBox(height: 24),
            if (_showQrCode)
              Center(
                  child: buildToolQrCode(12345),
                ),
          ],
        ),
      ),
    );
  }
}