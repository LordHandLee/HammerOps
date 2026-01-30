import 'database.dart';
import 'package:drift/drift.dart';

class UserRepository {
  final UserDao userDao;

  UserRepository(this.userDao);

  Stream<List<User>> watchUsers() => userDao.watchAllUsers();
  Future<List<User>> getUsers() => userDao.getAllUsers();

  // Future<int> addUser(String name, int? age) {
  //   final user = UsersCompanion.insert(name: name, age: Value(age));
  //   return userDao.insertUser(user);
  // }

  Future<int> addUser(UsersCompanion user) => userDao.insertUser(user);
  Future<int> addUserWithAccount({
    required String name,
    required int accountId,
    required int companyId,
    int? age,
    String? employer,
    String? role,
  }) {
    final companion = UsersCompanion.insert(
      accountId: accountId,
      name: name,
      companyId: companyId,
      age: Value(age),
      employer: Value(employer),
      role: Value(role ?? 'user'),
    );
    return userDao.insertUser(companion);
  }
  Future<bool> editUser(User user) => userDao.updateUser(user);
  Future<int> removeUser(User user) => userDao.deleteUser(user);
  Future<User?> getUserById(int id) => userDao.getUserById(id);
  Future<int> updateProfileFields({
    required int id,
    String? jobTitle,
    int? certificationId,
    String? profileImagePath,
  }) =>
      userDao.updateProfileFields(
        id: id,
        jobTitle: jobTitle,
        certificationId: certificationId,
        profileImagePath: profileImagePath,
      );
}

class TemplateRepository {
  final TemplatesDao templatesDao;

  TemplateRepository(this.templatesDao);

  Future<int> addTemplate(String name, int createdBy) {
    final template = TemplatesCompanion.insert(name: name, createdBy: createdBy);
    return templatesDao.insertTemplate(template);
  }

  Future<int> addTemplateField(int templateId, String fieldName, {bool isRequired = false, int sortOrder = 0}) {
    final field = TemplateFieldsCompanion.insert(
      templateId: templateId,
      fieldName: fieldName,
      // fieldType: fieldType,
      isRequired: Value(isRequired),
      sortOrder: Value(sortOrder),
    );
    return templatesDao.insertTemplateField(field);
  }

  Future<List<Template>> getAllTemplates() => templatesDao.getAllTemplates();

  Future<TemplateWithFields?> getTemplateWithFields(int templateId) => templatesDao.getTemplateWithFields(templateId);
}

class QuoteRepository {
  final JobQuotesDao jobQuotesDao;
 
  // final TemplatesDao templatesDao;

  QuoteRepository(this.jobQuotesDao);

  Future<List<JobQuote>> getAllQuotes() => jobQuotesDao.select(jobQuotesDao.jobQuotes).get();

  Future<int> createQuoteFromTemplate(quote, fieldValues) => jobQuotesDao.createQuoteWithFields(quote, fieldValues);


  // Future<int> addQuote(int userId, String description, double price) {
  //   final quote = JobQuotesCompanion.insert(
  //     templateId: 1, // Assuming a default template for simplicity
  //     customerName: description,
  //     customerContact: 'N/A',
  //     totalAmount: price,
  //     createdBy: userId,
  //   );
  //   return jobQuotesDao.insertJobQuote(quote);
  // }

  Future<List<JobQuote>> getQuotesForUser(int userId) {
    return (jobQuotesDao.select(jobQuotesDao.jobQuotes)
          ..where((q) => q.createdBy.equals(userId)))
        .get();
  }

}

//   Stream<List<UserWithQuotes>> watchUsersWithQuotes() {
//     final query = select(userDao.users).join([
//       leftOuterJoin(jobQuotesDao.jobQuotes, jobQuotesDao.jobQuotes.createdBy.equalsExp(userDao.users.id))
//     ]);

//     return query.watch().map((rows) {
//       final userMap = <int, UserWithQuotes>{};

//       for (var row in rows) {
//         final user = row.readTable(userDao.users);
//         final quote = row.readTableOrNull(jobQuotesDao.jobQuotes);

//         userMap.putIfAbsent(user.id, () => UserWithQuotes(user: user, quotes: []));
//         if (quote != null) {
//           userMap[user.id]!.quotes.add(quote);
//         }
//       }

//       return userMap.values.toList();
//     });
//   }
// }

