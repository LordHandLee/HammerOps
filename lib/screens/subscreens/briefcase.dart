import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';


class Briefcase extends StatelessWidget {
  final List<String>? listOfFolders;
  final List<Job>? listOfJobs;
  final List<Document>? listOfDocuments;
  final List<InjuryData>? listOfInjuries;
  final List<ComplaintData>? listOfComplaints;
  final List<Object>? listOfJobData;
  final String? queryType;
  

  const Briefcase({super.key, this.listOfFolders, this.listOfJobs, this.listOfDocuments, this.listOfInjuries, this.listOfComplaints,
  this.listOfJobData, this.queryType});

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (listOfFolders != null) {
      body = GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: listOfFolders!
            .map(
              (folderName) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(folderName);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.folder, size: 48, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text(folderName),
                  ],
                ),
              ),
            )
            .toList(),
      );
    } else if (listOfJobs != null) {
      body = ListView(
        padding: const EdgeInsets.all(16),
        children: listOfJobs!.map((job) {
          return ListTile(
            leading: const Icon(Icons.folder),
            title: Text(job.name),
            onTap: () {
              Navigator.of(context).pushNamed(
                "Job",
                arguments: {'jobId': job.id, 'queryType': queryType},
              );
            },
          );
        }).toList(),
      );
    } else if (listOfDocuments != null) {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listOfDocuments!.length,
        itemBuilder: (context, index) {
          final doc = listOfDocuments![index];
          return ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: Text(doc.title),
            subtitle: Text(doc.filePath),
          );
        },
      );
    } else if (listOfInjuries != null) {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listOfInjuries!.length,
        itemBuilder: (context, index) {
          final inj = listOfInjuries![index];
          return ListTile(
            leading: const Icon(Icons.healing),
            title: Text(inj.title),
            subtitle: Text(inj.description ?? ''),
          );
        },
      );
    } else if (listOfComplaints != null) {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listOfComplaints!.length,
        itemBuilder: (context, index) {
          final c = listOfComplaints![index];
          return ListTile(
            leading: const Icon(Icons.report_problem),
            title: Text(c.title),
            subtitle: Text(c.description ?? ''),
          );
        },
      );
    } else if (listOfJobData != null) {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listOfJobData!.length,
        itemBuilder: (context, index) {
          final item = listOfJobData![index];

          if (item is Document) {
            return ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: Text(item.title),
              subtitle: Text(item.filePath),
            );
          } else if (item is InjuryData) {
            return ListTile(
              leading: const Icon(Icons.healing),
              title: Text(item.title),
              subtitle: Text(item.description ?? ''),
            );
          } else if (item is ComplaintData) {
            return ListTile(
              leading: const Icon(Icons.report_problem),
              title: Text(item.title),
              subtitle: Text(item.description ?? ''),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    } else {
      body = const Center(child: Text('No data'));
    }
    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
  }
}
