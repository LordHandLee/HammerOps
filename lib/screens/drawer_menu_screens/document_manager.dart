import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/services/service.dart';

class DocumentManagerScreen extends StatefulWidget {
  const DocumentManagerScreen({super.key});

  @override
  State<DocumentManagerScreen> createState() => _DocumentManagerScreenState();
}

class _DocumentManagerScreenState extends State<DocumentManagerScreen> {
  final AppService service = getIt<AppService>();
  late Future<List<Job>> _jobsFuture;
  late Future<List<Document>> _allDocsFuture;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _jobsFuture = service.jobs.getAllJobs();
    _allDocsFuture = service.document.getAllDocuments();
  }

  Future<void> _refresh() async {
    setState(_load);
  }

  Future<void> _pickAndSave() async {
    final res = await FilePicker.platform.pickFiles();
    if (res == null || res.files.isEmpty) return;
    final file = res.files.first;
    final path = file.path;
    final name = file.name;
    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No path available for this file')),
      );
      return;
    }
    // choose job (optional)
    final jobs = await _jobsFuture;
    int? selectedJobId;
    if (mounted && jobs.isNotEmpty) {
      selectedJobId = await showModalBottomSheet<int>(
        context: context,
        builder: (_) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(title: Text('Assign to job (optional)')),
                ListTile(
                  leading: const Icon(Icons.clear),
                  title: const Text('No job'),
                  onTap: () => Navigator.pop(context, null),
                ),
                ...jobs.map((j) => ListTile(
                      leading: const Icon(Icons.work),
                      title: Text(j.name),
                      onTap: () => Navigator.pop(context, j.id),
                    )),
              ],
            ),
          );
        },
      );
    }
    await service.document.addDocument(
      title: name,
      filePath: path,
      jobId: selectedJobId,
    );
    if (mounted) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        backgroundColor: const Color.fromARGB(255, 195, 189, 170),
        title: const Text('Document Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickAndSave,
        child: const Icon(Icons.upload_file),
      ),
      body: FutureBuilder<List<Document>>(
        future: _allDocsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final docs = snapshot.data ?? [];
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No documents yet.'),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Add document'),
                    onPressed: _pickAndSave,
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final d = docs[index];
                return ListTile(
                  leading: const Icon(Icons.insert_drive_file),
                  title: Text(d.title),
                  subtitle: Text(d.filePath),
                  trailing: Text(d.jobId != null ? 'Job ${d.jobId}' : 'No job'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
