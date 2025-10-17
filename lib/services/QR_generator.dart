import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
// Example widget to display QR code for tool id
Widget buildToolQrCode(int toolId) {
  return QrImageView(
    data: toolId.toString(),
    version: QrVersions.auto,
    size: 200.0,
  );
}

class QrCodeDisplayScreen extends StatelessWidget {
  final int toolIdToDisplay;

  const QrCodeDisplayScreen({Key? key, required this.toolIdToDisplay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool QR Code'),
      ),
      body: Center(
        child: buildToolQrCode(toolIdToDisplay),
      ),
    );
  }
}