class CompanyRepository {
  final CompanyDao companyDao;

  CompanyRepository(this.companyDao);

  Future<int> addCompany(String name, int adminAccountId, {String? address}) {
    final company = CompanyCompanion.insert(
      name: name,
      adminAccountId: adminAccountId,
      address: Value(address),
    );
    return companyDao.insertCompany(company);
  }

  Future<List<CompanyData>> getAllCompanies() => companyDao.getAllCompanies();
}

class JobRepository {
  final JobsDao jobsDao;

  JobRepository(this.jobsDao);

  Future<int> addJob(int quoteId, String name, String? jobStatus, int customer, int? assignedTo) {
    final job = JobsCompanion.insert(
      quoteId: quoteId,
      name: name,
      jobStatus: Value(jobStatus),
      customer: customer,
      assignedTo: Value(assignedTo),
    );
    return jobsDao.insertJob(job);
  }
  Future<Job?> getJobById(int id) => jobsDao.getJobById(id);

  Future<int> updateJob(
      int id,
      int quoteId,
      String name,
      String? status,
      int customerId,
      int assignedTo) {
    return jobsDao.updateJob(
      id: id,
      quoteId: quoteId,
      name: name,
      jobStatus: status,
      customerId: customerId,
      assignedTo: assignedTo,
    );
  }

  Future<List<Job>> getAllJobs() => jobsDao.getAllJobs();


}

class CustomerRepository {
  final CustomersDao customerDao;

  CustomerRepository(this.customerDao);

  Future<int> addCustomer(String name, String contactInfo, int user) {
    final customer = CustomersCompanion.insert(
      name: name,
      contactInfo: contactInfo,
      managedBy: user,
    );
    return customerDao.insertCustomer(customer);
  }

  Future<List<Customer>> getAllCustomers() => customerDao.getAllCustomers();

  Future<int> updateCustomer({
    required int id,
    required String name,
    required String contactInfo,
    String? address,
  }) {
    return customerDao.updateCustomer(
      id: id,
      name: name,
      contactInfo: contactInfo,
      address: address,
    );
  }

  Future<int> deleteCustomer(int id) => customerDao.deleteCustomer(id);
}

// class ToolRepository {
//   final ToolsDao toolsDao;

//   ToolRepository(this.toolsDao);

//   Future<int> addTool(String name, String description, int managedBy) {
//     final tool = ToolsCompanion.insert(
//       name: name,
//       description: Value(description),
//       managedBy: managedBy,
//     );
//     return toolsDao.insertTool(tool);
//   }

//   Future<List<Tool>> getAllTools() => toolsDao.getAllTools();
// }

class TaskRepository {
  final TasksDao tasksDao;

  TaskRepository(this.tasksDao);

  Future<int> addTask({
    required String title,
    required int jobId,
    required int assignedTo,
    String description = '',
    DateTime? dueDate,
  }) {
    final task = TasksCompanion.insert(
      title: title,
      description: Value(description),
      dueDate: Value(dueDate),
      jobId: jobId,
      assignedTo: assignedTo,
    );
    return tasksDao.insertTask(task);
  }

  Future<List<Task>> getAllTasks() => tasksDao.getAllTasks();
    // --- New Flag Methods ---
  Future<int> flagTask(int taskId, String reason) => tasksDao.flagTask(taskId, reason);
  Future<int> unflagTask(int taskId) => tasksDao.unflagTask(taskId);
  Future<List<Task>> getFlaggedTasks() => tasksDao.getFlaggedTasks();

  Stream<List<Task>> watchAllTasks() => tasksDao.watchAllTasks();

  Future<int> updateTask({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    int? assignedTo,
  }) =>
      tasksDao.updateTask(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        isCompleted: isCompleted,
        assignedTo: assignedTo,
      );

  Future<int> deleteTask(int id) => tasksDao.deleteTask(id);

  Future<List<Task>> getTasksForJob(int jobId) => tasksDao.getTasksForJob(jobId);

  Stream<List<Task>> watchTasksForJob(int jobId) => tasksDao.watchTasksForJob(jobId);

}

class ToolRepository {
  final ToolsDao toolsDao;

  ToolRepository(this.toolsDao);

  Future<int> addTool(String name, String description, int managedBy) {
    final tool = ToolsCompanion.insert(
      name: name,
      description: Value(description),
      managedBy: managedBy,
    );
    return toolsDao.insertTool(tool);
  }

