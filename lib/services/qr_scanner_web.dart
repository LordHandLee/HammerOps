import 'package:flutter/material.dart';

/// Web fallback: simple text entry for tool id (qr_code_scanner is not web-safe here).
class ToolScanner extends StatefulWidget {
  final ValueChanged<int> onToolIdScanned;

  const ToolScanner({super.key, required this.onToolIdScanned});

  @override
  State<ToolScanner> createState() => _ToolScannerWebState();
}

class _ToolScannerWebState extends State<ToolScanner> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Tool QR (Web)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('QR scanning not available on web build; enter the tool id from the code.'),
            const SizedBox(height: 12),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Tool ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final id = int.tryParse(_idController.text.trim());
                if (id == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a valid numeric tool id')),
                  );
                  return;
                }
                widget.onToolIdScanned(id);
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
