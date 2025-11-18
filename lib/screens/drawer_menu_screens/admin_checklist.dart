import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/edit_checklist_template.dart';

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
  String? selectedCode;

  final created = await showDialog<bool>(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setStateSB) {
          return AlertDialog(
            title: const Text("Create New Checklist Template"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Template Name"),
                ),
                const SizedBox(height: 16),

                // ----------- DROPDOWN -----------
                DropdownButtonFormField<String>(
                  value: selectedCode,
                  decoration: const InputDecoration(labelText: "Template Type"),
                  items: const [
                    DropdownMenuItem(value: "BOD", child: Text("BOD")),
                    DropdownMenuItem(value: "EOD", child: Text("EOD")),
                    DropdownMenuItem(value: "SAFETY", child: Text("SAFETY")),
                  ],
                  onChanged: (val) => setStateSB(() => selectedCode = val),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: (nameCtrl.text.isNotEmpty && selectedCode != null)
                    ? () async {
                        await service.checklist.addTemplate(
                          selectedCode!,       // dropdown result
                          nameCtrl.text.trim(), 
                        );

                        Navigator.pop(context, true);
                      }
                    : null, // disable button if incomplete
                child: const Text("Create"),
              ),
            ],
          );
        },
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

          final templates = snapshot.data ?? [];//!;

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
                  const Text(
                    "Create your first template to begin.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Create Template"),
                    onPressed: _createTemplateDialog,
                  )
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
                margin: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 12),
                child: ListTile(
                  title: Text(
                    tpl.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Code: ${tpl.code}"),
                  trailing: const Icon(Icons.edit),
                  onTap: () async {
                    // Navigate to edit template screen
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditChecklistTemplateScreen(
                          template: tpl,
                        ),
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
