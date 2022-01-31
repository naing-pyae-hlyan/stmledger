import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

import '../lib_exp.dart';

class PrintCtrl with ChangeNotifier {
  bool connected = false;
  BluetoothDevice? connectedDevice;

  void setDevices(BluetoothDevice? d) {
    this.connectedDevice = d;
    notifyListeners();
  }

  void setState(int b) {
    switch (b) {
      case BluetoothPrint.CONNECTED:
        this.connected = true;
        break;
      case BluetoothPrint.DISCONNECTED:
        this.connected = false;
        break;
      default:
        this.connected = false;
        break;
    }
    notifyListeners();
  }
}
