// import 'package:flutter/material.dart';
// import 'package:hammer_ops/database/database.dart';
// import 'package:hammer_ops/di/injector.dart';
// import 'package:hammer_ops/services/service.dart';

// class ChecklistScreen extends StatefulWidget {
//   const ChecklistScreen({super.key});

//   @override
//   State<ChecklistScreen> createState() => _ChecklistScreenState();
// }

// class _ChecklistScreenState extends State<ChecklistScreen>
//     with SingleTickerProviderStateMixin {

//   late TabController _tabController;

//   late Future<ChecklistTemplateWithItems> _bodFuture;
//   late Future<ChecklistTemplateWithItems> _eodFuture;
//   late Future<ChecklistTemplateWithItems> _safetyFuture;

//   final AppService service = getIt<AppService>();


//   // Simple in-memory structure for now. Replace with DB later.
//   // final Map<String, List<ChecklistItem>> checklists = {
//   //   "BOD": [
//   //     ChecklistItem("Inspect PPE", required: true),
//   //     ChecklistItem("Check equipment power", required: true),
//   //     ChecklistItem("Verify first-aid supplies"),
//   //   ],
//   //   "EOD": [
//   //     ChecklistItem("Shut down equipment", required: true),
//   //     ChecklistItem("Clean workstation"),
//   //     ChecklistItem("Lock all doors", required: true),
//   //   ],
//   //   "Safety": [
//   //     ChecklistItem("Fire extinguisher accessible", required: true),
//   //     ChecklistItem("Emergency exits clear", required: true),
//   //     ChecklistItem("Hazards documented"),
//   //   ],
//   // };

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _bodFuture = service.checklist.getChecklist("BOD");
//     _eodFuture = service.checklist.getChecklist("EOD");
//     _safetyFuture = service.checklist.getChecklist("SAFETY");
//   }

//   bool allItemsComplete(String category) {
//     return checklists[category]!
//         .every((item) => !item.required || item.checked);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Daily Checklist"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: "Beginning of Day"),
//             Tab(text: "End of Day"),
//             Tab(text: "Safety"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildChecklistView("BOD"),
//           _buildChecklistView("EOD"),
//           _buildChecklistView("Safety"),
//         ],
//       ),
//     );
//   }

//   Widget _buildChecklistView(String category) {
//     final items = checklists[category]!;

//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: items.length,
//             padding: const EdgeInsets.all(12),
//             itemBuilder: (context, index) {
//               return _checklistTile(items[index]);
//             },
//           ),
//         ),

//         const Divider(),

//         // MARK ALL COMPLETED BUTTON
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     setState(() {
//                       for (var item in items) {
//                         item.checked = true;
//                       }
//                     });
//                   },
//                   child: const Text("Mark All Completed"),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 12),

//         // SUBMIT BUTTON
//         Padding(
//           padding: const EdgeInsets.all(12),
//           child: ElevatedButton.icon(
//             icon: const Icon(Icons.check),
//             label: const Text("Submit Checklist"),
//             onPressed: allItemsComplete(category)
//                 ? () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("$category checklist submitted")),
//                     );
//                   }
//                 : null,
//             style: ElevatedButton.styleFrom(
//               minimumSize: const Size.fromHeight(50),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _checklistTile(ChecklistItem item) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ExpansionTile(
//         title: Row(
//           children: [
//             Checkbox(
//               value: item.checked,
//               onChanged: (val) {
//                 setState(() => item.checked = val!);
//               },
//             ),
//             Expanded(
//               child: Text(
//                 item.title,
//                 style: TextStyle(
//                   fontWeight: item.required ? FontWeight.bold : FontWeight.normal,
//                   color: item.required ? Colors.red[800] : null,
//                 ),
//               ),
//             ),
//           ],
//         ),

//         // EXPANDED AREA FOR NOTES
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               controller: item.noteController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 labelText: "Notes (optional)",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// // SIMPLE MODEL FOR CHECKLIST ITEMS
// class ChecklistItem {
//   String title;
//   bool checked;
//   bool required;
//   TextEditingController noteController = TextEditingController();

//   ChecklistItem(
//     this.title, {
//     this.checked = false,
//     this.required = false,
//   });
// }

import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late Future<ChecklistTemplateWithItems> _bodFuture;
  late Future<ChecklistTemplateWithItems> _eodFuture;
  late Future<ChecklistTemplateWithItems> _safetyFuture;

  final AppService service = getIt<AppService>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _bodFuture = service.checklist.getChecklist("BOD");
    _eodFuture = service.checklist.getChecklist("EOD");
    _safetyFuture = service.checklist.getChecklist("SAFETY");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Checklist"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Beginning of Day"),
            Tab(text: "End of Day"),
            Tab(text: "Safety"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChecklistFuture(_bodFuture),
          _buildChecklistFuture(_eodFuture),
          _buildChecklistFuture(_safetyFuture),
        ],
      ),
    );
  }

  /// Wraps the loader around each checklist
  Widget _buildChecklistFuture(Future<ChecklistTemplateWithItems> future) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final template = snapshot.data!;
        final uiItems = template.items
            .map((i) => UIChecklistItem.fromDb(i))
            .toList();

        return _buildChecklistView(template, uiItems);
      },
    );
  }

  /// Builds checklist UI for a single category
  Widget _buildChecklistView(
      ChecklistTemplateWithItems template,
      List<UIChecklistItem> items,
      ) {
    bool allRequiredComplete =
        items.every((i) => !i.required || i.checked);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) =>
                _checklistTile(items[index]),
          ),
        ),

        const Divider(),

        // MARK ALL COMPLETED BUTTON
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      for (var item in items) {
                        item.checked = true;
                      }
                    });
                  },
                  child: const Text("Mark All Completed"),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // SUBMIT BUTTON
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text("Submit Checklist"),
            onPressed: allRequiredComplete
                ? () async {
                    final runItems = items.map((i) {
                      return ChecklistItemRunInput(
                        itemId: i.id,
                        checked: i.checked,
                        notes: i.noteController.text.trim().isEmpty
                            ? null
                            : i.noteController.text,
                      );
                    }).toList();

                    await service.checklist.submit(
                      template.template.code,
                      1, // TODO: Replace with actual logged-in user
                      runItems,
                    );

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${template.template.name} checklist submitted",
                          ),
                        ),
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ),
      ],
    );
  }

  Widget _checklistTile(UIChecklistItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        title: Row(
          children: [
            Checkbox(
              value: item.checked,
              onChanged: (val) {
                setState(() => item.checked = val!);
              },
            ),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontWeight:
                      item.required ? FontWeight.bold : FontWeight.normal,
                  color: item.required ? Colors.red[800] : null,
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: item.noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Notes (optional)",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// UI MODEL — Wraps DB item with stateful UI fields
///
class UIChecklistItem {
  final int id;
  final String title;
  final bool required;

  bool checked;
  final TextEditingController noteController;

  UIChecklistItem({
    required this.id,
    required this.title,
    required this.required,
    this.checked = false,
    String? initialNote,
  }) : noteController = TextEditingController(text: initialNote);

  factory UIChecklistItem.fromDb(ChecklistItem item) {
    return UIChecklistItem(
      id: item.id,
      title: item.title,
      required: item.required,
      checked: false,
    );
  }
}
