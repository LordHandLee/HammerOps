import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hammer_ops/di/injector.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:hammer_ops/services/service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppService service = getIt<AppService>();
  late Future<_ProfileData> _dataFuture;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _jobCtrl = TextEditingController();
  String? _profileImagePath;
  int? _selectedCertId;

  @override
  void initState() {
    super.initState();
    _dataFuture = _load();
  }

  Future<_ProfileData> _load() async {
    User? user;
    try {
      final id = service.user.getCurrentUser();
      user = await service.user.getUserById(id);
    } catch (_) {}
    user ??= (await service.user.getAllUsers()).firstOrNull;
    final certs = await service.certification.getAll();
    if (user != null) {
      _nameCtrl.text = user.name;
      _jobCtrl.text = user.jobTitle ?? '';
      _profileImagePath = user.profileImagePath;
      _selectedCertId = user.certificationId;
    }
    return _ProfileData(user: user, certifications: certs);
  }

  Future<void> _pickImage() async {
    final res = await FilePicker.platform.pickFiles(type: FileType.image);
    if (res == null || res.files.isEmpty) return;
    final path = res.files.first.path;
    if (path != null) {
      setState(() => _profileImagePath = path);
    }
  }

  Future<void> _save(User user) async {
    await service.user.updateProfile(
      id: user.id,
      jobTitle: _jobCtrl.text.trim().isEmpty ? null : _jobCtrl.text.trim(),
      certificationId: _selectedCertId,
      profileImagePath: _profileImagePath,
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
      setState(() {
        _dataFuture = _load();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 84, 125, 157),
      body: FutureBuilder<_ProfileData>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data!;
          final user = data.user;
          if (user == null) {
            return const Center(child: Text('No user found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _profileImagePath != null ? AssetImage(_profileImagePath!) as ImageProvider : null,
                        child: _profileImagePath == null
                            ? const Icon(Icons.person, size: 50, color: Colors.grey)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name, style: const TextStyle(color: Colors.white, fontSize: 24)),
                        Text(_jobCtrl.text.isEmpty ? 'Job title' : _jobCtrl.text,
                            style: const TextStyle(color: Colors.white, fontSize: 18)),
                        Text('Company ID: ${user.companyId}',
                            style: const TextStyle(color: Colors.white, fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _jobCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Job title',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int?>(
                  value: _selectedCertId,
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('No certification'),
                    ),
                    ...data.certifications.map(
                      (c) => DropdownMenuItem<int?>(
                        value: c.id,
                        child: Text(c.name),
                      ),
                    ),
                  ],
                  onChanged: (val) => setState(() => _selectedCertId = val),
                  decoration: const InputDecoration(
                    labelText: 'Certification',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _save(user),
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfileData {
  final User? user;
  final List<Certification> certifications;
  _ProfileData({required this.user, required this.certifications});
}
