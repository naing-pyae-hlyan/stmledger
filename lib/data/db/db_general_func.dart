import '../../lib_exp.dart';

class DbGeneralFunc {
  static Future<int> insert({
    required String tableName,
    required Map<String, dynamic> values,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    /// Insert User into the table.
    /// Also specify the 'conflictAlgorithm'.
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Insert to DB --> $values');
    return await db.insert(
      tableName,
      values,
      conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertAll({
    required String tableName,
    required List<Map<String, Object>> values,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return;
    debugLog(tableName, 'InsertAll to DB --> $values');

    /// Insert author names into the table.
    /// also specify the 'conflictAlgorithm'.
    /// In this case, if the same author name is inserted multiple times.
    /// its replaces the previous data.

    for (var i in values) {
      await db.insert(
        tableName,
        i,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<Map>> getAll({required String tableName}) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    debugLog(tableName, 'Get All from DB --!');
    return await db.rawQuery('SELECT * FROM $tableName');
  }

  static Future<int> deleteById({
    required String tableName,
    required int id,
  }) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Deleted DB by ID --> $id');
    return await db.delete(tableName, where: '$productIdConst=?', whereArgs: [id]);
  }

  static Future<int> deleteAll({required String tableName}) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Deleted All DB --!');
    return db.delete(tableName);
  }
}
