import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

class CustomerManagerScreen extends StatefulWidget {
  const CustomerManagerScreen({super.key});

  @override
  State<CustomerManagerScreen> createState() => _CustomerManagerScreenState();
}

class _CustomerManagerScreenState extends State<CustomerManagerScreen> {
  final AppService service = getIt<AppService>();
  late Future<List<Customer>> _customersFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _customersFuture = service.customer.getAllCustomers();
  }

  Future<void> _refresh() async {
    setState(_load);
  }

  int _managedByFallback() {
    try {
      return service.user.getCurrentUser();
    } catch (_) {
      return 1; // fallback when current user is not set
    }
  }

  Future<void> _showCustomerDialog({Customer? existing}) async {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final contactCtrl = TextEditingController(text: existing?.contactInfo ?? '');
    final addressCtrl = TextEditingController(text: existing?.address ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existing == null ? 'Add Customer' : 'Edit Customer'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: contactCtrl,
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                ),
                TextField(
                  controller: addressCtrl,
                  decoration: const InputDecoration(labelText: 'Address (optional)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final contact = contactCtrl.text.trim();
                if (name.isEmpty || contact.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name and contact are required')),
                  );
                  return;
                }
                if (existing == null) {
                  await service.customer.addCustomer(
                    name,
                    contact,
                    _managedByFallback(),
                  );
                } else {
                  await service.customer.updateCustomer(
                    id: existing.id,
                    name: name,
                    contactInfo: contact,
                    address: addressCtrl.text.trim().isEmpty
                        ? null
                        : addressCtrl.text.trim(),
                  );
                }
                if (context.mounted) Navigator.pop(context, true);
              },
              child: Text(existing == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _refresh();
    }
  }

  Future<void> _confirmDelete(Customer customer) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete customer'),
          content: Text('Delete "${customer.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await service.customer.deleteCustomer(customer.id);
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text('Customer Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add customer',
        onPressed: () => _showCustomerDialog(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Customer>>(
        future: _customersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final customers = snapshot.data ?? [];
          if (customers.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No customers yet.'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add customer'),
                    onPressed: () => _showCustomerDialog(),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final c = customers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(c.name),
                    subtitle: Text(c.contactInfo),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showCustomerDialog(existing: c),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _confirmDelete(c),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add customer'),
          onPressed: () => _showCustomerDialog(),
        ),
      ),
    );
  }
}
