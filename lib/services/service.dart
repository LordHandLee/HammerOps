import 'package:hammer_ops/database/repository.dart';
import 'package:hammer_ops/database/database.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';


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

  Future<int> addUser(String name, int companyId) {
    final user = UsersCompanion.insert(name: name, companyId: companyId);
    return userRepository.addUser(user);
  }
  // Future<User?> getUserById(int id) {
  //   return userRepository.getUserById(id);
  // }

  // Future<List<User>> getAllUsers() {
  //   return userRepository.getAllUsers();
  // }
}

class CompanyService {
  final CompanyRepository companyRepository;

  CompanyService(this.companyRepository);

  Future<int> addCompany(String name) {
    // CompanyCompanion.insert(name: name);
    return companyRepository.addCompany(name);
  }

  // Future<Company?> getCompanyById(int id) {
  //   return companyRepository.getCompanyById(id);
  // }

  Future<List<CompanyData>> getAllCompanies() {
    return companyRepository.getAllCompanies();
  }
}

// class JobService {
//   final JobRepository jobRepository;

//   JobService(this.jobRepository);

//   Future<int> addJob(String title, String description, int assignedTo) {
//     return jobRepository.addJob(title, description, assignedTo);
//   }

//   Future<List<JobData>> getAllJobs() {
//     return jobRepository.getAllJobs();
//   }
// }

// class CustomerService {
//   final CustomerRepository customerRepository;

//   CustomerService(this.customerRepository);

//   Future<int> addCustomer(String name, String contactInfo) {
//     return customerRepository.addCustomer(name, contactInfo);
//   }

//   Future<List<Customer>> getAllCustomers() {
//     return customerRepository.getAllCustomers();
//   }
// }

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

// class TaskService {
//   final TaskRepository taskRepository;

//   TaskService(this.taskRepository);

//   Future<int> addTask(String title, String description, DateTime? dueDate) {
//     final task = TasksCompanion.insert(
//       title: title,
//       description: Value(description),
//       dueDate: Value(dueDate),
//     );
//     return taskRepository.addTask(task);
//   }

//   Future<List<Task>> getAllTasks() {
//     return taskRepository.getAllTasks();
//   }
// }

// class ComplaintService {
//   final ComplaintRepository complaintRepository;

//   ComplaintService(this.complaintRepository);

//   Future<int> addComplaint(String title, String description, int reportedBy) {
//     final complaint = ComplaintCompanion.insert(
//       title: title,
//       description: Value(description),
//       reportedBy: reportedBy,
//     );
//     return complaintRepository.addComplaint(complaint);
//   }

//   Future<List<ComplaintData>> getAllComplaints() {
//     return complaintRepository.getAllComplaints();
//   }
// }

// class InjuryService {
//   final InjuryRepository injuryRepository;

//   InjuryService(this.injuryRepository);

//   Future<int> addInjury(String description, DateTime dateOccurred, int reportedBy) {
//     final injury = InjuryCompanion.insert(
//       description: description,
//       dateOccurred: dateOccurred,
//       reportedBy: reportedBy,
//     );
//     return injuryRepository.addInjury(injury);
//   }

//   Future<List<InjuryData>> getAllInjuries() {
//     return injuryRepository.getAllInjuries();
//   }
// }

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


// task, complaint, injury, document, 


class AppService {
  final TemplateService template;
  final QuoteService quote;
  final UserService user;
  final CompanyService company;

  AppService(AppRepository repo)
      : template = TemplateService(repo.template),
        user = UserService(repo.user),
        company = CompanyService(repo.company),
        quote = QuoteService(repo.quote, repo.template);
}