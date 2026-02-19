import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:hammer_ops/database/repository.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:drift/drift.dart';
import 'package:hammer_ops/services/calendar_sync.dart';
import 'package:hammer_ops/services/api_client.dart';
import 'package:hammer_ops/services/auth_api.dart';
import 'package:hammer_ops/services/token_storage.dart';
import 'package:hammer_ops/services/sync_service.dart';
import 'package:hammer_ops/services/sync_coordinator.dart';


class TemplateService {
  final TemplateRepository templateRepository;

  TemplateService(this.templateRepository);

  Future<int> createTemplate(String name, int createdBy, List<String> fields) async {
    // enforce rules
    // final fieldNames = fields.map((f) => f.name.value.toLowerCase()).toSet();
    final fieldNames = fields.map((f) => (f).toLowerCase()).toSet();
    print("Field names: $fieldNames");

    final hasHours = fieldNames.contains("hourly rate");
    final hasSqft  = fieldNames.contains("square footage");
    final both = fieldNames.contains("both");

    if (both) {
      // ensure all four fields are present
      print("Both detected, adding all four fields");
      fields.remove('both');
      fields.add("hours worked");
      fields.add("hourly rate");
      fields.add("square footage");
      fields.add("price per square foot");
    }
    else if (hasHours && !hasSqft) {
      // hours worked + hourly rate
      fields.add("hours worked");
      //fields.add("hourly rate");
    }
    else if (!hasHours && hasSqft) {
      // square footage + price per square foot
      //fields.add("square footage");
      fields.add("price per square foot");
    }
    else {
      throw Exception("Template must include (hours worked + hourly rate) or (square footage + price per square foot)");
    }

    final templateId = await templateRepository.addTemplate(name, createdBy);
    for (var field in fields) {
      await templateRepository.addTemplateField(
        templateId,
        field,
        // field['fieldType'],
        // isRequired: field['isRequired'] ?? false,
        // sortOrder: field['sortOrder'] ?? 0,
      );
    }
    return templateId;
  }

  Future<TemplateWithFields?> getTemplateWithFields(int templateId) {
    return templateRepository.getTemplateWithFields(templateId);
  }

  Future<List<Template>> getAllTemplates() {
    return templateRepository.getAllTemplates();
  }
}

class QuoteService {
  final QuoteRepository quoteRepository;
  final TemplateRepository templateRepository;

  QuoteService(this.quoteRepository, this.templateRepository);

  Future<List<JobQuote>> getAllQuotes() {
    return quoteRepository.getAllQuotes();
  }

  Future<double> previewQuotePrice(int templateId, Map<int, double> inputValues) async {
    // 1. Load template fields
    final templateWithFields = await templateRepository.getTemplateWithFields(templateId);

    if (templateWithFields == null) {
      throw Exception("Template with ID $templateId not found.");
    }

    double total = 0.0;
    double? hours, hourlyRate, sqft, pricePerSqft;

    for (final field in templateWithFields.fields) {
      final value = inputValues[field.id] ?? 0.0;

      switch (field.fieldName.toLowerCase()) {
        case "hours worked":
          hours = value;
          break;
        case "hourly rate":
          hourlyRate = value;
          break;
        case "square footage":
          sqft = value;
          break;
        case "price per square foot":
          pricePerSqft = value;
          break;
        default:
          total += value; // treat as expense
      }
    }

    if (hours != null && hourlyRate != null) {
      total += hours * hourlyRate;
    }

    if (sqft != null && pricePerSqft != null) {
      total += sqft * pricePerSqft;
    }

    return total;
  }


  // Future<int> calculateQuotePrice(List<String> fieldValues) async {
  //   // Dummy logic: each field value adds $100
  //   for (var value in fieldValues) {
  //     if (value.isEmpty) {
  //       throw Exception("Field values cannot be empty");
  //     }
  //   }
  // }

