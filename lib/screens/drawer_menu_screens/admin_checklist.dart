import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
//import 'package:hammer_ops/screens/drawer_menu_screens/edit_checklist_template.dart';

class AdminChecklistScreen extends StatefulWidget {
  const AdminChecklistScreen({super.key});

  @override
  State<AdminChecklistScreen> createState() => _AdminChecklistScreenState();
}

class _AdminChecklistScreenState extends State<AdminChecklistScreen> {
  final AppService service = getIt<AppService>();

  // late Future<List<ChecklistTemplateWithItems>> _templatesFuture;
  late Future<List<ChecklistTemplate>> _templatesFuture;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  void _loadTemplates() {
    _templatesFuture = service.checklist.getAllTemplates();
    setState(() {});
  }

  Future<void> _createTemplateDialog() async {
    final nameCtrl = TextEditingController();
    final codeCtrl = TextEditingController();

    final created = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Create New Checklist Template"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Template Name"),
              ),
              TextField(
                controller: codeCtrl,
                decoration: const InputDecoration(labelText: "Template Code"),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () async {
                if (nameCtrl.text.isEmpty || codeCtrl.text.isEmpty) return;

                await service.checklist.addTemplate(
                  nameCtrl.text.trim(),
                  codeCtrl.text.trim(),
                );

                Navigator.pop(context, true);
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );

    if (created == true) {
      _loadTemplates();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Template created")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin – Manage Checklists")),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTemplateDialog,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ChecklistTemplate>>(
        future: _templatesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final templates = snapshot.data!;

          // -------------------------------
          // EMPTY STATE
          // -------------------------------
          if (templates.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.list_alt, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    "No checklist templates yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text("Tap + to create your first template."),
                ],
              ),
            );
          }

          // -------------------------------
          // TEMPLATE LIST
          // -------------------------------
          return ListView.builder(
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final tpl = templates[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    tpl.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Code: ${tpl.code} "),
                  trailing: const Icon(Icons.edit),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Text("Fart"), //EditChecklistTemplateScreen(template: tpl),
                      ),
                    );
                    _loadTemplates();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
