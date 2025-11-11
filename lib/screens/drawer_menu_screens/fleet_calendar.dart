import 'package:flutter/material.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:drift/drift.dart';

class AddEditFleetEventScreen extends StatefulWidget {
  final FleetEventService service;
  final FleetEvent? existingEvent; // null if adding

  const AddEditFleetEventScreen({super.key, required this.service, this.existingEvent});

  @override
  State<AddEditFleetEventScreen> createState() => _AddEditFleetEventScreenState();
}

class _AddEditFleetEventScreenState extends State<AddEditFleetEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _vehicleNameCtrl;
  late TextEditingController _eventTypeCtrl;
  late TextEditingController _notesCtrl;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existingEvent;
    _vehicleNameCtrl = TextEditingController(text: e?.vehicleName ?? '');
    _eventTypeCtrl = TextEditingController(text: e?.eventType ?? '');
    _notesCtrl = TextEditingController(text: e?.notes ?? '');
    _selectedDate = e?.date ?? DateTime.now();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
    );
    if (time == null) return;
    setState(() {
      _selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final vehicleName = _vehicleNameCtrl.text.trim();
    final eventType = _eventTypeCtrl.text.trim();
    final notes = _notesCtrl.text.trim();

    if (widget.existingEvent == null) {
      await widget.service.addEvent(
        vehicleName: vehicleName,
        eventType: eventType,
        date: _selectedDate!,
        notes: notes,
      );
    } else {
      final updated = widget.existingEvent!.copyWith(
        vehicleName: vehicleName,
        eventType: eventType,
        date: _selectedDate!,
        notes: Value(notes),
      );
      await widget.service.updateEvent(updated);
    }

    if (context.mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.existingEvent == null ? 'Add Event' : 'Edit Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _vehicleNameCtrl,
                decoration: const InputDecoration(labelText: 'Vehicle Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _eventTypeCtrl,
                decoration: const InputDecoration(labelText: 'Event Type'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Date: ${_selectedDate != null ? _selectedDate!.toLocal().toString() : 'Select...'}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              TextFormField(
                controller: _notesCtrl,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