  Future<List<Tool>> getAllTools() => toolsDao.getAllTools();

  Future<Tool?> getToolById(int id) => toolsDao.getToolById(id);

  Future<int> updateAvailability({
    required int id,
    required bool isAvailable,
    required int managedBy,
  }) {
    return toolsDao.updateTool(
      id: id,
      isAvailable: isAvailable,
      managedBy: managedBy,
    );
  }
}

class ComplaintRepository {
  final ComplaintDao complaintDao;

  ComplaintRepository(this.complaintDao);

  Future<int> addComplaint(String title, Value<String?> description, DateTime dateFiled, int reportedBy, int assignedTo, int reportedByCustomer) {
    final complaint = ComplaintCompanion.insert(
      title: title,
      description: description,
      reportedAt: Value(dateFiled),
      reportedByUser: reportedBy,
      assignedTo: assignedTo,
      reportedByCustomer: reportedByCustomer,
    );
    return complaintDao.insertComplaint(complaint);
  }

  Future<List<ComplaintData>> getAllComplaints() => complaintDao.getAllComplaints();
}

class InjuryRepository {
  final InjuryDao injuryDao;

  InjuryRepository(this.injuryDao);

  Future<int> addInjury(String title, Value<String?> description, DateTime dateOccurred, Value<int?> reportedByUser, Value<int?> reportedByCust) {
    final injury = InjuryCompanion.insert(
      title: title,
      description: description,
      occurredAt: Value(dateOccurred),
      reportedByUser: reportedByUser,
      reportedByCustomer: reportedByCust
    );
    return injuryDao.insertInjury(injury);
  }

  Future<List<InjuryData>> getAllInjuries() => injuryDao.getAllInjuries();
}

// class DocumentRepository {
//   final DocumentDao documentDao;

//   DocumentRepository(this.documentDao);

//   Future<int> addDocument(String title, String filePath, int uploadedBy) {
//     final document = DocumentCompanion.insert(
//       title: title,
//       filePath: filePath,
//       uploadedBy: uploadedBy,
//     );
//     return documentDao.insertDocument(document);
//   }

//   Future<List<DocumentData>> getAllDocuments() => documentDao.getAllDocuments();
// }

class FleetEventRepository {
  final FleetEventDao fleetDao;

  FleetEventRepository(this.fleetDao);

  Future<List<FleetEvent>> getFutureEvents() => fleetDao.getFutureEvents();
  Future<int> addEvent(FleetEventsCompanion event) => fleetDao.insertEvent(event);
  Future<void> updateEvent(FleetEventsCompanion event) => fleetDao.updateEvent(event);
  Future<void> deleteEvent(int id) => fleetDao.deleteEvent(id);

