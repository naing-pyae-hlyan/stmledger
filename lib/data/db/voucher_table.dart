import '../../lib_exp.dart';

const tableName = 'voucher_table';

class VoucherTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$dateConst TEXT,'
      '$chargeConst INT,'
      '$noteConst TEXT,'
      '$productsConst TEXT'
      ')',
    );
  }

  static Future<List<VoucherModel>> find({
    required DateTime? fstDate,
    required DateTime? lastDate,
    required String productName,
    int limit = 100,
  }) async {
    List<Map<String, dynamic>> maps = [];
    maps = await DbGeneralFunc.getByDateWithQuery(
      tableName,
      dateColumn: dateConst,
      from: fstDate,
      to: lastDate,
      limit: limit,
      productColumn: productName == allCategoryConst ? null : productsConst,
      search: productName == allCategoryConst ? null : productName,
    );
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
        charge = 0;
        for (var p in v.products!) {
          if (p.name == productName) {
            charge += p.price! * p.qty!;
            productList.add(p);
          }
        }
        filteredVoucherList.add(VoucherModel(
          iso8601Date: v.iso8601Date,
          charge: charge,
          note: v.note,
          products: [...productList],
        ));
        productList.clear();
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
    map[dateConst] = MyDateUtils.iso8601Date;
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
