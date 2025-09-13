import 'package:drift/drift.dart';

// ------------------
// ENTITY (TABLE)
// ------------------
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get age => integer().nullable()();
}

// ------------------
// TEMPLATES (TABLE)
// ------------------
class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get createdBy => integer().customConstraint('REFERENCES users(id)')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// ------------------
// TEMPLATE FIELDS (TABLE)
// ------------------
class TemplateFields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().customConstraint('REFERENCES templates(id) ON DELETE CASCADE')();
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
  IntColumn get templateId => integer().customConstraint('REFERENCES templates(id)')(); // each quote belongs to template and user
  TextColumn get customerName => text().withLength(min: 1, max: 100)();
  TextColumn get customerContact => text().withLength(min: 1, max: 100)();
  DateTimeColumn get quoteDate => dateTime().withDefault(currentDateAndTime)();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();

  // Foreign key to Users table (assuming a user creates the quote)
  IntColumn get createdBy => integer().customConstraint('REFERENCES users(id)')();
}

// ------------------
// TOOLS (TABLE)
// ------------------
class Tools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  
  // Is available for use or currently in use by someone
  BoolColumn get isAvailable => boolean().withDefault(const Constant(true))();

  // Foreign key to Users table (assuming a user manages the tool)
  IntColumn get managedBy => integer().customConstraint('REFERENCES users(id)')();
}

// ------------------
// TASKS (TABLE)
// ------------------
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  // Is flagged for review or important
  BoolColumn get isFlagged => boolean().withDefault(const Constant(false))();

  // Foreign key to Users table (assuming a user is assigned the task)
  IntColumn get assignedTo => integer().customConstraint('REFERENCES users(id)')();
}


