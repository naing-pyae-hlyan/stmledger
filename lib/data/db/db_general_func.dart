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

  static Future<List<Map<String, dynamic>>> getAll(
      {required String tableName}) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    debugLog(tableName, 'Get All from DB --!');
    return await db.rawQuery(
      'SELECT * FROM $tableName  ORDER BY id DESC LIMIT 1000',
    );
  }

  static Future<List<Map<String, dynamic>>> getByQuery(
      {required String tableName,
      required String column,
      required String productName}) async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];

    debugLog(tableName, 'Get by query from DB $productName--!');
    return await db.rawQuery(
      "SELECT * FROM $tableName WHERE $column LIKE '%$productName%' ORDER BY id DESC LIMIT 1000",
    );
  }

  static Future<List<Map<String, dynamic>>> getByDateWithQuery(
    String tableName, {
    required String dateColumn,
    required String? productColumn,
    required DateTime? from,
    required DateTime? to,
    required String? search,
    int limit = 100,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    debugLog(
      tableName,
      'Get by date with qyery from DB $dateColumn--! $from to $to $search',
    );
    String rawQuery = "SELECT * FROM $tableName WHERE $dateColumn";
    if (from != null) {
      rawQuery +=
          " AND STRFTIME('%Y-%m-%d %H:%M:%S.%s', $dateColumn) >='$from'";
    }
    if (to != null) {
      rawQuery += " AND STRFTIME('%Y-%m-%d %H:%M:%S.%s', $dateColumn) <='$to'";
    }
    if (search != null && productColumn != null) {
      rawQuery += " AND $productColumn LIKE '%$search%'";
    }

    return await db.rawQuery(rawQuery + " ORDER BY id DESC LIMIT 0, $limit");
  }

  static Future<int> updateById({
    required String tableName,
    required int id,
    required Map<String, dynamic> values,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Updated DB by ID --> $id $values');
    return await db.update(
      tableName,
      values,
      where: '$uniqueIdConst=?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteById({
    required String tableName,
    required int id,
  }) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Deleted DB by ID --> $id');
    return await db
        .delete(tableName, where: '$uniqueIdConst=?', whereArgs: [id]);
  }

  static Future<int> deleteAll({required String tableName}) async {
    /// Get a reference to the database;
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Deleted All DB --!');
    return db.delete(tableName);
  }
}
