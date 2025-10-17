import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class ToolScanner extends StatefulWidget {
  @override
  _ToolScannerState createState() => _ToolScannerState();
}

class _ToolScannerState extends State<ToolScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final toolId = int.tryParse(scanData.code ?? '');
      if (toolId != null) {
        // Lookup tool in Drift DB
        print("Scanned tool ID: $toolId");
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