  Future<String> createQuoteFromTemplate(int userId, String customerName, String customerContact, int templateId, amount, List<String> fieldValues) async {
    // Basic validation
    if (fieldValues.isEmpty) {
      return "Error: Field values cannot be empty";
    }

    // Calculate total amount based on field values (dummy logic here)
    // Create quote companion
    final quote = JobQuotesCompanion.insert(
      templateId: templateId,
      customerName: customerName,
      customerContact: customerContact,
      totalAmount: Value(amount),
      createdBy: userId,
    );

    // Create field value companions
    final fieldValueCompanions = <QuoteFieldValuesCompanion>[];


    try {
      // Fetch template fields to map names to IDs
      final templateWithFields = await templateRepository.getTemplateWithFields(templateId);
      if (templateWithFields == null) {
        return "Error: Template with ID $templateId not found.";
      }
      for (int i = 0; i < templateWithFields.fields.length; i++) {
        final field = templateWithFields.fields[i];
        final value = i < fieldValues.length ? fieldValues[i] : '';
        fieldValueCompanions.add(QuoteFieldValuesCompanion.insert(
          quoteId: 0, // Placeholder, will be set in transaction
          fieldId: field.id,
          fieldValue: Value(value),
        ));
      }
      await quoteRepository.createQuoteFromTemplate(quote, fieldValueCompanions);
      return "Quote created successfully from template";
    } catch (e) {
      return "Error creating quote: $e";
    }
  }

  // /// Business logic: add quote with validation and extra rules
  // Future<String> createQuote(int userId, String description, double price) async {
  //   if (price < 0) {
  //     return "Error: Price cannot be negative";
  //   }

  //   // Rule: mark high-value quotes
  //   String desc = description;
  //   if (price > 10000) {
  //     desc = "[HIGH VALUE] $description";
  //   }

  //   // Rule: if user has too many quotes, flag it
  //   final existingQuotes = await quoteRepository.getQuotesForUser(userId);
  //   if (existingQuotes.length >= 5) {
  //     desc = "[REVIEW REQUIRED] $desc";
  //   }

  //   await quoteRepository.addQuote(userId, desc, price);
  //   return "Quote created successfully";
  // }

  // /// Business logic: calculate total value of user’s quotes
  // Future<double> calculateTotalForUser(int userId) async {
  //   final quotes = await quoteRepository.getQuotesForUser(userId);
  //   return quotes.fold(0.0, (sum, q) => sum + q.price);
  // }

  // /// Business logic: find “VIP” users with total quotes > $50,000
  // Stream<List<User>> watchVipUsers() {
  //   return quoteRepository.watchUsersWithQuotes().map((userList) {
  //     return userList
  //         .where((uwq) =>
  //             uwq.quotes.fold(0.0, (sum, q) => sum + q.price) > 50000)
  //         .map((uwq) => uwq.user)
  //         .toList();
  //   });
  // }
}

class AuthResult {
  final Account account;
  final int? companyId;

  AuthResult({required this.account, this.companyId});
}

class AuthService {
  final AccountRepository accountRepository;
  final CompanyRepository companyRepository;
  final UserRepository userRepository;
  final AuthApi authApi;
  final TokenStorage tokenStorage;

  AuthService(
    this.accountRepository,
    this.companyRepository,
    this.userRepository, {
    required this.authApi,
    required this.tokenStorage,
  });

