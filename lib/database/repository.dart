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
  Future<bool> editUser(User user) => userDao.updateUser(user);
  Future<int> removeUser(User user) => userDao.deleteUser(user);
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

  Future<int> addCompany(String name) {
    final company = CompanyCompanion.insert(name: name);
    return companyDao.insertCompany(company);
  }

  Future<List<CompanyData>> getAllCompanies() => companyDao.getAllCompanies();
}

// class JobRepository {
//   final JobsDao jobsDao;

//   JobRepository(this.jobsDao);

//   Future<int> addJob(String title, String description, int assignedTo) {
//     final job = JobsCompanion.insert(
//       title: title,
//       description: Value(description),
//       assignedTo: assignedTo,
//     );
//     return jobsDao.insertJob(job);
//   }

//   Future<List<Job>> getAllJobs() => jobsDao.getAllJobs();
// }

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

  Future<int> addTask(String title, String description, DateTime? dueDate, int assignedTo) {
    final task = TasksCompanion.insert(
      title: title,
      description: Value(description),
      dueDate: Value(dueDate),
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
  Future<void> addEvent(FleetEventsCompanion event) => fleetDao.insertEvent(event);
  Future<void> updateEvent(FleetEventsCompanion event) => fleetDao.updateEvent(event);
  Future<void> deleteEvent(int id) => fleetDao.deleteEvent(id);
}

class ChecklistRepository {
  final ChecklistDao dao;

  ChecklistRepository(this.dao);

  Future<ChecklistTemplateWithItems> loadChecklist(String code) =>
      dao.getTemplateWithItems(code);

  Future<int> submitChecklist(
      int templateId, int userId, List<ChecklistItemRunInput> items) {
    return dao.insertChecklistRun(templateId, userId, items);
  }
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
  final TaskRepository task;
  final InjuryRepository injury;
  final ChecklistRepository checklist;

  AppRepository(AppDao dao)
      : user = UserRepository(dao.user),
        template = TemplateRepository(dao.template),
        company = CompanyRepository(dao.company),
        quote = QuoteRepository(dao.quote),
        fleet = FleetEventRepository(dao.fleetevent),
        complaint = ComplaintRepository(dao.complaint),
        customer = CustomerRepository(dao.customer),
        task = TaskRepository(dao.task),
        injury = InjuryRepository(dao.injury),
        checklist = ChecklistRepository(dao.checklist);
}