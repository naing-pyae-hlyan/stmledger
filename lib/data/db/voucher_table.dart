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
      '$productsConst TEXT'
      ')',
    );
  }

  static Future<List<VoucherModel>> find({
    required int? fstDate,
    required int? lastDate,
    required String productName,
  }) async {
    List<Map<String, dynamic>> maps = [];
    if (fstDate == null &&
        lastDate == null &&
        productName != allCategoryConst) {
      maps = await DbGeneralFunc.getByQuery(
          tableName: tableName,
          column: productsConst,
          productName: productName);
    } else if (fstDate != null &&
        lastDate != null &&
        productName == allCategoryConst) {
      maps = await DbGeneralFunc.getByDate(
        tableName,
        column: timestampConst,
        fstDate: fstDate,
        lstDate: lastDate,
      );
    } else if (fstDate != null &&
        lastDate != null &&
        productName != allCategoryConst) {
      // maps = await db.rawQuery(MySqlQueries.getByDateWithQuery(
      //   tableName,
      //   column: timestampConst,
      //   fstTimestamp: fstDate,
      //   lastTimestamp: lastDate,
      //   productName: productName,
      //   idName: uniqueIdConst,
      // ));
    } else {
      maps = await DbGeneralFunc.getAll(tableName: tableName);
    }
    debugLog(tag, maps.toString());
    final List<VoucherModel> voucherList = List.generate(
        maps.length, (index) => VoucherModel.fromJson(maps[index]));
    return _filteredByProductName(
        voucherList: voucherList, productName: productName);
  }

  static List<VoucherModel> _filteredByProductName({
    required List<VoucherModel> voucherList,
    required String productName,
  }) {
    if (productName != allCategoryConst) {
      List<Product> productList = [];
      List<VoucherModel> filteredVoucherList = [];
      int charge = 0;
      for (var v in voucherList) {
        productList.clear();
        charge = 0;
        for (var p in v.products!) {
          if (p.name == productName) {
            charge += p.price!;
            productList.add(p);
          }
        }
        filteredVoucherList.add(VoucherModel(
          timestamp: v.timestamp,
          charge: charge,
          note: v.note,
          products: productList,
        ));
      }
      return filteredVoucherList;
    } else {
      return voucherList;
    }
  }

  static Future<List<VoucherModel>> getAllVoucher() async {
    final List<Map<String, dynamic>> maps =
        await DbGeneralFunc.getAll(tableName: tableName);

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
    map[productsConst] = jsonEncode(json);

    return DbGeneralFunc.insert(
      tableName: tableName,
      values: map,
    );
  }

  static Future<int> deleteAll() async =>
      DbGeneralFunc.deleteAll(tableName: tableName);
}
