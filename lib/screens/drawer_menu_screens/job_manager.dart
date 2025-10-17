import 'package:flutter/material.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/job_creator.dart';
import 'package:hammer_ops/screens/drawer_menu_screens/job.dart';

class JobManager extends StatelessWidget {

  // const ToolTracker(Key? key) : super(key: key);
  const JobManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: Text("Job Manager"),
      ),
      body: Row(
        children: [
        Column(
          children: [
            ElevatedButton(
              // opens tool creation screen. tool added to list upon creation
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => JobCreator(),
                  ),
                );
              },
              child: const Text('CREATE JOB'),),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          // need to get list of tools from database
          // needs to be listview.builder
          // when click on ListTile, navigate to corresponding tool page using tool id
          child: ListView(
            children: [
              // tool widget
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('JOB 1'),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Job(),
                  ),
                ), //onNavigate(const ToolTracker()),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}
