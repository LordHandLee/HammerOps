import 'package:flutter/material.dart';
import 'package:hammer_ops/services/service.dart';
import 'briefcase.dart';

class BriefcaseScreen extends StatelessWidget {
  final AppService service;
  const BriefcaseScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final List<String> listOfFolders = ["Injury Logs", "Complaints", "My Documents"];
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
            page = Briefcase(listOfJobs: [], queryType: 'injury'); // your form/list/etc. Jobs with injuries fetched from service...args.jobs
            break;
          case 'Complaints':
            // fetch all jobs with complaints
            page = Briefcase(listOfJobs: [], queryType: 'complaint'); // another example. Jobs with complaints fetched from service... args.jobs
            break;
          case 'My Documents':
            page = Briefcase(listOfFolders: ["Jobs", "Documents not assigned to job"],); // another example
            break;
          case "Documents not assigned to job":
            // fetch all documents not associated with jobs
            page = Briefcase(listOfDocuments: [], queryType: 'document');
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
            page = Briefcase(listOfJobs: [], queryType: 'document'); // Jobs with documents fetched from service
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


