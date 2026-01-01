import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/tool_creator.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/tool.dart';
import 'package:hammer_ops/services/service.dart';

class ToolTracker extends StatefulWidget {
  const ToolTracker({super.key});

  @override
  State<ToolTracker> createState() => _ToolTrackerState();
}

class _ToolTrackerState extends State<ToolTracker> {
  final AppService service = getIt<AppService>();
  late Future<List<Tool>> _toolsFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _toolsFuture = service.tool.getAllTools();
  }

  Future<void> _refresh() async {
    setState(_load);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Tool Tracker"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create tool',
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ToolCreator()),
          );
          _refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Tool>>(
        future: _toolsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tools = snapshot.data ?? [];
          if (tools.isEmpty) {
            return const Center(child: Text('No tools yet.'));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: tools.length,
              itemBuilder: (context, index) {
                final tool = tools[index];
                return ListTile(
                  leading: Icon(tool.isAvailable ? Icons.build : Icons.lock),
                  title: Text(tool.name),
                  subtitle: Text(tool.description ?? ''),
                  trailing: Text(tool.isAvailable ? 'Available' : 'Checked out'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Tools(toolId: tool.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
