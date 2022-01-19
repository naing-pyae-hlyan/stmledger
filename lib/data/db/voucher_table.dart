import '../../lib_exp.dart';

const tableName = 'voucher_table';

class VoucherTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$timestampConst INT,'
      '$chargeConst INT,'
      '$voucherConst TEXT'
      ')',
    );
  }

  static Future<List<Product>> find({
    required int fstDate,
    required int lastDate,
    required String query,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      "SELECT * FROM $tableName WHERE "
      "$voucherConst REGEXP '$query' AND "
      "$timestampConst > '$fstDate' AND "
      "$timestampConst < '$lastDate' ORDER BY "
      "$uniqueIdConst DESC LIMIT 1000",
    );
    if (true) {
      
    }
    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }

  static Future<List<Product>> getAll() async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }

  static Future<int> insert({
    required List<Product> products,
    required int charge,
  }) async {
    Map<String, dynamic> map = {};
    map[timestampConst] = MyDateUtils.timestampNow;
    map[chargeConst] = charge;
    List<Map<String, dynamic>> json = [];

    for (var p in products) {
      json.add({
        productNameConst: p.name,
        productPriceConst: p.price,
        qtyConst: p.qty,
      });
    }
    map[voucherConst] = json.toString();

    return DbGeneralFunc.insert(
      tableName: tableName,
      values: map,
    );
  }

  static Future<int> deleteAll() async =>
      DbGeneralFunc.deleteAll(tableName: tableName);
}
