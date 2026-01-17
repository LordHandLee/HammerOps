import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'briefcase.dart';

class BriefcaseScreen extends StatelessWidget {
  // final AppService service;
  const BriefcaseScreen({super.key}); //required this.service

  @override
  Widget build(BuildContext context) {
    final List<String> listOfFolders = ["Injury Logs", "Complaints", "My Documents"];
    final service = getIt<AppService>();
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        late Widget page;
        final args = settings.arguments; // ModalRoute.of(context)!.settings.arguments
        String? jobId;
        String? queryType;

        switch (settings.name) {
          case '/':
            page = Briefcase(listOfFolders: listOfFolders); // your existing center container
            break;
          case 'Injury Logs':
            // fetch all jobs with injuries
            page = FutureBuilder(
              future: service.injury.getAllInjuries(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final injuries = snapshot.data!;
                return Briefcase(listOfInjuries: injuries);
              },
            );
            break;
          case 'Complaints':
            // fetch all jobs with complaints
            page = FutureBuilder(
              future: service.complaint.getAllComplaints(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final complaints = snapshot.data!;
                return Briefcase(listOfComplaints: complaints);
              },
            );
            break;
          case 'My Documents':
            page = Briefcase(listOfFolders: ["Jobs", "Documents not assigned to job"],); // another example
            break;
          case "Documents not assigned to job":
            // fetch all documents not associated with jobs
            page = FutureBuilder(
              future: service.document.getDocumentsWithoutJob(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return Briefcase(listOfDocuments: snapshot.data!);
              },
            );
            break;
          case 'Job':
            // get job id
            // get query type from args, could be documents, injuries, or complaints
            // fetch data with job id
            // display data to UI
            // jobId = args['jobId'] as String?;
            if (args != null && args is Map<String, dynamic>) {
              jobId = args['jobId'] as String?;
              queryType = args['queryType'] as String?;

              switch (queryType) {
                case 'document':

                  break;
                case 'complaint':

                  break;
                case 'injury':
                
                  break;
              }
            }
            page = Briefcase(listOfJobData: []);
            break;
          case "Jobs":
          // fetch all jobs with documents
            page = FutureBuilder(
              future: service.jobs.getAllJobs(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return Briefcase(listOfJobs: snapshot.data!, queryType: 'document');
              },
            ); // Jobs with documents fetched from service
            break;
          default:
            page = Briefcase(listOfFolders: listOfFolders);
            break;
          // Add more routes here as needed
        }
        return MaterialPageRoute(
          builder: (_) => page,
          settings: settings,
        );
      },
    );
  }
}
