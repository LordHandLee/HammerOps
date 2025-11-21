// import 'package:flutter/material.dart';
// import 'package:hammer_ops/screens/drawer_menu_screens/job_creator.dart';
// import 'package:hammer_ops/screens/drawer_menu_screens/job.dart';

// class JobManager extends StatelessWidget {

//   // const ToolTracker(Key? key) : super(key: key);
//   const JobManager({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(onPressed: () => Navigator.pop(context)),
//         backgroundColor: const Color.fromARGB(255, 195, 189, 170),
//         title: Text("Job Manager"),
//       ),
//       body: Row(
//         children: [
//         Column(
//           children: [
//             ElevatedButton(
//               // opens tool creation screen. tool added to list upon creation
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => JobCreator(),
//                   ),
//                 );
//               },
//               child: const Text('CREATE JOB'),),
//           ],
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           // need to get list of tools from database
//           // needs to be listview.builder
//           // when click on ListTile, navigate to corresponding tool page using tool id
//           child: ListView(
//             children: [
//               // tool widget
//               ListTile(
//                 leading: const Icon(Icons.settings),
//                 title: const Text('JOB 1'),
//                 onTap: () => Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => JobScreen(),
//                   ),
//                 ), //onNavigate(const ToolTracker()),
//               ),
//             ],
//           ),
//         ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/job_creator.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/job.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database.dart';

class JobManager extends StatefulWidget {
  const JobManager({super.key});

  @override
  State<JobManager> createState() => _JobManagerState();
}

class _JobManagerState extends State<JobManager> {
  final AppService service = getIt<AppService>();

  late Future<List<Job>> _jobsFuture;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  void _loadJobs() {
    _jobsFuture = service.jobs.getAllJobs();
  }

  Future<void> _refresh() async {
    setState(() {
      _loadJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Job Manager"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const JobCreator()),
              );

              // reload list after returning
              _refresh();
            },
            child: const Text('CREATE JOB'),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: FutureBuilder<List<Job>>(
              future: _jobsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No jobs found."),
                  );
                }

                final jobs = snapshot.data!;

                return ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];

                    return ListTile(
                      leading: const Icon(Icons.work),
                      title: Text(job.name),
                      subtitle: Text("Customer ID: ${job.customer}"),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JobScreen(jobId: job.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
