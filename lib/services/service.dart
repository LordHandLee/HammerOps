import 'package:hammer_ops/database/repository.dart';
import 'package:hammer_ops/database/database.dart';


class TemplateService {
  final TemplateRepository templateRepository;

  TemplateService(this.templateRepository);

  Future<int> createTemplate(String name, int createdBy, List<Map<String, dynamic>> fields) async {
    // enforce rules
    // final fieldNames = fields.map((f) => f.name.value.toLowerCase()).toSet();
    final fieldNames = fields.map((f) => (f['fieldName'] as String).toLowerCase()).toSet();

    final hasHours = fieldNames.contains("hours worked") && fieldNames.contains("hourly rate");
    final hasSqft  = fieldNames.contains("square footage") && fieldNames.contains("price per square foot");

    if (!hasHours && !hasSqft) {
      throw Exception("Template must include (hours worked + hourly rate) or (square footage + price per square foot)");
    }

    final templateId = await templateRepository.addTemplate(name, createdBy);
    for (var field in fields) {
      await templateRepository.addTemplateField(
        templateId,
        field['fieldName'],
        field['fieldType'],
        isRequired: field['isRequired'] ?? false,
        sortOrder: field['sortOrder'] ?? 0,
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

  Future<String> createQuoteFromTemplate(int userId, int templateId, amount, List<String> fieldValues) async {
    // Basic validation
    if (fieldValues.isEmpty) {
      return "Error: Field values cannot be empty";
    }

    // Calculate total amount based on field values (dummy logic here)
    // Create quote companion
    final quote = JobQuotesCompanion.insert(
      templateId: templateId,
      customerName: 'N/A',
      customerContact: 'N/A',
      totalAmount: amount,
      createdBy: userId,
    );

    try {
      await quoteRepository.createQuoteFromTemplate(quote, fieldValues);
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

class AppService {
  final TemplateService template;
  final QuoteService quote;

  AppService(AppRepository repo)
      : template = TemplateService(repo.template),
        quote = QuoteService(repo.quote, repo.template);
}