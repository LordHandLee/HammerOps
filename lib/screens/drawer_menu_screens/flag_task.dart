// import 'package:flutter/material.dart';
// import 'package:hammer_ops/di/injector.dart';
// import 'package:hammer_ops/services/service.dart'; // where ComplaintService lives
// import 'package:hammer_ops/database/database.dart'; 

// class FlagTaskScreen extends StatelessWidget {
//   final AppService service = getIt<AppService>();

//   FlagTaskScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Task>>(
//       stream: service.task.watchAllTasks(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(title: Text('Submit Complaint')),
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final tasks = snapshot.data ?? [];
//         print(tasks);
//         if (tasks.isEmpty) {
//           return const Center(
//             child: Text(
//               'No tasks available. Add a task to get started!',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: tasks.length,
//           itemBuilder: (context, index) {
//             final task = tasks[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 6),
//               child: ListTile(
//                 title: Text(task.title),
//                 subtitle: Text(
//                   task.reasonForFlag != null
//                       ? 'Flagged: ${task.reasonForFlag}'
//                       : (task.description ?? ''),
//                 ),
//                 trailing: IconButton(
//                   icon: Icon(
//                     task.isFlagged ? Icons.flag : Icons.outlined_flag,
//                     color: task.isFlagged ? Colors.red : Colors.grey,
//                   ),
//                   onPressed: () async {
//                     if (task.isFlagged) {
//                       await service.task.unflagTask(task.id);
//                     } else {
//                       // Ask for a reason before flagging
//                       final reason = await _askForFlagReason(context);
//                       if (reason != null && reason.isNotEmpty) {
//                         await service.task.flagTask(task.id, reason);
//                       }
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<String?> _askForFlagReason(BuildContext context) async {
//     final controller = TextEditingController();
//     return showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Flag Task'),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(
//             labelText: 'Reason for flagging',
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, controller.text),
//             child: const Text('Flag'),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart'; // where AppService lives
import 'package:hammer_ops/database/database.dart';

class FlagTaskScreen extends StatelessWidget {
  final AppService service = getIt<AppService>();

  FlagTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flag Tasks'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Task>>(
        stream: service.task.watchAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data ?? [];

          if (tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks available to display.\nPlease add a task to get started.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(
                    task.reasonForFlag != null
                        ? 'Flagged: ${task.reasonForFlag}'
                        : (task.description ?? 'No description'),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      task.isFlagged ? Icons.flag : Icons.outlined_flag,
                      color: task.isFlagged ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      if (task.isFlagged) {
                        await service.task.unflagTask(task.id);
                      } else {
                        // Ask for a reason before flagging
                        final reason = await _askForFlagReason(context);
                        if (reason != null && reason.isNotEmpty) {
                          await service.task.flagTask(task.id, reason);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<String?> _askForFlagReason(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Flag Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Reason for flagging',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Flag'),
          ),
        ],
      ),
    );
  }
}
