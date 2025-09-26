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

class AppRepository {
  final UserRepository user;
  final TemplateRepository template;
  final QuoteRepository quote;
  final CompanyRepository company;

  AppRepository(AppDao dao)
      : user = UserRepository(dao.user),
        template = TemplateRepository(dao.template),
        company = CompanyRepository(dao.company),
        quote = QuoteRepository(dao.quote);
}