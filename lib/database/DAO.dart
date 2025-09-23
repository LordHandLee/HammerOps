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

  AppDao(AppDatabase db)
      : user = UserDao(db),
        template = TemplatesDao(db),
        company = CompanyDao(db),
        quote = JobQuotesDao(db);
}