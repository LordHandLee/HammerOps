// part of 'database.dart';
// import 'database.dart';
// import 'entities.dart';
// import 'package:drift/drift.dart';
part of 'database.dart';
// part 'database.g.dart';
// import 'database.g.dart';

// ------------------
// DAO
// ------------------

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  // final AppDatabase db;
  UserDao(super.db);

  Future<List<User>> getAllUsers() => select(users).get();
  Stream<List<User>> watchAllUsers() => select(users).watch();
  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);
  Future<bool> updateUser(User user) => update(users).replace(user);
  Future<int> deleteUser(User user) => delete(users).delete(user);
}

@DriftAccessor(tables: [Templates, TemplateFields])
class TemplatesDao extends DatabaseAccessor<AppDatabase> with _$TemplatesDaoMixin {
  // final AppDatabase db;
  // TemplatesDao(AppDatabase db) : super(db);
  TemplatesDao(super.db);

  // Insert template
  Future<int> insertTemplate(TemplatesCompanion template) => into(templates).insert(template);

  // Insert template field
  Future<int> insertTemplateField(TemplateFieldsCompanion field) => into(templateFields).insert(field);

  // Get all templates
  Future<List<Template>> getAllTemplates() => select(templates).get();

  //Get a template with fields "Hours worked" ... "hourly rate"
  Future<TemplateWithFields?> getTemplateWithFields(int templateId) async {
    final template = await (select(templates)..where((t) => t.id.equals(templateId))).getSingleOrNull();
    if (template == null) return null;

    final fields = await (select(templateFields)..where((f) => f.templateId.equals(templateId))).get();
    return TemplateWithFields(template: template, fields: fields);
  }

}

@DriftAccessor(tables: [JobQuotes, QuoteFieldValues, Templates, TemplateFields])
class JobQuotesDao extends DatabaseAccessor<AppDatabase> with _$JobQuotesDaoMixin {
  // JobQuotesDao(AppDatabase db) : super(db);
  JobQuotesDao(super.db);

  // Insert job quote
  Future<int> insertJobQuote(JobQuotesCompanion quote) => into(jobQuotes).insert(quote);

  // Insert a quote field value
  Future<int> insertQuoteFieldValue(QuoteFieldValuesCompanion value) => into(quoteFieldValues).insert(value);

  // Create a quote with its field values in a transaction
  Future<int> createQuoteWithFields(JobQuotesCompanion quote, List<QuoteFieldValuesCompanion> fieldValues) {
    return transaction(() async {
      final quoteId = await insertJobQuote(quote);
      for (var value in fieldValues) {
        final valueWithQuoteId = value.copyWith(quoteId: Value(quoteId));
        await insertQuoteFieldValue(valueWithQuoteId);
      }
      return quoteId;
    });
  }

  // Get a quote with its template and field values
  Future<QuoteWithValues?> getQuoteDetails(int quoteId) async {
    final quote = await (select(jobQuotes)..where((q) => q.id.equals(quoteId))).getSingleOrNull();
    if (quote == null) return null;

    final template = await (select(templates)..where((t) => t.id.equals(quote.templateId))).getSingleOrNull();
    if (template == null) return null;

    final fieldValues = await (select(quoteFieldValues)..where((v) => v.quoteId.equals(quoteId))).get();

    // Fetch field definitions for better context
    final fieldIds = fieldValues.map((v) => v.fieldId).toList();
    final fields = await (select(templateFields)..where((f) => f.id.isIn(fieldIds))).get();

    final fieldValuePairs = fieldValues.map((v) {
      final field = fields.firstWhere((f) => f.id == v.fieldId, orElse: () {
        throw Exception('TemplateField not found for fieldId: ${v.fieldId}');
      });
      return FieldValuePair(field: field, value: v.fieldValue ?? '');
    }).toList();

    return QuoteWithValues(quote: quote, template: template, fields: fieldValuePairs);
  }

  //   return {
  //     'quote': quote,
  //     'template': template,
  //     'fieldValues': fieldValues,
  //     'fields': fields,
  //   };
  // }

  // Get all job quotes
  Future<List<JobQuote>> getAllJobQuotes() => select(jobQuotes).get();

  // Get job quotes for a specific user
  Future<List<JobQuote>> getJobQuotesForUser(int userId) {
    return (select(jobQuotes)..where((q) => q.createdBy.equals(userId))).get();
  }

}

@DriftAccessor(tables: [Company])
class CompanyDao extends DatabaseAccessor<AppDatabase> with _$CompanyDaoMixin {
  CompanyDao(super.db);

  Future<int> insertCompany(CompanyCompanion companyCompanion) => into(company).insert(companyCompanion);

  Future<List<CompanyData>> getAllCompanies() => select(company).get();
}

@DriftAccessor(tables: [Jobs])
class JobsDao extends DatabaseAccessor<AppDatabase> with _$JobsDaoMixin {
  JobsDao(super.db);

