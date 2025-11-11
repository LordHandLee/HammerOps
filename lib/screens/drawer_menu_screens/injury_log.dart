// import 'package:flutter/material.dart';
// import 'package:hammer_ops/di/injector.dart';
// import 'package:hammer_ops/services/service.dart'; // where AppService lives
// import 'package:hammer_ops/database/database.dart';

// class InjuryFormScreen extends StatefulWidget {
//   final AppService service = getIt<AppService>();

//   /// Optionally pass in the userId of the reporter if known.
//   final int reportedByUserId;

//   InjuryFormScreen({
//     super.key,
//     required this.reportedByUserId,
//   });

//   @override
//   State<InjuryFormScreen> createState() => _InjuryFormScreenState();
// }

// class _InjuryFormScreenState extends State<InjuryFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descController = TextEditingController();
//   DateTime _selectedDate = DateTime.now();

//   bool _submitting = false;

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descController.dispose();
//     super.dispose();
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _submitting = true);

//     try {
//       await widget.service.injury.addInjury(
//         _descController.text,
//         _selectedDate,
//         widget.reportedByUserId,
//       );

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Injury reported successfully')),
//       );

//       Navigator.pop(context, true);
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting injury: $e')),
//       );
//     } finally {
//       if (mounted) setState(() => _submitting = false);
//     }
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) setState(() => _selectedDate = picked);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Report Injury')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                   labelText: 'Title',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     (value == null || value.isEmpty) ? 'Title is required' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _descController,
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 contentPadding: EdgeInsets.zero,
//                 title: const Text('Date of occurrence'),
//                 subtitle: Text(
//                   '${_selectedDate.toLocal()}'.split(' ')[0],
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 trailing: const Icon(Icons.calendar_today),
//                 onTap: _pickDate,
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   icon: _submitting
//                       ? const SizedBox(
//                           height: 18,
//                           width: 18,
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         )
//                       : const Icon(Icons.send),
//                   label: Text(_submitting ? 'Submitting...' : 'Submit'),
//                   onPressed: _submitting ? null : _submit,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:drift/src/runtime/data_class.dart';
import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart'; // AppService
import 'package:hammer_ops/database/database.dart';


class InjuryFormScreen extends StatefulWidget {
  final AppService service = getIt<AppService>();

  /// Optionally pass in the userId of the reporter if known.
  // final int reportedByUserId;

  InjuryFormScreen({
    super.key,
    // required this.reportedByUserId,
  });

  @override
  State<InjuryFormScreen> createState() => _InjuryFormScreenState();
}

class _InjuryFormScreenState extends State<InjuryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  bool _submitting = false;
  int? _selectedUserId;
  int? _selectedCustomerId;
  late Future<List<User>> _usersFuture;
  late Future<List<Customer>> _custFuture;

  @override
  void initState() {
    super.initState();
    // Query all users from DB
    _usersFuture = widget.service.user.getAllUsers(); // Assuming this exists
    _custFuture = widget.service.customer.getAllCustomers();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a user')),
      );
      return;
    }

    setState(() => _submitting = true);

    try {
      await widget.service.injury.addInjury(
        _titleController.text,
        _descController.text as Value<String?>,
        _selectedDate,
        _selectedUserId! as Value<int?>,
        _selectedCustomerId! as Value<int?>,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Injury reported successfully')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting injury: $e')),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Injury')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date of occurrence'),
                subtitle: Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),

              // === USER DROPDOWN ===
              FutureBuilder<List<User>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error loading users: ${snapshot.error}');
                  }

                  final users = snapshot.data ?? [];
                  if (users.isEmpty) {
                    return const Text('No users found');
                  }

                  return DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Reported by',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedUserId,
                    items: users
                        .map(
                          (u) => DropdownMenuItem<int>(
                            value: u.id,
                            child: Text(u.name ?? 'User ${u.id}'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() => _selectedUserId = val),
                    validator: (val) =>
                        val == null ? 'Please select a reporting user' : null,
                  );
                },
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: _submitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: Text(_submitting ? 'Submitting...' : 'Submit'),
                  onPressed: _submitting ? null : _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
