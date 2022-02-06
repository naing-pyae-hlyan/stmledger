import '../../lib_exp.dart';

const tableName = 'warehouse_table';

class WarehouseTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$dateConst TEXT,'
      '$productNameConst TEXT,'
      '$inStockConst INT,'
      '$outStockConst INT'
      ')',
    );
  }

  static Future<int> insert({
    required String productName,
    required int inStock,
  }) async {
    return await DbGeneralFunc.insert(
      tableName: tableName,
      values: {
        dateConst: MyDateUtils.iso8601Date,
        productNameConst: productName,
        inStockConst: inStock,
        outStockConst: 0,
      },
    );
  }

  static Future<int> update(WarehouseModel m) async => DbGeneralFunc.updateById(
        tableName: tableName,
        id: m.id!,
        values: {
          productNameConst: m.productName,
          inStockConst: m.inStock,
          outStockConst: m.outStock,
        },
      );

  static Future<List<WarehouseModel>> find({
    required DateTime? fstDate,
    required DateTime? lastDate,
    required String productName,
  }) async {
    List<Map<String, dynamic>> maps = [];
    maps = await DbGeneralFunc.getByDateWithQuery(
      tableName,
      dateColumn: dateConst,
      productColumn: productName == allCategoryConst ? null : productNameConst,
      from: fstDate,
      to: lastDate,
      limit: 10000,
      search: productName == allCategoryConst ? null : productName,
      orderBy: productNameConst,
    );
    debugLog(tag, maps.toString());
    final List<WarehouseModel> modelList = List.generate(
        maps.length, (index) => WarehouseModel.fromJson(maps[index]));
    return _filteredByProductName(
      models: modelList,
      name: productName,
    );
  }

  static List<WarehouseModel> _filteredByProductName({
    required List<WarehouseModel> models,
    required String name,
  }) {
    if (name != allCategoryConst) {
      List<WarehouseModel> filtered = [];
      for (final p in models) {
        if (p.productName == name) {
          filtered.add(p);
        }
      }
      return filtered;
    } else {
      return models;
    }
  }

  static Future<List<WarehouseModel>> getAllVoucher() async {
    final List<Map<String, dynamic>> maps =
        await DbGeneralFunc.getAll(tableName: tableName);

    return List.generate(
        maps.length, (index) => WarehouseModel.fromJson(maps[index]));
  }

  static Future<int> deleteAll() async =>
      DbGeneralFunc.deleteAll(tableName: tableName);
}
