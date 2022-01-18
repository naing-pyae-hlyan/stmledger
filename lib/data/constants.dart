import 'package:stmledger/lib_exp.dart';

const dia = 'ks';

final List<HomeTypeModel> homeTypes = [
  HomeTypeModel(
    name: 'အမျိုးအစားများ',
    url: 'assets/icons/bakery.png',
    type: HomeTypeEnum.category,
  ),
  HomeTypeModel(
    name: 'အရောင်း',
    url: 'assets/icons/sale.png',
    type: HomeTypeEnum.sale,
  ),
  HomeTypeModel(
    name: 'စာရင်း',
    url: 'assets/icons/summary.png',
    type: HomeTypeEnum.summary,
  ),
];

final List<String> categoryCakes = [
  'assets/icons/bakery.png',
  'assets/icons/bread1.png',
  'assets/icons/bread2.png',
  'assets/icons/bread3.png',
  'assets/icons/bread4.png',
];
