import '../lib_exp.dart';

class ItemPressStateCtrl with ChangeNotifier {
  bool state = false;
  ItemPressStateCtrl({required this.state});

  void stateChange() {
    state = !state;
    notifyListeners();
  }

  void setState(bool b) {
    state = b;
    notifyListeners();
  }
}
