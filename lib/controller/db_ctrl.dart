import '../lib_exp.dart';

class DbCtrl with ChangeNotifier {
  void refreshUI() => notifyListeners();
  // For product category
  Future<dynamic> getAllProductList() async {
    List<Product> resp = [];
    try {
      resp = await ProductsTable.getAll();
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> insertProduct(Product product) async {
    int? resp;
    try {
      resp = await ProductsTable.insert(product);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> updateProduct(Product product) async {
    int? resp;
    try {
      resp = await ProductsTable.update(product);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> productDeleteById(int id) async {
    int? resp;
    try {
      resp = await ProductsTable.deleteById(id);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }
  Future<dynamic> warehouseDeleteById(int id) async {
    int? resp;
    try {
      resp = await WarehouseTable.deleteById(id);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> _insertWarehouse({
    required String name,
    required int instock,
    required int productId,
  }) async {
    int? resp;
    try {
      resp = await WarehouseTable.insert(
        productName: name,
        inStock: instock,
        productId: productId,
      );
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> updateWarehouse(WarehouseModel model) async {
    int? resp;
    try {
      resp = await WarehouseTable.update(model);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> updateNameOnly({
    required int productId,
    required String newName,
  }) async {
    int? resp;
    try {
      resp = await WarehouseTable.updateNameOnly(
          productId: productId, newName: newName);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  /// For Voucher
  Future<dynamic> getAllVoucher() async {
    List<VoucherModel> resp = [];
    try {
      resp = await VoucherTable.getAllVoucher();
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> insertVoucher({
    required List<Product> products,
    required int charge,
    required String note,
  }) async {
    int? resp;
    try {
      resp = await VoucherTable.insert(
        products: products,
        charge: charge,
        note: note,
      );
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> findVoucher() async {
    List<dynamic>? resp = [];
    try {
      resp = await VoucherTable.find(
        fstDate: _fstTimestamp,
        lastDate: _lastTimestamp,
        productName: pName,
        limit: vLimit,
      );
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  Future<dynamic> findWarehouse({
    required List<Product> products,
  }) async {
    List<dynamic>? resp = [];

    try {
      resp = await WarehouseTable.find(
        fstDate: _fstTimestamp,
        lastDate: _lastTimestamp,
        productName: pName,
      );

      if (_fstTimestamp!.isToday() && _lastTimestamp!.isToday()) {
        if (resp.isEmpty) {
          for (final p in products) {
            await _insertWarehouse(
              name: p.name!,
              instock: 0,
              productId: p.id!,
            );
          }
        } else if (pName == allCategoryConst) {
          List<int> tempRespList = [];
          List<Map<int, String>> tempProductList = [];

          /// added the Product to List<Map<int,String>> and Warehouse model list to List<String>
          for (final p in products) tempProductList.add({p.id!: p.name!});

          for (final r in resp) tempRespList.add(r.productId);

          for (final p in tempProductList)
            if (!tempRespList.contains(p.keys.first)) {
              await _insertWarehouse(
                productId: p.keys.first,
                name: p.values.first,
                instock: 0,
              );
            }
        }
      }
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  DateTime? _fstTimestamp;
  DateTime? _lastTimestamp;
  String pName = allCategoryConst;
  int vLimit = voucherLimit;

  void increaseVoucherPage() {
    vLimit += voucherLimit;
    notifyListeners();
  }

  void setQuery({
    String? productName,
    DateTime? fstDate,
    DateTime? lstDate,
    bool needToNotify = true,
  }) async {
    pName = productName ?? allCategoryConst;
    _fstTimestamp = fstDate;
    _lastTimestamp = lstDate;
    vLimit = voucherLimit;
    if (needToNotify) {
      notifyListeners();
    }
  }

  void resetQuery() {
    pName = allCategoryConst;
    _fstTimestamp = null;
    _lastTimestamp = null;
    vLimit = voucherLimit;
  }
}
