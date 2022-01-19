import '../../lib_exp.dart';

const tableName = 'products_table';

class ProductsTable {
  static Future<void> onCreate(Database db) async {
    await db.execute(
      'CREATE TABLE $tableName('
      '$uniqueIdConst INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$productNameConst TEXT,'
      '$productPriceConst INT,'
      '$imgUrlConst TEXT'
      ')',
    );
  }

  static Future<int> insert(Product product) async => DbGeneralFunc.insert(
        tableName: tableName,
        values: {
          productNameConst: product.name,
          productPriceConst: product.price,
          imgUrlConst: product.imgURl,
        },
      );

  static Future<List<Product>> getAll() async {
    final Database? db = await DbHelper().db;
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));
  }

  static Future<int> deleteById(int id) async =>
      DbGeneralFunc.deleteById(tableName: tableName, id: id);

  static Future<int> deleteAll() async =>
      DbGeneralFunc.deleteAll(tableName: tableName);
}
