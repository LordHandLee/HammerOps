import 'package:qr_flutter/qr_flutter.dart';

// Example widget to display QR code for tool id
Widget buildToolQrCode(int toolId) {
  return QrImageView(
    data: toolId.toString(),
    version: QrVersions.auto,
    size: 200.0,
  );
}
