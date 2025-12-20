import 'package:drift/drift.dart';

// ------------------
// ACCOUNTS & AUTH
// ------------------
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()(); // unique
  TextColumn get passwordHash => text()(); // hashed (bcrypt/PBKDF2)
  TextColumn get passwordSalt => text().nullable()(); // optional depending on hash
  BoolColumn get isEmailVerified =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get lastSeen => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {email},
      ];
}

class AccountSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get refreshTokenHash => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get revokedAt => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// ENTITY (TABLE)
// ------------------
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get age => integer().nullable()();
  TextColumn get role => text().withLength(min: 1, max: 20).withDefault(const Constant('user'))(); // e.g., user, admin
  TextColumn get employer => text().nullable()(); // e.g., company name

  // Admin-specific fields (nullable for regular users)
  TextColumn get permissions => text().nullable()(); // e.g., JSON string of permissions
  BoolColumn get canManageUsers =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();

  // Foreign key to Company table (nullable for users without a company)
  IntColumn get companyId => integer().references(Company, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// TEMPLATES (TABLE)
// ------------------
class Templates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get createdBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// TEMPLATE FIELDS (TABLE)
// ------------------
class TemplateFields extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(Templates, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldName => text().withLength(min: 1, max: 100)();
  // TextColumn get fieldType => text().withLength(min: 1, max: 50)(); // e.g., text, number, date
  BoolColumn get isRequired =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))(); // For ordering fields within a template
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// QUOTES (TABLE)
// ------------------
class JobQuotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(Templates, #id, onDelete: KeyAction.cascade)(); // each quote belongs to template and user
  // TextColumn get quoteName => text().withLength(min: 1, max: 100)();
  TextColumn get customerName => text().withLength(min: 1, max: 100)();
  TextColumn get customerContact => text().withLength(min: 1, max: 100)();
  // add quote name/description 
  DateTimeColumn get quoteDate => dateTime().clientDefault(() => DateTime.now())();
  RealColumn get totalAmount => real().withDefault(const Constant(0.0))();

  // Foreign key to Users table (assuming a user creates the quote)
  IntColumn get createdBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// QUOTEFIELDVALUES (TABLE)
// ------------------
class QuoteFieldValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quoteId => integer().references(JobQuotes, #id, onDelete: KeyAction.cascade)();
  IntColumn get fieldId => integer().references(TemplateFields, #id, onDelete: KeyAction.cascade)();
  TextColumn get fieldValue => text().nullable()(); // store as text, cast as needed
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}


// ------------------
// JOBS (TABLE)
// ------------------
class Jobs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get quoteId => integer().references(JobQuotes, #id, onDelete: KeyAction.cascade)(); // each job is linked to a quote
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get jobStatus => text().nullable().withLength(min: 1, max: 50)(); // e.g., pending, in-progress, completed
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();

  // Foreign key to Users table (assuming a user is assigned the job)
  IntColumn get assignedTo => integer().nullable().references(Users, #id, onDelete: KeyAction.cascade)();

  // Foreign key to Customers table (assuming a job is for a specific customer)
  IntColumn get customer => integer().references(Customers, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// COMPANY (TABLE)
// ------------------
class Company extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get address => text().nullable()();
  IntColumn get adminAccountId => integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

class CompanyMembers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get companyId => integer().references(Company, #id, onDelete: KeyAction.cascade)();
  IntColumn get accountId => integer().references(Accounts, #id, onDelete: KeyAction.cascade)();
  TextColumn get role => text().withLength(min: 1, max: 20)(); // admin|employee
  IntColumn get invitedBy => integer().nullable().references(Accounts, #id)();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  @override
  List<Set<Column>> get uniqueKeys => [
        {companyId, accountId},
      ];
}

// ------------------
// TOOLS (TABLE)
// ------------------
class Tools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  
  // Is available for use or currently in use by someone
  BoolColumn get isAvailable =>
      boolean().customConstraint('NOT NULL DEFAULT TRUE')();

  // Foreign key to Users table (assuming a user manages the tool)
  IntColumn get managedBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();


}

// ------------------
// TASKS (TABLE)
// ------------------
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isCompleted =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();

  // Is flagged for review or important
  BoolColumn get isFlagged =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();

  TextColumn get reasonForFlag => text().nullable()();

  // Foreign key to Users table (assuming a user is assigned the task)
  IntColumn get assignedTo => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}



// ------------------
// COMPLAINTS (TABLE)
// ------------------
class Complaint extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get reportedAt => dateTime().clientDefault(() => DateTime.now())();
  BoolColumn get isResolved =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();

  // Foreign key to Users table (assuming a user reports the complaint)
  @ReferenceName('userComplaints')
  IntColumn get reportedByUser => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  
  // Foreign key to Users table (assuming a user is assigned to resolve the complaint)
  IntColumn get assignedTo => integer().references(Users, #id, onDelete: KeyAction.cascade)();

  // Foreign key to Customers table (if complaint is from a customer)
  IntColumn get reportedByCustomer => integer().references(Customers, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

}

// ------------------
// INJURIES (TABLE)
// ------------------
class Injury extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().clientDefault(() => DateTime.now())();
  BoolColumn get isResolved =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();

  // Foreign key to Users table (assuming a user reports the injury)
  @ReferenceName('userInjuries')
  IntColumn get reportedByUser => integer().nullable().references(Users, #id, onDelete: KeyAction.cascade)();
  
  // Foreign key to Users table (assuming a user is assigned to resolve the injury)
  IntColumn get assignedTo => integer().nullable().references(Users, #id, onDelete: KeyAction.cascade)();

  // Foreign key to Customers table (if injury is from a customer)
  IntColumn get reportedByCustomer => integer().nullable().references(Customers, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// DOCUMENTS (TABLE)
// ------------------
class Document extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get filePath => text()(); // path to the document file
  DateTimeColumn get uploadedAt => dateTime().clientDefault(() => DateTime.now())();

  // Foreign key to Users table (assuming a user uploads the document)
  IntColumn get uploadedBy => integer().references(Users, #id, onDelete: KeyAction.cascade)();

  // Foreign key to Customers table (if document is related to a customer)
  IntColumn get customerId => integer().references(Customers, #id, onDelete: KeyAction.cascade)();

  // Foreign key to Jobs table (if document is related to a job)
  IntColumn get jobId => integer().references(Jobs, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();


}

// ------------------
// FleetEvents (TABLE)
// ------------------

class FleetEvents extends Table {
  IntColumn get id => integer().autoIncrement()(); // UUID or random string
  TextColumn get vehicleName => text()();
  TextColumn get eventType => text()(); // maintenance, repair, inspection
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  // @override
  // Set<Column> get primaryKey => {id};
}


// ------------------
// ChecklistTemplates (TABLE)
// ------------------
class ChecklistTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text()();       // e.g. "BOD"
  TextColumn get name => text()();       // e.g. "Beginning of Day"
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// ChecklistItems (TABLE)
// ------------------
class ChecklistItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(ChecklistTemplates, #id)();
  TextColumn get title => text()();
  BoolColumn get required =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// ChecklistRuns (TABLE)
// ------------------
class ChecklistRuns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get templateId => integer().references(ChecklistTemplates, #id)();
  DateTimeColumn get timestamp => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get completedBy => integer().nullable()();  // user ID optional
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// ChecklistRunItems (TABLE)
// ------------------
class ChecklistRunItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get runId => integer().references(ChecklistRuns, #id)();
  IntColumn get itemId => integer().references(ChecklistItems, #id)();
  BoolColumn get checked =>
      boolean().customConstraint('NOT NULL DEFAULT FALSE')();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
  IntColumn get version => integer().withDefault(const Constant(0))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// ------------------
// Local change queue (for sync)
// ------------------
class LocalChanges extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get targetTable => text()();
  TextColumn get changeType => text()(); // upsert | delete
  TextColumn get payload => text()(); // JSON encoded row or id
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
}
