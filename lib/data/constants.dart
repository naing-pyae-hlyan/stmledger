import 'package:stmledger/lib_exp.dart';

const dia = 'ks';
const appName = 'ရွှေသမင် မုန့်တိုက်';

final List<HomeTypeModel> homeTypes = [
  HomeTypeModel(
    name: 'အမျိုးအစားများ',
    url: 'assets/icons/bakery.png',
    type: HomeTypeEnum.category,
  ),
  HomeTypeModel(
    name: 'ဂိုထောင်',
    url: 'assets/icons/warehouse.png',
    type: HomeTypeEnum.warehouse,
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
  HomeTypeModel(
    name: 'အပြင်အဆင်',
    url: 'assets/icons/setting.png',
    type: HomeTypeEnum.setting,
  ),
];

final List<String> categoryCakes = [
  'assets/icons/bakery.png',
  'assets/icons/bread1.png',
  'assets/icons/bread2.png',
  'assets/icons/bread3.png',
  'assets/icons/bread4.png',
];