  Future<void> updateCalendarId(int id, String? calendarId) {
    return (fleetDao.update(fleetDao.fleetEvents)..where((t) => t.id.equals(id))).write(
      FleetEventsCompanion(
        calendarEventId: Value(calendarId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

class DocumentRepository {
  final DocumentDao dao;

  DocumentRepository(this.dao);

  Future<int> addDocument({
    required String title,
    required String filePath,
    required int uploadedBy,
    int? jobId,
    int? customerId,
  }) {
    final companion = DocumentsCompanion.insert(
      title: title,
      filePath: filePath,
      uploadedBy: uploadedBy,
      customerId: Value(customerId),
      jobId: Value(jobId),
    );
    return dao.insertDocument(companion);
  }

  Future<List<Document>> getAllDocuments() => dao.getAllDocuments();
  Future<List<Document>> getDocumentsByJob(int jobId) => dao.getDocumentsByJob(jobId);
  Future<List<Document>> getDocumentsWithoutJob() => dao.getDocumentsWithoutJob();
  Future<int> deleteDocument(int id) => dao.deleteDocument(id);
}

class CertificationRepository {
  final CertificationsDao dao;

  CertificationRepository(this.dao);

  Future<int> addCertification({
    required String name,
    String? issuer,
    DateTime? expiresAt,
  }) {
    final companion = CertificationsCompanion.insert(
      name: name,
      issuer: Value(issuer),
      expiresAt: Value(expiresAt),
    );
    return dao.insertCertification(companion);
  }

  Future<List<Certification>> getAll() => dao.getAllCertifications();
}

class ChecklistRepository {
  final ChecklistDao dao;

  ChecklistRepository(this.dao);
  
  Future<ChecklistTemplateWithItems> loadChecklistById(int id) =>
    dao.getTemplateWithItemsById(id);

  Future<ChecklistTemplateWithItems> loadChecklistByCode(String code) =>
      dao.getTemplateWithItems(code);

  // debug helpers
  Future<List<ChecklistItem>> getItemsForTemplateId(int id) => dao.getItemsForTemplateId(id);
  Future<ChecklistTemplate> getTemplateRawById(int id) => dao.getTemplateRawById(id);
  //get single template
  Future<ChecklistTemplateWithItems> loadChecklist(String code) =>
      dao.getTemplateWithItems(code);

  Future<int> submitChecklist(
      int templateId, int userId, List<ChecklistItemRunInput> items) {
    return dao.insertChecklistRun(templateId, userId, items);
  }

  Future<void> addTemplate(ChecklistTemplatesCompanion template) => dao.insertTemplate(template);
  // Future<void> updateEvent(FleetEventsCompanion event) => dao.updateEvent(event);
  Future<void> deleteTemplate(int id) => dao.deleteTemplate(id);
  Future<List<ChecklistTemplate>> getAllTemplates() => dao.getAllTemplates();

  Future<void> updateTemplateItems(int templateId, List<ChecklistItem> items) => dao.updateTemplateItems(templateId, items);

}

class AccountRepository {
  final AccountDao accounts;
  final AccountSessionDao sessions;
  final CompanyMemberDao members;

  AccountRepository(this.accounts, this.sessions, this.members);

  Future<int> createAccount({
    required String email,
    required String passwordHash,
    required String passwordSalt,
  }) {
    final companion = AccountsCompanion.insert(
      email: email,
      passwordHash: passwordHash,
      passwordSalt: Value(passwordSalt),
    );
    return accounts.insertAccount(companion);
  }

  Future<Account?> findAccountByEmail(String email) => accounts.findByEmail(email);

  Future<int> updateLastSeen(int accountId, DateTime timestamp) =>
      accounts.updateLastSeen(accountId, timestamp);

  Future<int> createSession({
    required int accountId,
    required String refreshTokenHash,
    required DateTime expiresAt,
  }) {
    final companion = AccountSessionsCompanion.insert(
      accountId: accountId,
      refreshTokenHash: refreshTokenHash,
      expiresAt: expiresAt,
    );
    return sessions.insertSession(companion);
  }

  Future<int> revokeSession(int sessionId) => sessions.revokeSession(sessionId);

  Future<int> addCompanyMember({
    required int companyId,
    required int accountId,
    required String role,
    int? invitedBy,
  }) {
    final companion = CompanyMembersCompanion.insert(
      companyId: companyId,
      accountId: accountId,
      role: role,
      invitedBy: Value(invitedBy),
    );
    return members.insertMember(companion);
  }

  Future<List<CompanyMember>> getMembersForCompany(int companyId) =>
      members.membersForCompany(companyId);
}

// task, complaint, injury repositories

class AppRepository {
  final UserRepository user;
  final TemplateRepository template;
  final QuoteRepository quote;
  final CompanyRepository company;
  final FleetEventRepository fleet;
  final ComplaintRepository complaint;
  final CustomerRepository customer;
  final ToolRepository tool;
  final TaskRepository task;
  final InjuryRepository injury;
  final ChecklistRepository checklist;
  final JobRepository jobs;
  final DocumentRepository document;
  final CertificationRepository certification;
  final AccountRepository account;
  final LocalChangeDao localChanges;

  AppRepository(AppDao dao)
      : user = UserRepository(dao.user),
        template = TemplateRepository(dao.template),
        company = CompanyRepository(dao.company),
        quote = QuoteRepository(dao.quote),
        fleet = FleetEventRepository(dao.fleetevent),
        complaint = ComplaintRepository(dao.complaint),
        customer = CustomerRepository(dao.customer),
        tool = ToolRepository(dao.tools),
        task = TaskRepository(dao.task),
        injury = InjuryRepository(dao.injury),
        checklist = ChecklistRepository(dao.checklist),
        jobs = JobRepository(dao.jobs),
        document = DocumentRepository(dao.document),
        certification = CertificationRepository(dao.certifications),
        account = AccountRepository(dao.account, dao.accountSession, dao.companyMember),
        localChanges = dao.localChanges;
}
