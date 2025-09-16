import 'package:drift/drift.dart';

// ------------------
// ENTITY (TABLE)
// ------------------
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get age => integer().nullable()();
  TextColumn get role => text().withLength(min: 1, max: 20).withDefault(const Constant('user'))(); // e.g., user, admin
  TextColumn get employer => text().nullable()(); // e.g., company name

  // Admin-specific fields (nullable for regular users)
  TextColumn get permissions => text().nullable()(); // e.g., JSON string of permissions
  BoolColumn get canManageUsers => boolean().withDefault(const Constant(false))();

  // Foreign key to Company table (nullable for users without a company)
  IntColumn get companyId => integer().references(Company, #id, onDelete: KeyAction.cascade)();
}

// ------------------
// TEMPLATES (TABLE)
// ------------------
class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get createdBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ------------------
// TEMPLATE FIELDS (TABLE)
// ------------------
class TemplateFields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(Templates, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldName => text().withLength(min: 1, max: 100)();
  TextColumn get fieldType => text().withLength(min: 1, max: 50)(); // e.g., text, number, date
  BoolColumn get isRequired => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // For ordering fields within a template
}

// ------------------
// QUOTES (TABLE)
// ------------------
class JobQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(Templates, #id, onDelete: KeyAction.cascade)(); // each quote belongs to template and user
  TextColumn get customerName => text().withLength(min: 1, max: 100)();
  TextColumn get customerContact => text().withLength(min: 1, max: 100)();
  DateTimeColumn get quoteDate => dateTime().withDefault(currentDateAndTime)();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();

  // Foreign key to Users table (assuming a user creates the quote)
  IntColumn get createdBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
}

// ------------------
// QUOTEFIELDVALUES (TABLE)
// ------------------
class QuoteFieldValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quoteId => integer().references(JobQuotes, #id, onDelete: KeyAction.cascade)();
  IntColumn get fieldId => integer().references(TemplateFields, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldValue => text().nullable()(); // store as text, cast as needed
}


// ------------------
// JOBS (TABLE)
// ------------------
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quoteId => integer().references(JobQuotes, #id, onDelete: KeyAction.cascade)(); // each job is linked to a quote
  TextColumn get jobStatus => text().withLength(min: 1, max: 50)(); // e.g., pending, in-progress, completed
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();

  // Foreign key to Users table (assuming a user is assigned the job)
  IntColumn get assignedTo => integer().references(Users, #id, onDelete: KeyAction.cascade)();
}

// ------------------
// CUSTOMERS (TABLE)
// ------------------
class Customers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get contactInfo => text().withLength(min: 1, max: 200)();
  TextColumn get address => text().nullable()();
  
  // Foreign key to Users table (assuming a user manages the customer)
  IntColumn get managedBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
}

// ------------------
// COMPANY (TABLE)
// ------------------
class Company extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get address => text().nullable()();
}

// // ------------------
// // TOOLS (TABLE)
// // ------------------
// class Tools extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get name => text().withLength(min: 1, max: 100)();
//   TextColumn get description => text().nullable()();
  
//   // Is available for use or currently in use by someone
//   BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();

//   // Foreign key to Users table (assuming a user manages the tool)
//   IntColumn get managedBy => integer().customConstraint('REFERENCES users(id)')();
// }

// // ------------------
// // TASKS (TABLE)
// // ------------------
// class Tasks extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get title => text().withLength(min: 1, max: 100)();
//   TextColumn get description => text().nullable()();
//   DateTimeColumn get dueDate => dateTime().nullable()();
//   BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

//   // Is flagged for review or important
//   BoolColumn get isFlagged => boolean().withDefault(const Constant(false))();

//   // Foreign key to Users table (assuming a user is assigned the task)
//   IntColumn get assignedTo => integer().customConstraint('REFERENCES users(id)')();
// }


