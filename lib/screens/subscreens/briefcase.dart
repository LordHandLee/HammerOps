import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';


class Briefcase extends StatelessWidget {
  final List<String>? listOfFolders;
  final List<Job>? listOfJobs;
  final List<DocumentData>? listOfDocuments;
  final List<InjuryData>? listOfInjuries;
  final List<ComplaintData>? listOfComplaints;
  final List<Object>? listOfJobData;
  final String? queryType;
  

  const Briefcase({super.key, this.listOfFolders, this.listOfJobs, this.listOfDocuments, this.listOfInjuries, this.listOfComplaints,
  this.listOfJobData, this.queryType});

  @override
  Widget build(BuildContext context) {
    // return Scaffold()
    Widget body;
    if (listOfFolders != null){
      body =  Row(children: 
      listOfFolders!.map((folderName) {
        return InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(folderName);
        },
        child: Column(children: [
          const Icon(Icons.folder, size:48, color: Colors.blue),
          const SizedBox(width: 118.0),
          // const SizedBox(height: 18.0),
          Text(folderName)],),
        );
      }
      ).toList(),
      );
    }
    
    else if (listOfJobs != null){
      body =  Row(children: 
      listOfJobs!.map((folderName) {
        return InkWell(
        onTap: (){
          Navigator.of(context).pushNamed("Job", arguments: {
            'jobId': folderName.id,
            'queryType': queryType,});
          // set args with listOfDocuments/Injuries/Complaints that was passed
        },
        child: Column(children: [
          const Icon(Icons.folder, size:48, color: Colors.blue),
          const SizedBox(width: 118.0),
          // const SizedBox(height: 18.0),
          Text(folderName.name)],),
        );
      }
      ).toList(),
      );
    }
    else if (listOfDocuments != null){
      return Row();
    }
    // else if (listOfInjuries != null){

    // }
    // else if (listOfComplaints != null){

    // }
    else if (listOfJobData != null){
      return ListView.builder(
        itemCount:listOfJobData!.length,
        itemBuilder: (context, index) {
          final item = listOfJobData![index];

          if (item is DocumentData) {

          }
          else if (item is InjuryData) {

          }
          else if (item is ComplaintData) {

          }
        }
      );
    }
    else {
      body = Row();
    }
    return Scaffold(
      appBar: AppBar(),
      body: body,
    );
}

}