  Future<SignupResult> signUp({
    required String email,
    required String password,
    String? companyName,
    String? inviteCode,
  }) async {
    final remote = await authApi.signup(
      email: email,
      password: password,
      companyName: companyName,
      inviteCode: inviteCode,
    );
    return remote;
  }

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final remote = await authApi.login(email: email, password: password);
      await tokenStorage.saveTokens(
        accessToken: remote.accessToken,
        refreshToken: remote.refreshToken,
        accountId: remote.accountId,
        companyId: remote.companyId,
        email: email,
      );
      await accountRepository.updateLastSeen(remote.accountId, DateTime.now());
      return AuthResult(
        account: Account(
          id: remote.accountId,
          email: email,
          passwordHash: 'REMOTE',
          passwordSalt: 'REMOTE',
          isEmailVerified: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          lastSeen: DateTime.now(),
          version: 0,
          deletedAt: null,
        ),
        companyId: remote.companyId,
      );
    } catch (e) {
      // Fallback: allow offline if tokens are cached
      final cached = await tokenStorage.load();
      if (cached != null && cached.email == email) {
        return AuthResult(
          account: Account(
            id: cached.accountId,
            email: email,
            passwordHash: 'CACHED',
            passwordSalt: 'CACHED',
            isEmailVerified: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            lastSeen: DateTime.now(),
            version: 0,
            deletedAt: null,
          ),
          companyId: cached.companyId,
        );
      }
      rethrow;
    }
  }

  Future<InviteResult> inviteEmployee({required String email}) async {
    final tokens = await tokenStorage.load();
    if (tokens == null) {
      throw Exception('Not authenticated');
    }
    return authApi.invite(email: email, accessToken: tokens.accessToken);
  }

  String _generateSalt({int length = 16}) {
    final random = Random.secure();
    final bytes = List<int>.generate(length, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  String _hashPassword(String password, String saltBase64,
      {int iterations = 100000, int keyLength = 32}) {
    final salt = base64Decode(saltBase64);
    final derived = _pbkdf2(password, salt, iterations: iterations, keyLength: keyLength);
    return base64Encode(derived);
  }

  Uint8List _pbkdf2(
    String password,
    List<int> salt, {
    int iterations = 100000,
    int keyLength = 32,
  }) {
    final hmac = Hmac(sha256, utf8.encode(password));
    final hashLength = hmac.convert(<int>[]).bytes.length;
    final blockCount = (keyLength + hashLength - 1) ~/ hashLength;
    final output = BytesBuilder();

    for (var blockIndex = 1; blockIndex <= blockCount; blockIndex++) {
      final blockInput = Uint8List.fromList([
        ...salt,
        ..._int32BigEndian(blockIndex),
      ]);

      var u = hmac.convert(blockInput).bytes;
      final t = Uint8List.fromList(u);

      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }

      output.add(t);
    }

    final derived = output.takeBytes();
    return Uint8List.fromList(derived.sublist(0, keyLength));
  }

  List<int> _int32BigEndian(int i) => [
        (i >> 24) & 0xff,
        (i >> 16) & 0xff,
        (i >> 8) & 0xff,
        i & 0xff,
      ];
  }



class UserService {
  final UserRepository userRepository;
  int? _currentUserId;

  UserService(this.userRepository);

  void setCurrentUser(int userId) {
    _currentUserId = userId;
  }

  // Simulate getting current logged-in user ID
  int getCurrentUser() {
    if (_currentUserId == null) {
      throw StateError("No user is currently logged in.");
    }
    // In real app, integrate with auth system
    return _currentUserId!;
  }

  Future<int> addUser({
    required String name,
    required int companyId,
    required int accountId,
    int? age,
    String? employer,
    String? role,
  }) {
    return userRepository.addUserWithAccount(
      name: name,
      accountId: accountId,
      companyId: companyId,
      age: age,
      employer: employer,
      role: role,
    );
  }
  // Future<User?> getUserById(int id) {
  //   return userRepository.getUserById(id);
  // }

  Future<List<User>> getAllUsers() {
    return userRepository.getUsers();
  }

  Future<User?> getUserById(int id) => userRepository.getUserById(id);

  Future<int> updateProfile({
    required int id,
    String? jobTitle,
    int? certificationId,
    String? profileImagePath,
  }) =>
      userRepository.updateProfileFields(
        id: id,
        jobTitle: jobTitle,
        certificationId: certificationId,
        profileImagePath: profileImagePath,
      );
}

class CompanyService {
  final CompanyRepository companyRepository;

  CompanyService(this.companyRepository);

  Future<int> addCompany({
    required String name,
    required int adminAccountId,
    String? address,
  }) {
    return companyRepository.addCompany(
      name,
      adminAccountId,
      address: address,
    );
  }

  // Future<Company?> getCompanyById(int id) {
  //   return companyRepository.getCompanyById(id);
  // }

  Future<List<CompanyData>> getAllCompanies() {
    return companyRepository.getAllCompanies();
  }
}

class JobService {
  final JobRepository jobRepository;

  JobService(this.jobRepository);

