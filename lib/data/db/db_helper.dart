import 'package:path/path.dart';
import '../../lib_exp.dart';

const String tag = 'DbHelper';

class DbHelper {
  final String _dbName = 'stm.db';
  final int _dbVersion = 1;

  static Database? _db;

  Future<Database?> get db async {
    // Get a singleton database
    _db ??= await _initDB();

    return _db;
  }

  Future<Database?> _initDB() async {
    // Get a location using getDatabasePath();
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _dbName);

    // This will delete old/previous database when app is opened
    // Deleted the database
    // await deleteDatabase(path);

    // Open the database
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await ProductsTable.onCreate(db);
    // Create other tables ----
  }

  static Future clearTables() async {
    // Clear other tables ----
  }
}