  Future<int> insertJob(JobsCompanion job) => into(jobs).insert(job);

  Future<List<Job>> getAllJobs() => select(jobs).get();

  /// Get a job by its ID
  Future<Job?> getJobById(int id) {
    return (select(jobs)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Update an existing job
  Future<int> updateJob({
    required int id,
    required int quoteId,
    required String name,
    String? jobStatus,
    required int customerId,
    required int assignedTo,
    }) {
      return (update(jobs)..where((tbl) => tbl.id.equals(id)))
          .write(
        JobsCompanion(
          quoteId: Value(quoteId),
          name: Value(name),
          jobStatus: Value(jobStatus),
          customer: Value(customerId),
          assignedTo: Value(assignedTo),
        ),
      );
    }
}

@DriftAccessor(tables: [Customers])
class CustomersDao extends DatabaseAccessor<AppDatabase> with _$CustomersDaoMixin {
  CustomersDao(super.db);

  Future<int> insertCustomer(CustomersCompanion customer) => into(customers).insert(customer);

  Future<List<Customer>> getAllCustomers() => select(customers).get();
}

// @DriftAccessor(tables: [Tools])
// class ToolsDao extends DatabaseAccessor<AppDatabase> with _$ToolsDaoMixin {
//   ToolsDao(super.db);

//   Future<int> insertTool(ToolsCompanion tool) => into(tools).insert(tool);

//   Future<List<Tool>> getAllTools() => select(tools).get();
// }

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(super.db);

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<List<Task>> getAllTasks() => select(tasks).get();

    // --- New Methods for Flag Feature ---
  Future<int> flagTask(int taskId, String reason) {
    return (update(tasks)
          ..where((t) => t.id.equals(taskId)))
        .write(
      TasksCompanion(
        isFlagged: const Value(true),
        reasonForFlag: Value(reason),
      ),
    );
  }

  Future<int> unflagTask(int taskId) {
    return (update(tasks)
          ..where((t) => t.id.equals(taskId)))
        .write(
      const TasksCompanion(
        isFlagged: Value(false),
        reasonForFlag: Value(null),
      ),
    );
  }

  Future<List<Task>> getFlaggedTasks() {
    return (select(tasks)..where((t) => t.isFlagged.equals(true))).get();
  }

  Stream<List<Task>> watchAllTasks() {
  return (select(tasks)
        ..orderBy([(t) => OrderingTerm.asc(t.dueDate)]))
      .watch();
}

}

@DriftAccessor(tables: [Complaint])
class ComplaintDao extends DatabaseAccessor<AppDatabase> with _$ComplaintDaoMixin {
  ComplaintDao(super.db);

  Future<int> insertComplaint(ComplaintCompanion complaints) => into(complaint).insert(complaints);

  Future<List<ComplaintData>> getAllComplaints() => select(complaint).get();
}

@DriftAccessor(tables: [Injury])
class InjuryDao extends DatabaseAccessor<AppDatabase> with _$InjuryDaoMixin {
  InjuryDao(super.db);

  Future<int> insertInjury(InjuryCompanion injurys) => into(injury).insert(injurys);

  Future<List<InjuryData>> getAllInjuries() => select(injury).get();
}

// @DriftAccessor(tables: [Document])
// class DocumentDao extends DatabaseAccessor<AppDatabase> with _$DocumentDaoMixin {
//   DocumentDao(super.db);

//   Future<int> insertDocument(DocumentCompanion document) => into(document).insert(document);

//   Future<List<DocumentData>> getAllDocuments() => select(document).get();
// }

// jobs, customers, tools, tasks, complaint, injury, document

@DriftAccessor(tables: [FleetEvents])
class FleetEventDao extends DatabaseAccessor<AppDatabase> with _$FleetEventDaoMixin {
  FleetEventDao(AppDatabase db) : super(db);

  Future<List<FleetEvent>> getAllEvents() =>
    select(fleetEvents).get();

  Future<List<FleetEvent>> getFutureEvents() {
    final now = DateTime.now();
    return (select(fleetEvents)
          ..where((tbl) => tbl.date.isBiggerThanValue(now))
          ..orderBy([(t) => OrderingTerm(expression: t.date)]))
        .get();
  }

  Future<void> insertEvent(FleetEventsCompanion event) =>
      into(fleetEvents).insert(event);

  Future<void> updateEvent(FleetEventsCompanion event) =>
      update(fleetEvents).replace(event);