  Future<int> addJob(int quoteId, String name, String? jobStatus, int customer, int? assignedTo) {
    return jobRepository.addJob(quoteId, name, jobStatus, customer, assignedTo);
  }
  Future<Job?> getJobById(int id) => jobRepository.getJobById(id);

  Future<int> updateJob(
      int id,
      int quoteId,
      String name,
      String? status,
      int customerId,
      int assignedTo) {
    return jobRepository.updateJob(
      id,
      quoteId,
      name,
      status,
      customerId,
      assignedTo,
    );
  }

  Future<List<Job>> getAllJobs() {
    return jobRepository.getAllJobs();
  }
}

class CustomerService {
  final CustomerRepository customerRepository;

  CustomerService(this.customerRepository);

  Future<int> addCustomer(
    String name,
    String contactInfo,
    int managedBy, {
    int? id,
    String? address,
  }) {
    return customerRepository.addCustomer(
      name,
      contactInfo,
      managedBy,
      id: id,
      address: address,
    );
  }

  Future<List<Customer>> getAllCustomers() {
    return customerRepository.getAllCustomers();
  }

  Future<int> updateCustomer({
    required int id,
    required String name,
    required String contactInfo,
    String? address,
    int? version,
  }) {
    return customerRepository.updateCustomer(
      id: id,
      name: name,
      contactInfo: contactInfo,
      address: address,
      version: version,
    );
  }

  Future<int> deleteCustomer(int id) {
    return customerRepository.deleteCustomer(id);
  }
}

// class ToolService {
//   final ToolRepository toolRepository;

//   ToolService(this.toolRepository);

//   Future<int> addTool(String name, String description, int managedBy) {
//     return toolRepository.addTool(name, description, managedBy);
//   }

//   Future<List<Tool>> getAllTools() {
//     return toolRepository.getAllTools();
//   }
// }

class TaskService {
  final TaskRepository taskRepository;

  TaskService(this.taskRepository);

  Future<int> addTask({
    required String title,
    required int jobId,
    required int assignedTo,
    String description = '',
    DateTime? dueDate,
  }) {
    return taskRepository.addTask(
      title: title,
      jobId: jobId,
      assignedTo: assignedTo,
      description: description,
      dueDate: dueDate,
    );
  }

  Future<List<Task>> getAllTasks() {
    return taskRepository.getAllTasks();
  }

    // --- New Flag Feature ---
  Future<int> flagTask(int taskId, String reason) => taskRepository.flagTask(taskId, reason);

  Future<int> unflagTask(int taskId) => taskRepository.unflagTask(taskId);

  Future<List<Task>> getFlaggedTasks() => taskRepository.getFlaggedTasks();

  Stream<List<Task>> watchAllTasks() => taskRepository.watchAllTasks();

  Future<int> updateTask({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    int? assignedTo,
  }) =>
      taskRepository.updateTask(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        isCompleted: isCompleted,
        assignedTo: assignedTo,
      );

  Future<int> deleteTask(int id) => taskRepository.deleteTask(id);

  Future<List<Task>> getTasksForJob(int jobId) => taskRepository.getTasksForJob(jobId);

  Stream<List<Task>> watchTasksForJob(int jobId) => taskRepository.watchTasksForJob(jobId);
}

class DocumentService {
  final DocumentRepository repository;
  final UserService userService;

  DocumentService(this.repository, this.userService);

  int _currentUserOrFallback() {
    try {
      return userService.getCurrentUser();
    } catch (_) {
      return 1;
    }
  }

  Future<int> addDocument({
    required String title,
    required String filePath,
    int? jobId,
    int? customerId,
  }) {
    return repository.addDocument(
      title: title,
      filePath: filePath,
      uploadedBy: _currentUserOrFallback(),
      jobId: jobId,
      customerId: customerId,
    );
  }

  Future<List<Document>> getAllDocuments() => repository.getAllDocuments();
  Future<List<Document>> getDocumentsByJob(int jobId) => repository.getDocumentsByJob(jobId);
  Future<List<Document>> getDocumentsWithoutJob() => repository.getDocumentsWithoutJob();
  Future<int> deleteDocument(int id) => repository.deleteDocument(id);
}

