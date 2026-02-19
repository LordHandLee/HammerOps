import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<String> saveToolQrBytes(Uint8List bytes, int toolId) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/tool_$toolId.png');
  await file.writeAsBytes(bytes);
  return file.path;
}
