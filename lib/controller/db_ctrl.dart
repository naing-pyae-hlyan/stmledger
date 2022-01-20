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

  Future<dynamic> deleteById(int id) async {
    int? resp;
    try {
      resp = await ProductsTable.deleteById(id);
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

  Future<dynamic> find() async {
    List<VoucherModel>? resp = [];
    try {
      resp = await VoucherTable.find(
          fstDate: fstTimestamp, lastDate: lastTimestamp, type: productType);
    } catch (e) {
      return ErrorResponse(code: null, message: e.toString());
    }
    return resp;
  }

  int? fstTimestamp;
  int? lastTimestamp;
  String productType = allCategoryConst.value!;

  void setQuery(
      {String? type,
      int? fstDate,
      int? lstDate,
      bool needCallDBandNotify = true}) async {
    productType = type ?? allCategoryConst.value!;
    fstTimestamp = fstDate;
    lastTimestamp = lstDate;
    if (needCallDBandNotify) {
      await find();
      notifyListeners();
    }
  }

  void resetQuery() {
    productType = allCategoryConst.value!;
    fstTimestamp = null;
    lastTimestamp = null;
  }
}