class CertificationService {
  final CertificationRepository repository;

  CertificationService(this.repository);

  Future<List<Certification>> getAll() => repository.getAll();
  Future<int> addCertification({
    required String name,
    String? issuer,
    DateTime? expiresAt,
  }) =>
      repository.addCertification(name: name, issuer: issuer, expiresAt: expiresAt);
}

class ToolService {
  final ToolRepository toolRepository;
  final UserService userService;

  ToolService(this.toolRepository, this.userService);

  int _currentUserOrFallback() {
    try {
      return userService.getCurrentUser();
    } catch (_) {
      return 1;
    }
  }

  Future<int> addTool(String name, String description) {
    return toolRepository.addTool(name, description, _currentUserOrFallback());
  }

  Future<List<Tool>> getAllTools() => toolRepository.getAllTools();

  Future<Tool?> getToolById(int id) => toolRepository.getToolById(id);

  Future<int> checkoutTool(int id) {
    return toolRepository.updateAvailability(
      id: id,
      isAvailable: false,
      managedBy: _currentUserOrFallback(),
    );
  }

  Future<int> returnTool(int id) {
    return toolRepository.updateAvailability(
      id: id,
      isAvailable: true,
      managedBy: _currentUserOrFallback(),
    );
  }
}

class ComplaintService {
  final ComplaintRepository complaintRepository;

  ComplaintService(this.complaintRepository);

  Future<int> addComplaint(String title, Value<String?> description, DateTime dateFiled, int reportedBy, int assignedTo, int reportedByCustomer) {
    return complaintRepository.addComplaint(title, description, dateFiled, reportedBy, assignedTo, reportedByCustomer);
  }

  Future<List<ComplaintData>> getAllComplaints() {
    return complaintRepository.getAllComplaints();
  }
}

class InjuryService {
  final InjuryRepository injuryRepository;

  InjuryService(this.injuryRepository);

  Future<int> addInjury(String title, Value<String?> description, DateTime dateOccurred, Value<int?> reportedByUser,
  Value<int?> reportedByCust) {
    // final injury = InjuryCompanion.insert(
    //   description: description,
    //   dateOccurred: dateOccurred,
    //   reportedBy: reportedBy,
    // );
    return injuryRepository.addInjury(title, description, dateOccurred, reportedByUser, reportedByCust);
  }

  Future<List<InjuryData>> getAllInjuries() {
    return injuryRepository.getAllInjuries();
  }
}

// class DocumentService {
//   final DocumentRepository documentRepository;

//   DocumentService(this.documentRepository);

//   Future<int> addDocument(String title, String filePath, int uploadedBy) {
//     final document = DocumentCompanion.insert(
//       title: title,
//       filePath: filePath,
//       uploadedBy: uploadedBy,
//     );
//     return documentRepository.addDocument(document);
//   }

//   Future<List<DocumentData>> getAllDocuments() {
//     return documentRepository.getAllDocuments();
//   }
// }

class FleetEventService {
  final FleetEventRepository repository;
  final CalendarSync calendarSync;

  FleetEventService(this.repository, {CalendarSync? calendarSync})
      : calendarSync = calendarSync ?? CalendarSync();

  // Get future events (from DB)
  Future<List<FleetEvent>> getFutureEvents() {
    return repository.getFutureEvents();
  }

  // Add a new event (optionally sync with device calendar)
  Future<void> addEvent({
    required String vehicleName,
    required String eventType,
    required DateTime date,
    String? notes,
    bool addToCalendar = true,
  }) async {
    final event = FleetEventsCompanion.insert(
      vehicleName: vehicleName,
      eventType: eventType,
      date: date,
      notes: Value(notes),
    );

    final id = await repository.addEvent(event);

    if (addToCalendar) {
      try {
        final extId = await calendarSync.upsertEvent(
          title: '$vehicleName - $eventType',
          start: date,
          end: date.add(const Duration(hours: 1)),
          notes: notes,
        );
        if (extId != null) {
          await repository.updateCalendarId(id, extId);
        }
      } catch (_) {
        // ignore calendar failures
      }
    }
  }

