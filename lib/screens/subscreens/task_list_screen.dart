import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/services/service.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = getIt<AppService>();
    return FutureBuilder<List<Task>>(
      future: service.task.getAllTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final tasks =
            (snapshot.data ?? []).where((t) => !t.isCompleted).toList();
        if (tasks.isEmpty) {
          return const Center(child: Text('No pending tasks'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            // Trigger rebuild by completing future again
            // Not storing state here; let parent rebuild on next frame.
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final t = tasks[index];
              return Card(
                color: Colors.white10,
                child: ListTile(
                  leading:
                      const Icon(Icons.radio_button_unchecked, color: Colors.white),
                  title:
                      Text(t.title, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    t.description ?? '',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
