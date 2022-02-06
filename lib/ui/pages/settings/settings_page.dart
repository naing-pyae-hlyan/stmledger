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
              onTap: () {},
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
              onTap: () {},
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
              onTap: () {},
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
