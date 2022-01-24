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
    required int? fstDate,
    required int? lastDate,
    required String productName,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    List<Map<String, dynamic>> maps = [];
    if (fstDate == null &&
        lastDate == null &&
        productName != allCategoryConst) {
      maps = await db.rawQuery(MySqlQueries.getByQuery(
        tableName,
        column: voucherConst,
        productName: productName,
        idName: uniqueIdConst,
      ));
    } else if (fstDate != null &&
        lastDate != null &&
        productName == allCategoryConst) {
      maps = await db.rawQuery(MySqlQueries.getByDate(
        tableName,
        column: timestampConst,
        fstTimestamp: fstDate,
        lastTimestamp: lastDate,
        idName: uniqueIdConst,
      ));
    } else if (fstDate != null &&
        lastDate != null &&
        productName != allCategoryConst) {
      maps = await db.rawQuery(MySqlQueries.getByDateWithQuery(
        tableName,
        column: timestampConst,
        fstTimestamp: fstDate,
        lastTimestamp: lastDate,
        productName: productName,
        idName: uniqueIdConst,
      ));
    } else {
      maps = await db.rawQuery(MySqlQueries.getAll(tableName, uniqueIdConst));
    }

    return List.generate(
        maps.length, (index) => VoucherModel.fromJson(maps[index]));
  }

  static Future<List<VoucherModel>> getAllVoucher() async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(MySqlQueries.getAll(tableName, uniqueIdConst));

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
        productIdConst: p.id,
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