  // Update existing event
  Future<void> updateEvent(FleetEvent event, {bool updateCalendar = true}) async {
    final updated = FleetEventsCompanion(
      id: Value(event.id),
      vehicleName: Value(event.vehicleName),
      eventType: Value(event.eventType),
      date: Value(event.date),
      notes: Value(event.notes),
    );

    await repository.updateEvent(updated);

    if (updateCalendar) {
      try {
        final extId = await calendarSync.upsertEvent(
          title: '${event.vehicleName} - ${event.eventType}',
          start: event.date,
          end: event.date.add(const Duration(hours: 1)),
          notes: event.notes,
          externalId: event.calendarEventId,
        );
        if (extId != null && extId != event.calendarEventId) {
          await repository.updateCalendarId(event.id, extId);
        }
      } catch (_) {}
    }
  }

  // Delete event
  Future<void> deleteEvent(FleetEvent event, {bool removeFromCalendar = true}) async {
    await repository.deleteEvent(event.id);
    if (removeFromCalendar && event.calendarEventId != null) {
      try {
        await calendarSync.deleteEvent(event.calendarEventId!);
      } catch (_) {}
    }
  }
}

class ChecklistService {
  final ChecklistRepository repo;

  ChecklistService(this.repo);

  Future<ChecklistTemplateWithItems> getChecklist(int id) =>
    repo.loadChecklistById(id);

  Future<ChecklistTemplateWithItems> getChecklistByCode(String code) =>
      repo.loadChecklistByCode(code);

  // Debug helpers
  Future<List<ChecklistItem>> getItemsForTemplateId(int id) => repo.getItemsForTemplateId(id);
  Future<ChecklistTemplate> getTemplateRawById(int id) => repo.getTemplateRawById(id);

  Future<int> submit(
      String code, int userId, List<ChecklistItemRunInput> items) async {

    final template = await repo.loadChecklist(code);
    return repo.submitChecklist(template.template.id, userId, items);
  }

  Future<void> addTemplate(
    String code, String name) async {
      final template = ChecklistTemplatesCompanion.insert(
        // id: Value(id),
        code: code,
        name: name,
      );
    await repo.addTemplate(template);
  }
  Future<void> deleteTemplate(int id) => repo.deleteTemplate(id);
  Future<List<ChecklistTemplate>> getAllTemplates() => repo.getAllTemplates();
  Future<void> updateTemplateItems(int templateId, List<ChecklistItem> items) => repo.updateTemplateItems(templateId, items);

}


// task, complaint, injury, document, 


class AppService {
  final TemplateService template;
  final QuoteService quote;
  final UserService user;
  final CompanyService company;
  final FleetEventService fleet;
  final ComplaintService complaint;
  final CustomerService customer;
  late final ToolService tool;
  final TaskService task;
  final InjuryService injury;
  late final DocumentService document;
  late final CertificationService certification;
  final ChecklistService checklist;
  final JobService jobs;
  final AuthService auth;
  final SyncService sync;
  final SyncCoordinator syncCoordinator;

  AppService(AppRepository repo, AppDatabase db)
      : template = TemplateService(repo.template),
        user = UserService(repo.user),
        company = CompanyService(repo.company),
        quote = QuoteService(repo.quote, repo.template),
        fleet = FleetEventService(repo.fleet),
        complaint = ComplaintService(repo.complaint),
        customer = CustomerService(repo.customer),
        task = TaskService(repo.task),
        injury = InjuryService(repo.injury),
        checklist = ChecklistService(repo.checklist),
        jobs = JobService(repo.jobs),
        auth = AuthService(
          repo.account,
          repo.company,
          repo.user,
          authApi: AuthApi(ApiClient()),
          tokenStorage: TokenStorage(),
        ),
        sync = SyncService(ApiClient(), TokenStorage()),
        syncCoordinator = SyncCoordinator(
          db,
          repo.localChanges,
          SyncService(ApiClient(), TokenStorage()),
        ) {
    tool = ToolService(repo.tool, user);
    document = DocumentService(repo.document, user);
    certification = CertificationService(repo.certification);
  }
}
