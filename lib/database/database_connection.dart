// lib/database/database_connection.dart

export 'database_connection_stub.dart'
    if (dart.library.html) 'database_connection_web.dart'
    if (dart.library.io) 'database_connection_native.dart';

// QueryExecutor openConnection() {
//   // This will be replaced by the correct implementation per platform.
//   throw UnsupportedError('Cannot create a database connection');
// }