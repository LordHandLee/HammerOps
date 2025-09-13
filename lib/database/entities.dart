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
// QUOTES (TABLE)
// ------------------
class JobQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
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