  Future<void> deleteEvent(int id) =>
      (delete(fleetEvents)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(
  tables: [ChecklistTemplates, ChecklistItems, ChecklistRuns, ChecklistRunItems]
)
class ChecklistDao extends DatabaseAccessor<AppDatabase>
    with _$ChecklistDaoMixin {
  ChecklistDao(super.db);

  // Load templates with items
  Future<ChecklistTemplateWithItems> getTemplateWithItems(String code) async {
    final template = await (select(checklistTemplates)
          ..where((t) => t.code.equals(code)))
        .getSingle();

    final items = await (select(checklistItems)
          ..where((i) => i.templateId.equals(template.id)))
        .get();

    return ChecklistTemplateWithItems(template, items);
  }

  Future<ChecklistTemplateWithItems> getTemplateWithItemsById(int templateId) async {
    final template = await (select(checklistTemplates)
          ..where((t) => t.id.equals(templateId)))
        .getSingle();

    final items = await (select(checklistItems)
          ..where((i) => i.templateId.equals(template.id)))
        .get();

    return ChecklistTemplateWithItems(template, items);

  
  }

  Future<List<ChecklistItem>> getItemsForTemplateId(int templateId) {
    return (select(checklistItems)..where((t) => t.templateId.equals(templateId))).get();
  }


  Future<ChecklistTemplate> getTemplateRawById(int templateId) {
    return (select(checklistTemplates)..where((t) => t.id.equals(templateId))).getSingle();
  }

  // Save a completed checklist
  Future<int> insertChecklistRun(
      int templateId, int userId, List<ChecklistItemRunInput> items) async {

    return transaction(() async {
      final runId = await into(checklistRuns).insert(
        ChecklistRunsCompanion.insert(
          templateId: templateId,
          completedBy: Value(userId),
        ),
      );

      for (final item in items) {
        await into(checklistRunItems).insert(
          ChecklistRunItemsCompanion.insert(
            runId: runId,
            itemId: item.itemId,
            checked: item.checked,
            notes: Value(item.notes),
          ),
        );
      }

      return runId;
    });
  }

  Future<void> deleteTemplate(int id) => 
    (delete(checklistTemplates)..where((t) => t.id.equals(id))).go();

  Future<List<ChecklistTemplate>> getAllTemplates() =>
    select(checklistTemplates).get();

  Future<int> insertTemplate(ChecklistTemplatesCompanion checklistTemplate) => into(checklistTemplates).insert(checklistTemplate);

  Future<void> updateTemplateItems(
    int templateId,
    List<ChecklistItem> newItems,
  ) async {
    return transaction(() async {
      // Load existing DB items
      final existingItems = await (select(checklistItems)
            ..where((i) => i.templateId.equals(templateId)))
          .get();

      // Map by id for easy lookup
      final existingById = {for (var i in existingItems) i.id: i};
      final newById = {for (var i in newItems) i.id: i};

      // 1. Delete items that no longer exist in the UI
      for (final old in existingItems) {
        if (!newById.containsKey(old.id)) {
          await (delete(checklistItems)
                ..where((tbl) => tbl.id.equals(old.id)))
              .go();
        }
      }

      // 2. Insert or update items
      for (final item in newItems) {
        if (item.id == 0 || !existingById.containsKey(item.id)) {
          // New item → insert
          await into(checklistItems).insert(
            ChecklistItemsCompanion.insert(
              templateId: item.templateId,
              title: item.title,
              required: Value(item.required),
            ),
          );
        } else {
          // Existing item → update
          await update(checklistItems).replace(item);
        }
      }
    });
}

}

class ChecklistTemplateWithItems {
  final ChecklistTemplate template;
  final List<ChecklistItem> items;

  ChecklistTemplateWithItems(this.template, this.items);
}

class ChecklistItemRunInput {
  final int itemId;
  final bool checked;
  final String? notes;

  ChecklistItemRunInput({
    required this.itemId,
    required this.checked,
    this.notes,
  });
}

class TemplateWithFields {
  final Template template;
  final List<TemplateField> fields;

  TemplateWithFields({required this.template, required this.fields});
}

class QuoteWithValues {
  final JobQuote quote;
  final Template template;
  final List<FieldValuePair> fields;

  QuoteWithValues({required this.quote, required this.template, required this.fields});

}

class FieldValuePair {
  final TemplateField field;
  final String value;

  FieldValuePair({required this.field, required this.value});
}


class AppDao {
  final UserDao user;
  final TemplatesDao template;
  final JobQuotesDao quote;
  final CompanyDao company;
  final FleetEventDao fleetevent;
  final ComplaintDao complaint;
  final CustomersDao customer;
  final TasksDao task;
  final InjuryDao injury;
  final ChecklistDao checklist;
  final JobsDao jobs;

  AppDao(AppDatabase db)
      : user = UserDao(db),
        template = TemplatesDao(db),
        company = CompanyDao(db),
        quote = JobQuotesDao(db),
        fleetevent = FleetEventDao(db),
        complaint = ComplaintDao(db),
        customer = CustomersDao(db),
        task = TasksDao(db),
        injury = InjuryDao(db),
        checklist = ChecklistDao(db),
        jobs = JobsDao(db);
}