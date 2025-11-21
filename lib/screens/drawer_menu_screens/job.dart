import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/database/repository.dart';

class JobScreen extends StatefulWidget {
  final int jobId;

  const JobScreen({super.key, required this.jobId});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final AppService service = getIt<AppService>();

  Job? _job;
  List<JobQuote> _quotes = [];
  List<User> _users = [];
  List<Customer> _customers = [];

  JobQuote? _selectedQuote;
  User? _selectedUser;
  Customer? _selectedCustomer;

  String? _selectedStatus;

  final List<String> jobStatusOptions = [
    "Not Started",
    "In Progress",
    "Complete"
  ];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final job = await service.jobs.getJobById(widget.jobId);
    final quotes = await service.quote.getAllQuotes();
    final users = await service.user.getAllUsers();
    final customers = await service.customer.getAllCustomers();

    setState(() {
      _job = job;
      _quotes = quotes;
      _users = users;
      _customers = customers;

      _selectedQuote =
          quotes.firstWhere((q) => q.id == job?.quoteId, orElse: () => quotes.first);

      _selectedUser =
          users.firstWhere((u) => u.id == job?.assignedTo, orElse: () => users.first);

      _selectedCustomer = customers.firstWhere(
          (c) => c.id == job?.customer,
          orElse: () => customers.first);

      _selectedStatus = job?.jobStatus; // nullable
      _loading = false;
    });
  }

  Future<void> _saveJob() async {
    if (_selectedQuote == null ||
        _selectedUser == null ||
        _selectedCustomer == null ||
        _job == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Missing fields")));
      return;
    }

    await service.jobs.updateJob(
      widget.jobId,
      _selectedQuote!.id,
      _job!.name,
      _selectedStatus, // nullable field
      _selectedCustomer!.id,
      _selectedUser!.id,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Job Updated")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Job"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text("Job Name: ${_job!.name}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),

            /// CUSTOMER DROPDOWN
            DropdownButtonFormField<Customer>(
              value: _selectedCustomer,
              items: _customers.map((c) {
                return DropdownMenuItem(
                    value: c, child: Text(c.name));
              }).toList(),
              onChanged: (c) => setState(() => _selectedCustomer = c),
              decoration: const InputDecoration(
                  labelText: "Customer",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 16),

            /// ASSIGNED USER DROPDOWN
            DropdownButtonFormField<User>(
              value: _selectedUser,
              items: _users.map((u) {
                return DropdownMenuItem(
                    value: u, child: Text(u.name));
              }).toList(),
              onChanged: (u) => setState(() => _selectedUser = u),
              decoration: const InputDecoration(
                  labelText: "Assigned To",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 16),

            /// QUOTE DROPDOWN
            DropdownButtonFormField<JobQuote>(
              value: _selectedQuote,
              items: _quotes.map((q) {
                return DropdownMenuItem(
                    value: q,
                    child: Text("${q.customerName} - \$${q.totalAmount}"));
              }).toList(),
              onChanged: (q) => setState(() => _selectedQuote = q),
              decoration: const InputDecoration(
                  labelText: "Quote",
                  border: OutlineInputBorder()),
            ),

            const SizedBox(height: 16),

            /// JOB STATUS DROPDOWN (OPTIONAL)
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: jobStatusOptions.map((s) {
                return DropdownMenuItem(value: s, child: Text(s));
              }).toList(),
              onChanged: (s) => setState(() => _selectedStatus = s),
              decoration: const InputDecoration(
                labelText: "Job Status (optional)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saveJob,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
