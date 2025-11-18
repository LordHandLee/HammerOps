import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

// class EditChecklistTemplateScreen extends StatefulWidget {
//   final ChecklistTemplate template;

//   const EditChecklistTemplateScreen({super.key, required this.template});

//   @override
//   State<EditChecklistTemplateScreen> createState() =>
//       _EditChecklistTemplateScreenState();
// }

// class _EditChecklistTemplateScreenState
//     extends State<EditChecklistTemplateScreen> {
  
//   final AppService service = getIt<AppService>();
//   late List<EditableChecklistItem> _items;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     // get checklist items from template id
//     // Future<ChecklistTemplateWithItems> items = service.checklist.getChecklist(widget.template.code);
//     _loadChecklistData();
//   }

//   Future<void> _loadChecklistData() async {
//     try {
//       // Await the result of the asynchronous call
//       ChecklistTemplateWithItems checklistData = 
//           await service.checklist.getChecklist(widget.template.id as String);
      
//       // Access the 'items' property from the returned object and set the state
//       setState(() {
//         _items = checklistData.items
//           .map((i) => EditableChecklistItem.fromDrift(i))
//           .toList();
//         _isLoading = false;
//       });
      
//     } catch (e) {
//       // Handle any errors that occurred during the fetch
//       print('Error fetching checklist items: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _save() async {
//     final driftItems = _items.map((i) => i.toDrift()).toList();

//     await service.checklist.updateTemplateItems(
//       widget.template.id,
//       driftItems,
//     );

//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Checklist saved")),
//     );

//     Navigator.pop(context);
//   }

//   Future<void> _addItemDialog() async {
//     final ctrl = TextEditingController();
//     bool required = false;

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//             title: const Text("Add Checklist Item"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: ctrl,
//                   decoration: const InputDecoration(labelText: "Item title"),
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: required,
//                       onChanged: (v) => setState(() => required = v!),
//                     ),
//                     const Text("Required")
//                   ],
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//               ElevatedButton(
//                 onPressed: () {
//                       setState(() {
//                         _items.add(
//                           EditableChecklistItem(
//                             id: null,
//                             templateId: widget.template.id,
//                             title: ctrl.text,
//                             required: required,
//                           ),
//                         );
//                       });
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Add"),
//               )
//             ],
//           );
//         },
//       );
//     });
//   }

//   Future<void> _editItemDialog(EditableChecklistItem item) async {
//     final ctrl = TextEditingController(text: item.title);
//     bool required = item.required;

//     await showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: const Text("Edit Item"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: ctrl,
//                     decoration: const InputDecoration(labelText: "Item title"),
//                   ),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: required,
//                         onChanged: (v) => setState(() => required = v!),
//                       ),
//                       const Text("Required")
//                     ],
//                   )
//                 ],
//               ),
//               actions: [
//                 TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       item.title = ctrl.text;
//                       item.required = required;
//                     });
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Save"),
//                 )
//               ],
//             );
//           },
//         );
//       });
//   }

//   void _deleteItem(EditableChecklistItem item) {
//     setState(() {
//       _items.removeWhere((i) => i.id == item.id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.template.name),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _save,
//           ),
//         ],
//       ),
//       body: _isLoading
//         ? const Center(child: CircularProgressIndicator())
//         : _items.isEmpty
//           ? const Center(child: Text("No items yet. Add one!"))
//           : ListView.builder(
//             itemCount: _items.length,
//             itemBuilder: (_, idx) {
//               final item = _items[idx];
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   title: Text(item.title),
//                   subtitle: Text(item.required ? "Required" : "Optional"),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () => _editItemDialog(item),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteItem(item),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addItemDialog,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


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

  List<EditableChecklistItem> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChecklistData();
  }

  // TEMP DEBUG — call from a button or initState after a delay
  Future<void> dumpTemplateData(int templateId) async {
    final tpl = await service.checklist.getTemplateRawById(templateId); // new method below
    print('TEMPLATE: $tpl');
    final items = await service.checklist.getItemsForTemplateId(templateId); // new method below
    print('ITEM COUNT: ${items.length}');
    for (final it in items) {
      print('ITEM: id=${it.id} templateId=${it.templateId} title="${it.title}" required=${it.required}');
    }
  }

  Future<void> _loadChecklistData() async {
    try {
      // ❗ FIXED: use template.id, NOT template.code
      final data = await service.checklist.getChecklist(widget.template.id);

      setState(() {
        _items = data.items
            .map((i) => EditableChecklistItem.fromDrift(i))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _isLoading = false);
    }
  dumpTemplateData(widget.template.id);
  }

  Future<void> _save() async {
    await service.checklist.updateTemplateItems(
      widget.template.id,
      _items.map((e) => e.toDrift()).toList(),
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
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: const Text("Add Item"),
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
                        onChanged: (v) => setStateSB(() => required = v!),
                      ),
                      const Text("Required"),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _items.add(
                        EditableChecklistItem(
                          id: null,
                          title: ctrl.text,
                          required: required,
                          templateId: widget.template.id,
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
      },
    );
  }

  Future<void> _editItemDialog(EditableChecklistItem item) async {
    final ctrl = TextEditingController(text: item.title);
    bool required = item.required;

    await showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
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
                        onChanged: (v) => setStateSB(() => required = v!),
                      ),
                      const Text("Required"),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
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
      },
    );
  }

  void _deleteItem(EditableChecklistItem item) {
    setState(() => _items.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.template.name),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _save),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return Card(
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.required ? "Required" : "Optional"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editItemDialog(item)),
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteItem(item)),
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


class EditableChecklistItem {
  int? id;
  int templateId;
  String title;
  bool required;

  EditableChecklistItem({
    this.id,
    required this.templateId,
    required this.title,
    required this.required,
  });

  factory EditableChecklistItem.fromDrift(ChecklistItem i) {
    return EditableChecklistItem(
      id: i.id,
      templateId: i.templateId,
      title: i.title,
      required: i.required,
    );
  }

  ChecklistItem toDrift() {
    return ChecklistItem(
      id: id ?? 0,
      templateId: templateId,
      title: title,
      required: required,
    );
  }
}
