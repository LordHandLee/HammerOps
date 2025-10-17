import 'package:flutter/material.dart';

class Job extends StatefulWidget {
  const Job({super.key});

  @override
  State<Job> createState() => _JobCreatorState();
}

class _JobCreatorState extends State<Job> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  String? _selectedQuote;
  String? _selectedUser;

  // Mock data for dropdowns
  final List<String> _quotes = ['Quote A', 'Quote B', 'Quote C'];
  final List<String> _users = ['User 1', 'User 2', 'User 3'];

  void _saveJob() {
    final jobTitle = _jobTitleController.text.trim();
    final customerName = _customerNameController.text.trim();

    if (jobTitle.isEmpty || customerName.isEmpty || _selectedQuote == null || _selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // TODO: Save the job to database or perform necessary logic
    print('Saving job...');
    print('Title: $jobTitle');
    print('Customer: $customerName');
    print('Quote: $_selectedQuote');
    print('Assigned to: $_selectedUser');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Job saved successfully')),
    );

    Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text("Job"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // TextField(
            //   controller: _jobTitleController,
            //   decoration: const InputDecoration(
            //     labelText: 'Job Title',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            Text("Job Name: Job 1"),
            const SizedBox(height: 16),
            Text("Customer name: Cindy Sue"),
            // TextField(
            //   controller: _customerNameController,
            //   decoration: const InputDecoration(
            //     labelText: 'Customer Name',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 16),
            Text("Assigned to: Mark"),
            const SizedBox(height: 16),
            Text("Quote: Quote 1 - \$15,000"),
            // DropdownButtonFormField<String>(
            //   value: _selectedQuote,
            //   items: _quotes.map((quote) {
            //     return DropdownMenuItem(value: quote, child: Text(quote));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedQuote = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Select Quote',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 16),
            // DropdownButtonFormField<String>(
            //   value: _selectedUser,
            //   items: _users.map((user) {
            //     return DropdownMenuItem(value: user, child: Text(user));
            //   }).toList(),
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedUser = value;
            //     });
            //   },
            //   decoration: const InputDecoration(
            //     labelText: 'Assign to User',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 32),
            // ElevatedButton(
            //   onPressed: _saveJob,
            //   child: const Text('Save Job'),
            // ),
          ],
        ),
      ),
    );
  }
}