import 'package:hammer_ops/database/repository.dart';

class QuoteService {
  final QuoteRepository quoteRepository;

  QuoteService(this.quoteRepository);

  Future<int> calculateQuotePrice(List<String> fieldValues) async {
    // Dummy logic: each field value adds $100
    return fieldValues.length * 100;
  }

  Future<String> createQuoteFromTemplate(int userId, int templateId, List<String> fieldValues) async {
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
      totalAmount: 0.0,
      createdBy: userId,
    );

    try {
      await quoteRepository.createQuoteFromTemplate(quote: quote, fieldValues: fieldValues);
      return "Quote created successfully from template";
    } catch (e) {
      return "Error creating quote: $e";
    }
  }

  /// Business logic: add quote with validation and extra rules
  Future<String> createQuote(int userId, String description, double price) async {
    if (price < 0) {
      return "Error: Price cannot be negative";
    }

    // Rule: mark high-value quotes
    String desc = description;
    if (price > 10000) {
      desc = "[HIGH VALUE] $description";
    }

    // Rule: if user has too many quotes, flag it
    final existingQuotes = await quoteRepository.getQuotesForUser(userId);
    if (existingQuotes.length >= 5) {
      desc = "[REVIEW REQUIRED] $desc";
    }

    await quoteRepository.addQuote(userId, desc, price);
    return "Quote created successfully";
  }

  /// Business logic: calculate total value of user’s quotes
  Future<double> calculateTotalForUser(int userId) async {
    final quotes = await quoteRepository.getQuotesForUser(userId);
    return quotes.fold(0.0, (sum, q) => sum + q.price);
  }

  /// Business logic: find “VIP” users with total quotes > $50,000
  Stream<List<User>> watchVipUsers() {
    return quoteRepository.watchUsersWithQuotes().map((userList) {
      return userList
          .where((uwq) =>
              uwq.quotes.fold(0.0, (sum, q) => sum + q.price) > 50000)
          .map((uwq) => uwq.user)
          .toList();
    });
  }
}