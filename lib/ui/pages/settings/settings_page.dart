import 'package:url_launcher/url_launcher.dart';

import '../../../lib_exp.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late FToast _fToast;

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast.init(context);
  }

  Future<void> _delete(int i) async {
    MyAlertDialog.show(
      context,
      type: AlertType.warning,
      title: 'Warning!',
      description:
          'အချက်လက်များကို ဖျက်ခြင်းဖြင့်\n Data များ ဆုံးရှုံးနိုင်ပါသည်။\nနောက်တစ်ကြိမ် အသစ်ပြန်လည်ထည့်သွင်းရမည် ဖြစ်ပါသည်။',
      actionButtonLabel: 'Delete',
      actionButtonLabel2: 'Cancel',
      addCloseButton: true,
      onTapActionButton2: () => context.pop(),
      onTapActionButton: () async {
        switch (i) {
          case 0:
            await ProductsTable.deleteAll().then((value) => showToast(
                  _fToast,
                  msg: 'အမျိုးအစားများအားလုံး ဖျက်ပြီးပါပြီ။',
                  gravity: ToastGravity.CENTER,
                ));
            break;
          case 1:
            await WarehouseTable.deleteById(1, where: uniqueIdConst);
            await WarehouseTable.deleteAll().then((value) => showToast(
                  _fToast,
                  msg: 'ဂိုထောင်ထဲရှိစာရင်းများအားလုံး ဖျက်ပြီးပါပြီ။',
                  gravity: ToastGravity.CENTER,
                ));
            break;
          case 2:
            await VoucherTable.deleteAll().then((value) => showToast(
                  _fToast,
                  msg: 'အရောင်းစာရင်းများအားလုံး ဖျက်ပြီးပါပြီ။',
                  gravity: ToastGravity.CENTER,
                ));
            break;
        }
        context.pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('အပြင်အဆင်'),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            MyButton(
              onTap: () => _delete(0),
              label: '',
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.category),
                  SizedBox(width: 16),
                  Text('အမျိုးအစားများ ဖျက်ရန်'),
                ],
              ),
            ),
            SizedBox(height: 16),
            MyButton(
              onTap: () => _delete(1),
              label: '',
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.home_work),
                  SizedBox(width: 16),
                  Text('ဂိုထောင် ရှင်းရန်'),
                ],
              ),
            ),
            SizedBox(height: 16),
            MyButton(
              onTap: () => _delete(2),
              label: '',
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Icon(Icons.summarize),
                  SizedBox(width: 16),
                  Text('အရောင်းစာရင်းများ ဖျက်ရန်'),
                ],
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.phone),
        onPressed: () async {
          try {
            if (await canLaunch('tel:+959959789617')) {
              await launch('tel:+959959789617');
            }
          } catch (e) {
            showToast(
              _fToast,
              msg: e.toString(),
              alertType: AlertType.fail,
            );
          }
        },
      ),
    );
  }
}
