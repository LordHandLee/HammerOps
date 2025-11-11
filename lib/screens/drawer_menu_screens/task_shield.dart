import 'package:flutter/material.dart';
import 'package:drift/drift.dart';
import 'package:hammer_ops/services/service.dart'; // where ComplaintService lives
import 'package:hammer_ops/database/database.dart'; // Drift DB + tables
import 'package:hammer_ops/di/injector.dart';


class AddEditComplaintScreen extends StatefulWidget {
  final AppService service = getIt<AppService>();
  // final ComplaintData? existingComplaint;

  AddEditComplaintScreen({
    super.key,
  });

  @override
  State<AddEditComplaintScreen> createState() => _AddEditComplaintScreenState();
}

class _AddEditComplaintScreenState extends State<AddEditComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  // bool _isResolved = false;

  User? _reportedByUser;
  User? _assignedToUser;
  Customer? _reportedByCustomer;

  List<User> _users = [];
  List<Customer> _customers = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _descCtrl = TextEditingController();
    _loadDropdownData();
  }

  // Future<void> _loadDropdownData() async {
  //   try {
  //     final users = await widget.service.user.getAllUsers();
  //     final customers = await widget.service.customer.getAllCustomers();

  //     setState(() {
  //       _users = users;
  //       _customers = customers;
  //       _loading = false;
  //     });
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Error loading data: $e')));
  //     }
  //   }
  // }
  Future<void> _loadDropdownData() async {
  try {
    final users = await widget.service.user.getAllUsers();
    final customers = await widget.service.customer.getAllCustomers();

    if (!mounted) return;

    setState(() {
      _users = users;
      _customers = customers;
      _loading = false;
    });
  } catch (e) {
    if (mounted) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }
}


  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_reportedByUser == null || _assignedToUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select users before submitting')),
      );
      return;
    }

    final title = _titleCtrl.text.trim();
    final desc = _descCtrl.text.trim();

    try {
      await widget.service.complaint.addComplaint(
title, Value(desc), DateTime.now(), _reportedByUser!.id, _assignedToUser!.id, _reportedByCustomer!.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Submit Complaint')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Submit Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // DropdownButtonFormField<User>(
              //   decoration: const InputDecoration(labelText: 'Reported By'),
              //   value: _reportedByUser,
              //   items: _users
              //       .map((u) =>
              //           DropdownMenuItem(value: u, child: Text(u.name)))
              //       .toList(),
              //   onChanged: (val) => setState(() => _reportedByUser = val),
              //   validator: (val) =>
              //       val == null ? 'Select reporting user' : null,
              // ),
              DropdownButtonFormField<User>(
                decoration: const InputDecoration(labelText: 'Reported By'),
                value: _reportedByUser,
                items: _users.isNotEmpty
                    ? _users.map((u) => DropdownMenuItem(value: u, child: Text(u.name))).toList()
                    : [const DropdownMenuItem(value: null, child: Text('No users available'))],
                onChanged: _users.isNotEmpty ? (val) => setState(() => _reportedByUser = val) : null,
                validator: _users.isNotEmpty
                    ? (val) => val == null ? 'Select reporting user' : null
                    : null,
              ),

              const SizedBox(height: 16),

              // DropdownButtonFormField<User>(
              //   decoration: const InputDecoration(labelText: 'Assign To'),
              //   value: _assignedToUser,
              //   items: _users
              //       .map((u) =>
              //           DropdownMenuItem(value: u, child: Text(u.name)))
              //       .toList(),
              //   onChanged: (val) => setState(() => _assignedToUser = val),
              //   validator: (val) => val == null ? 'Select assignee' : null,
              // ),
              DropdownButtonFormField<User>(
                decoration: const InputDecoration(labelText: 'Assign To'),
                value: _assignedToUser,
                items: _users.isNotEmpty
                    ? _users.map((u) => DropdownMenuItem(value: u, child: Text(u.name))).toList()
                    : [const DropdownMenuItem(value: null, child: Text('No users available'))],
                onChanged: _users.isNotEmpty ? (val) => setState(() => _assignedToUser = val) : null,
                validator: _users.isNotEmpty
                    ? (val) => val == null ? 'Select assignee' : null
                    : null,
              ),

              const SizedBox(height: 16),

              // DropdownButtonFormField<Customer>(
              //   decoration:
              //       const InputDecoration(labelText: 'Customer (optional)'),
              //   value: _reportedByCustomer,
              //   items: _customers
              //       .map((c) =>
              //           DropdownMenuItem(value: c, child: Text(c.name)))
              //       .toList(),
              //   onChanged: (val) => setState(() => _reportedByCustomer = val),
              // ),
              DropdownButtonFormField<Customer>(
                decoration: const InputDecoration(labelText: 'Customer (optional)'),
                value: _reportedByCustomer,
                items: _customers.isNotEmpty
                    ? _customers.map((c) => DropdownMenuItem(value: c, child: Text(c.name))).toList()
                    : [const DropdownMenuItem(value: null, child: Text('No customers available'))],
                onChanged: _customers.isNotEmpty ? (val) => setState(() => _reportedByCustomer = val) : null,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: (_users.isEmpty) ? null : _save,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }
}