// import 'package:flutter/material.dart';


// class JobCreator extends StatelessWidget {

//   // const ToolTracker(Key? key) : super(key: key);
//   const JobCreator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: BackButton(onPressed: () => Navigator.pop(context)),
//         backgroundColor: const Color.fromARGB(255, 195, 189, 170),
//         title: Text("Job Creator"),
//       ),
//       body: Row(
//         children: [
//         Column(
//           children: [
//             ElevatedButton(
//               // opens tool creation screen. tool added to list upon creation
//               onPressed: () async {
                
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
//               Text("hello"),
//               Text("hello"),
//               Text("hello"),
//               ListTile(
//                 leading: const Icon(Icons.settings),
//                 title: const Text('JOB 1'),
//                 onTap: () => null, //onNavigate(const ToolTracker()),
//               ),
//             ],
//           ),
//         ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hammer_ops/di/injector.dart';
// import 'package:hammer_ops/services/service.dart';
// import 'package:hammer_ops/database/database.dart';



// class JobCreator extends StatefulWidget {
//   const JobCreator({super.key});

//   @override
//   State<JobCreator> createState() => _JobCreatorState();
// }

// class _JobCreatorState extends State<JobCreator> {
//   final AppService service = getIt<AppService>();

//   final TextEditingController _jobTitleController = TextEditingController();
//   final TextEditingController _customerNameController = TextEditingController();

//   List<JobQuote> _quotes = [];
//   List<User> _users = [];

//   JobQuote? _selectedQuote;
//   User? _selectedUser;

//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }

//   Future<void> _loadDropdownData() async {
//     final quotes = await service.quote.getAllQuotes();
//     final users = await service.user.getAllUsers();

//     setState(() {
//       _quotes = quotes;
//       _users = users;
//       _loading = false;
//     });
//   }

//   Future<void> _saveJob() async {
//     final title = _jobTitleController.text.trim();
//     final customer = _customerNameController.text.trim();

//     if (title.isEmpty || customer.isEmpty || _selectedQuote == null || _selectedUser == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }

//     await service.jobs.addJob(
//       _selectedQuote!.id,
//       title,
//       null,
//       customer,
//       _selectedUser!.id,
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Job saved successfully')),
//     );

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_loading) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: const Text("Job Creator")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextField(
//               controller: _jobTitleController,
//               decoration: const InputDecoration(
//                 labelText: 'Job Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),

//             TextField(
//               controller: _customerNameController,
//               decoration: const InputDecoration(
//                 labelText: 'Customer Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),

//             DropdownButtonFormField<JobQuote>(
//               value: _selectedQuote,
//               items: _quotes.map((q) {
//                 return DropdownMenuItem(
//                   value: q,
//                   child: Text("${q.customerName} - \$${q.totalAmount}"),
//                 );
//               }).toList(),
//               onChanged: (q) => setState(() => _selectedQuote = q),
//               decoration: const InputDecoration(
//                 labelText: 'Select Quote',
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 16),

//             DropdownButtonFormField<User>(
//               value: _selectedUser,
//               items: _users.map((u) {
//                 return DropdownMenuItem(
//                   value: u,
//                   child: Text(u.name),
//                 );
//               }).toList(),
//               onChanged: (u) => setState(() => _selectedUser = u),
//               decoration: const InputDecoration(
//                 labelText: 'Assign to User',
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 24),

//             ElevatedButton(
//               onPressed: _saveJob,
//               child: const Text('Save Job'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database.dart';

class JobCreator extends StatefulWidget {
  const JobCreator({super.key});

  @override
  State<JobCreator> createState() => _JobCreatorState();
}

class _JobCreatorState extends State<JobCreator> {
  final AppService service = getIt<AppService>();

  final TextEditingController _jobTitleController = TextEditingController();

  // Dropdown data
  List<JobQuote> _quotes = [];
  List<User> _users = [];
  List<Customer> _customers = [];

  // Selected values
  JobQuote? _selectedQuote;
  User? _selectedUser;
  Customer? _selectedCustomer;
  String? _selectedJobStatus;

  final List<String> _jobStatusOptions = [
    "not started",
    "in progress",
    "complete",
  ];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    final quotes = await service.quote.getAllQuotes();
    final users = await service.user.getAllUsers();
    final customers = await service.customer.getAllCustomers();

    setState(() {
      _quotes = quotes;
      _users = users;
      _customers = customers;
      _loading = false;
    });
  }

  Future<void> _saveJob() async {
    final title = _jobTitleController.text.trim();

    if (title.isEmpty ||
        _selectedQuote == null ||
        _selectedUser == null ||
        _selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    await service.jobs.addJob(
      _selectedQuote!.id,
      title,
      _selectedJobStatus,        // optional
      _selectedCustomer!.id,     // now chosen from dropdown
      _selectedUser!.id,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job saved successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Job Creator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Job title
            TextField(
              controller: _jobTitleController,
              decoration: const InputDecoration(
                labelText: 'Job Title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------------- CUSTOMER DROPDOWN ----------------------
            DropdownButtonFormField<Customer>(
              value: _selectedCustomer,
              items: _customers.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c.name),
                );
              }).toList(),
              onChanged: (c) => setState(() => _selectedCustomer = c),
              decoration: const InputDecoration(
                labelText: 'Select Customer',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------------- QUOTE DROPDOWN ----------------------
            DropdownButtonFormField<JobQuote>(
              value: _selectedQuote,
              items: _quotes.map((q) {
                return DropdownMenuItem(
                  value: q,
                  child: Text("${q.customerName} - \$${q.totalAmount}"),
                );
              }).toList(),
              onChanged: (q) => setState(() => _selectedQuote = q),
              decoration: const InputDecoration(
                labelText: 'Select Quote',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------------- ASSIGN USER DROPDOWN ----------------------
            DropdownButtonFormField<User>(
              value: _selectedUser,
              items: _users.map((u) {
                return DropdownMenuItem(
                  value: u,
                  child: Text(u.name),
                );
              }).toList(),
              onChanged: (u) => setState(() => _selectedUser = u),
              decoration: const InputDecoration(
                labelText: 'Assign to User',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // ---------------------- JOB STATUS OPTIONAL ----------------------
            DropdownButtonFormField<String>(
              value: _selectedJobStatus,
              items: _jobStatusOptions.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child: Text(s),
                );
              }).toList(),
              onChanged: (s) => setState(() => _selectedJobStatus = s),
              decoration: const InputDecoration(
                labelText: 'Job Status (optional)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _saveJob,
              child: const Text('Save Job'),
            ),
          ],
        ),
      ),
    );
  }
}
