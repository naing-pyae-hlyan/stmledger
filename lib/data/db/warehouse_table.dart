import '../../lib_exp.dart';

const tableName = 'warehouse_table';

class WarehouseTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$productIdConst INT,'
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
    required int productId,
  }) async {
    return await DbGeneralFunc.insert(
      tableName: tableName,
      values: {
        productIdConst: productId,
        dateConst: MyDateUtils.iso8601Date,
        productNameConst: productName,
        inStockConst: inStock,
        outStockConst: 0,
      },
    );
  }

  static Future<int> update(WarehouseModel m) async => DbGeneralFunc.updateById(
        tableName: tableName,
        whereArgsId: m.id!,
        values: {
          productNameConst: m.productName,
          inStockConst: m.inStock,
          outStockConst: m.outStock,
        },
      );

  static Future<dynamic> updateNameOnly({
    required int productId,
    required String newName,
  }) async {
    final Database? db = await DbHelper().db;
    if (db == null) return 0;
    debugLog(tableName, 'Updated DB by ID --> $newName WHERE : $productId');
    return await db.rawUpdate(
      "UPDATE $tableName SET  product_name = '$newName' WHERE product_id = $productId",
    );
  }

  static Future<int> deleteById(int id,
          {String where = productIdConst}) async =>
      DbGeneralFunc.deleteById(
        tableName: tableName,
        whereArgsId: id,
        where: where,
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
    // debugLog(tag, maps.toString());
    final List<WarehouseModel> modelList = List.generate(
        maps.length, (index) => WarehouseModel.fromJson(maps[index]));
    return await _filteredByProductName(
      models: modelList,
      pName: productName,
      from: fstDate ?? DateTime.now(),
      to: lastDate ?? DateTime.now(),
    );
  }

  static Future<List<WarehouseModel>> _filteredByProductName({
    required List<WarehouseModel> models,
    required String pName,
    required DateTime from,
    required DateTime to,
  }) async {
    if (await !from.isToday() || await !to.isToday()) {
      List<WarehouseModel> filtered = [];
      for (int i = 0, l = models.length; i < l; i++) {
        for (int j = i + 1; j < l; j++) {
          if (models[i].productId == models[j].productId &&
              models[i].productName == models[j].productName) {
            filtered.add(WarehouseModel(
              id: models[i].id,
              productId: models[i].productId,
              iso8601Date: models[i].iso8601Date,
              productName: models[i].productName,
              inStock: models[i].inStock! + models[j].inStock!,
              outStock: models[i].outStock! + models[j].outStock!,
            ));
          }
        }
      }

      return filtered.isNotEmpty ? filtered : models;
    } else if (pName != allCategoryConst) {
      List<WarehouseModel> filtered = [];
      for (final p in models) {
        if (p.productName == pName) {
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
