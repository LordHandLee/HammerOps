import 'database.dart';
import 'package:drift/drift.dart';

class UserRepository {
  final UserDao userDao;

  UserRepository(this.userDao);

  Stream<List<User>> watchUsers() => userDao.watchAllUsers();
  Future<List<User>> getUsers() => userDao.getAllUsers();

  Future<int> addUser(String name, int? age) {
    final user = UsersCompanion.insert(name: name, age: Value(age));
    return userDao.insertUser(user);
  }

  Future<bool> editUser(User user) => userDao.updateUser(user);
  Future<int> removeUser(User user) => userDao.deleteUser(user);
}

class QuoteRepository {
  final JobQuotesDao jobQuotesDao;
  final UserDao userDao;
  // final TemplatesDao templatesDao;

  QuoteRepository(this.jobQuotesDao, this.userDao);

  Future<int> createQuoteFromTemplate({quote=JobQuotesCompanion.insert(templateId: template), fieldValues=List<String>}) => jobQuotesDao.createQuoteWithFields(quote, fieldValues);


  Future<int> addQuote(int userId, String description, double price) {
    final quote = JobQuotesCompanion.insert(
      templateId: 1, // Assuming a default template for simplicity
      customerName: description,
      customerContact: 'N/A',
      totalAmount: price,
      createdBy: userId,
    );
    return jobQuotesDao.insertJobQuote(quote);
  }

  Future<List<JobQuote>> getQuotesForUser(int userId) {
    return (jobQuotesDao.select(jobQuotesDao.jobQuotes)
          ..where((q) => q.createdBy.equals(userId)))
        .get();
  }

  Stream<List<UserWithQuotes>> watchUsersWithQuotes() {
    final query = select(userDao.users).join([
      leftOuterJoin(jobQuotesDao.jobQuotes, jobQuotesDao.jobQuotes.createdBy.equalsExp(userDao.users.id))
    ]);

    return query.watch().map((rows) {
      final userMap = <int, UserWithQuotes>{};

      for (var row in rows) {
        final user = row.readTable(userDao.users);
        final quote = row.readTableOrNull(jobQuotesDao.jobQuotes);

        userMap.putIfAbsent(user.id, () => UserWithQuotes(user: user, quotes: []));
        if (quote != null) {
          userMap[user.id]!.quotes.add(quote);
        }
      }

      return userMap.values.toList();
    });
  }
}