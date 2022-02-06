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
    );
    debugLog(tag, maps.toString());
    List<WarehouseModel> list = [];
    List<WarehouseModel> temp = [];
    final List<WarehouseModel> modelList = List.generate(
        maps.length, (index) => WarehouseModel.fromJson(maps[index]));

    modelList.forEach((element) {
      temp.add(element);
    });

    for (int i = 0, l = modelList.length; i < l; i++) {
      for (int j = i + 1; j < l; j++) {
        if (modelList[i].productName == modelList[j].productName) {
          temp[i].inStock = modelList[i].inStock! + modelList[j].inStock!;
          ;
          temp[i].outStock = modelList[i].outStock! + modelList[j].outStock!;
          ;
          temp.remove(modelList[j]);
        }
      }
    }
    return temp;
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
