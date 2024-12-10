import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = 'catapp_database.db';
  final String tableName = 'cats';

  Database? _db;

  Future<Database> openDb() async {
    _db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        version: version, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE $tableName(
          id TEXT PRIMARY KEY,
          name TEXT,
          origin TEXT,
          energy_level INTEGER,
          description TEXT,
          reference_image_id TEXT,
          temperament TEXT,
          intelligence INTEGER
        )
      ''');
    });
    return _db as Database;
  }
}
