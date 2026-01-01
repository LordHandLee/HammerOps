import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/QR_generator.dart';
import 'package:hammer_ops/services/QR_scanner.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Tools extends StatefulWidget {
  final int toolId;

  const Tools({super.key, required this.toolId});

  @override
  State<Tools> createState() => _ToolsCreatorState();
}

class _ToolsCreatorState extends State<Tools> {
  final AppService service = getIt<AppService>();
  late Future<Tool?> _toolFuture;
  bool _showQrCode = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _toolFuture = service.tool.getToolById(widget.toolId);
  }

  void _generateQR() {
    setState(() {
      _showQrCode = true; // triggers rebuild to show QR code widget
    });
  }

  Future<void> _saveQrToDisk(int toolId) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saving QR to disk is not supported on web')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final painter = QrPainter(
        data: toolId.toString(),
        version: QrVersions.auto,
        gapless: true,
      );
      final imgData = await painter.toImageData(300);
      if (imgData == null) throw Exception('Failed to render QR');
      final bytes = imgData.buffer.asUint8List();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/tool_$toolId.png');
      await file.writeAsBytes(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR saved to ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save QR: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _checkoutTool(Tool tool) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Checkout tool?'),
          content: const Text('Are you sure you want to check out this tool?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
          ],
        );
      },
    );
    if (confirmed != true) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ToolScanner(
          onToolIdScanned: (scannedId) async {
            if (scannedId != tool.id) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanned code does not match this tool')),
              );
              return;
            }
            await service.tool.checkoutTool(tool.id);
            if (mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Tool checked out')));
              setState(_load);
            }
          },
        ),
      ),
    );
  }

  Future<void> _returnTool(Tool tool) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Return tool?'),
          content: const Text('Are you sure you want to return this tool?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes')),
          ],
        );
      },
    );
    if (confirmed != true) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ToolScanner(
          onToolIdScanned: (scannedId) async {
            if (scannedId != tool.id) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanned code does not match this tool')),
              );
              return;
            }
            await service.tool.returnTool(tool.id);
            if (mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Tool returned')));
              setState(_load);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Tool"),
      ),
      body: FutureBuilder<Tool?>(
        future: _toolFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final tool = snapshot.data;
          if (tool == null) {
            return const Center(child: Text('Tool not found'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text("Tool Name: ${tool.name}", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(tool.description ?? 'No description'),
                const SizedBox(height: 12),
                Text("Status: ${tool.isAvailable ? 'Available' : 'Checked out'}"),
                Text("Managed by user ID: ${tool.managedBy}"),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _generateQR,
                  child: const Text('Show QR code'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _saving ? null : () => _saveQrToDisk(tool.id),
                  child: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save QR to disk'),
                ),
                const SizedBox(height: 24),
                if (_showQrCode)
                  Center(
                    child: buildToolQrCode(tool.id),
                  ),
                const SizedBox(height: 24),
                if (tool.isAvailable)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Text("Check out tool"),
                    onPressed: () => _checkoutTool(tool),
                  )
                else
                  ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text("Return tool"),
                    onPressed: () => _returnTool(tool),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
