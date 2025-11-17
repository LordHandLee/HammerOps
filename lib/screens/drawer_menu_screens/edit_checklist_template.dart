import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

class EditChecklistTemplateScreen extends StatefulWidget {
  final ChecklistTemplate template;

  const EditChecklistTemplateScreen({super.key, required this.template});

  @override
  State<EditChecklistTemplateScreen> createState() =>
      _EditChecklistTemplateScreenState();
}

class _EditChecklistTemplateScreenState
    extends State<EditChecklistTemplateScreen> {
  
  final AppService service = getIt<AppService>();
  late List<ChecklistItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.template.items);
  }

  Future<void> _save() async {
    await service.checklist.repo.updateTemplateItems(
      widget.template.template.id,
      _items,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Checklist saved")),
    );

    Navigator.pop(context);
  }

  Future<void> _addItemDialog() async {
    final ctrl = TextEditingController();
    bool required = false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Checklist Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: "Item title"),
              ),
              Row(
                children: [
                  Checkbox(
                    value: required,
                    onChanged: (v) => setState(() => required = v!),
                  ),
                  const Text("Required")
                ],
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _items.add(
                    ChecklistItem(
                      id: 0, // will be inserted
                      templateId: widget.template.template.id,
                      title: ctrl.text,
                      required: required,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }

  Future<void> _editItemDialog(ChecklistItem item) async {
    final ctrl = TextEditingController(text: item.title);
    bool required = item.required;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: "Item title"),
              ),
              Row(
                children: [
                  Checkbox(
                    value: required,
                    onChanged: (v) => setState(() => required = v!),
                  ),
                  const Text("Required")
                ],
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  item.title = ctrl.text;
                  item.required = required;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }

  void _deleteItem(ChecklistItem item) {
    setState(() {
      _items.removeWhere((i) => i.id == item.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.template.template.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, idx) {
          final item = _items[idx];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.required ? "Required" : "Optional"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editItemDialog(item),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteItem(item),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
