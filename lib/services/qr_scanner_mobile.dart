import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ToolScanner extends StatefulWidget {
  final ValueChanged<int> onToolIdScanned;

  const ToolScanner({super.key, required this.onToolIdScanned});

  @override
  State<ToolScanner> createState() => _ToolScannerState();
}

class _ToolScannerState extends State<ToolScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Tool QR'),
      ),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (_handled) return;
      final toolId = int.tryParse(scanData.code ?? '');
      if (toolId != null) {
        _handled = true;
        await controller.pauseCamera();
        if (mounted) {
          widget.onToolIdScanned(toolId);
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
