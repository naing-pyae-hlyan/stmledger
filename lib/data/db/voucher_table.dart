import '../../lib_exp.dart';

const tableName = 'voucher_table';

class VoucherTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$timestampConst INT,'
      '$chargeConst INT,'
      '$noteConst TEXT,'
      '$voucherConst TEXT'
      ')',
    );
  }

  static Future<List<VoucherModel>> find({
    required int fstDate,
    required int lastDate,
    required String query,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    List<Map<String, dynamic>> maps = [];
    if (query == allCategoryConst) {
      maps = await db.rawQuery(MySqlQueries.getAll(tableName, uniqueIdConst));
    } else {
      maps = await db.rawQuery(
        MySqlQueries.getByQuery(
          tableName,
          column: voucherConst,
          query: query,
          idName: uniqueIdConst,
        ),
      );
    }

    // final List<Map<String, dynamic>> maps = await db.rawQuery(
    //   "SELECT * FROM $tableName WHERE "
    //   "$voucherConst REGEXP '$query' AND "
    //   "$timestampConst > '$fstDate' AND "
    //   "$timestampConst < '$lastDate' ORDER BY "
    //   "$uniqueIdConst DESC LIMIT 1000",
    // );

    return List.generate(
        maps.length, (index) => VoucherModel.fromJson(maps[index]));
  }

  static Future<List<VoucherModel>> getAllVoucher() async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        MySqlQueries.getAll(tableName, uniqueIdConst)
        // 'SELECT * FROM $tableName ORDER BY $uniqueIdConst DESC LIMIT 1000',
        );

    return List.generate(
        maps.length, (index) => VoucherModel.fromJson(maps[index]));
  }

  static Future<int> insert({
    required List<Product> products,
    required int charge,
    required String note,
  }) async {
    Map<String, dynamic> map = {};
    map[timestampConst] = MyDateUtils.timestampNow;
    map[chargeConst] = charge;
    map[noteConst] = note;
    List<Map<String, dynamic>> json = [];

    for (var p in products) {
      json.add({
        productNameConst: p.name,
        productPriceConst: p.price,
        qtyConst: p.qty,
      });
    }
    map[voucherConst] = jsonEncode(json);

    return DbGeneralFunc.insert(
      tableName: tableName,
      values: map,
    );
  }

  static Future<int> deleteAll() async =>
      DbGeneralFunc.deleteAll(tableName: tableName);
}
