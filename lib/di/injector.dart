// lib/di/injector.dart
import 'package:get_it/get_it.dart';
import 'package:hammer_ops/database/database.dart';
// import 'package:hammer_ops/database/DAO.dart';
import 'package:hammer_ops/database/repository.dart';
import 'package:hammer_ops/services/service.dart';
import 'package:hammer_ops/database/database_connection.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final executor = await openConnection();


  final db = AppDatabase(executor);
  final dao = AppDao(db);
  final repo = AppRepository(dao);
  final service = AppService(repo);
  getIt.registerSingleton<AppService>(service);


  // final userDao = UserDao(db);
  // final templatesDao = TemplatesDao(db);
  // final jobQuotesDao = JobQuotesDao(db);
  // final userRepository = UserRepository(userDao);
  // final templateRepository = TemplateRepository(templatesDao);
  // final quoteRepository = QuoteRepository(jobQuotesDao, userDao);

  // getIt.registerSingleton<AppDatabase>(db);
  // getIt.registerSingleton<UserDao>(userDao);
  // getIt.registerSingleton<TemplatesDao>(templatesDao);
  // getIt.registerSingleton<UserRepository>(userRepository);
  // getIt.registerSingleton<TemplateRepository>(templateRepository);
  // getIt.registerSingleton<QuoteRepository>(quoteRepository);

  // final templateService = TemplateService(templateRepository);
  // final quoteService = QuoteService(quoteRepository, templateRepository);

  // getIt.registerSingleton<TemplateService>(templateService);
  // getIt.registerSingleton<QuoteService>(quoteService);

  // // // Register services
  // // // Assuming repositories are already registered
  // // final templateService = TemplateService(getIt<TemplateRepository>());
  // // final quoteService = QuoteService(getIt<QuoteRepository>(), getIt<TemplateRepository>());

  // // getIt.registerSingleton<TemplateService>(templateService);
  // // getIt.registerSingleton<QuoteService>(quoteService);

  // // Register AppService
  // final appService = AppService(
  //   templateService: templateService,
  //   quoteService: quoteService,
  // );

  // getIt.registerSingleton<AppService>(appService);
}

