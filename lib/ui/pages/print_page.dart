import '../../lib_exp.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PrintPage extends StatefulWidget {
  final VoucherModel voucher;
  final int totalAmount;
  final String note;
  const PrintPage({
    required this.voucher,
    required this.totalAmount,
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  _PrintPageState createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  late PrintCtrl _printCtrl;
  late FToast _fToast;

  void _onRefresh() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 3)).then(
          (value) => _refreshController.refreshCompleted(),
        );
  }

  void _onLoading() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 3)).then(
          (value) => _refreshController.loadComplete(),
        );
  }

  Future<void> _connectToDevice(BluetoothDevice? device) async {
    if (device == null) {
      DialogUtils.errorDialog(context, 'Error!');
    } else if (_printCtrl.connected) {
      await bluetoothPrint.disconnect();
      _printCtrl.setState(BluetoothPrint.DISCONNECTED);
    } else {
      _printCtrl.setDevices(device);
      await bluetoothPrint.connect(device);
      _printCtrl.setState(await bluetoothPrint.isConnected ?? false ? 1 : 0);
    }
  }

  Future<void> _print(BluetoothDevice? device) async {
    if (device == null && !_printCtrl.connected) {
      showToast(
        _fToast,
        msg: 'Connect your printer first.',
        gravity: ToastGravity.BOTTOM,
        alertType: AlertType.warning,
      );
      return;
    } else {
      List<LineText> data = [];
      data.add(LineText());

      try {
        Future.delayed(Duration.zero,
            () async => await bluetoothPrint.printLabel({}, data));
      } catch (e) {
        showToast(
          _fToast,
          msg: e.toString(),
          gravity: ToastGravity.CENTER,
          alertType: AlertType.fail,
        );
      }
    }
  }

  Future<void> _initPrinter() async {
    await bluetoothPrint.startScan(timeout: Duration(milliseconds: 5000));
    bool isConnected = await bluetoothPrint.isConnected ?? false;
    bluetoothPrint.state.listen((event) => _printCtrl.setState(event));

    if (!mounted) return;
    if (isConnected) _printCtrl.setState(BluetoothPrint.CONNECTED);
  }

  @override
  void initState() {
    super.initState();
    _printCtrl = context.read<PrintCtrl>();
    WidgetsBinding.instance
        ?.addPostFrameCallback((timeStamp) => _initPrinter());
    _fToast = FToast();
    _fToast.init(context);
  }

  @override
  void dispose() {
    if (mounted) bluetoothPrint.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropMaterialHeader(
          backgroundColor: AppColors.primaryColor,
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: StreamBuilder<List<BluetoothDevice>>(
          stream: bluetoothPrint.scanResults,
          initialData: [],
          builder: (_, snapshot) {
            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              return Consumer<PrintCtrl>(
                builder: (_, printCtrl, __) => ListView(
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map(
                        (device) => ListTile(
                          leading: const Icon(Icons.print),
                          title: Text(device.name ?? ''),
                          subtitle: Text(device.address ?? ''),
                          trailing: printCtrl.connectedDevice != null &&
                                  printCtrl.connectedDevice?.address ==
                                      device.address &&
                                  printCtrl.connected
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.successColor,
                                )
                              : null,
                          onTap: () => _connectToDevice(device),
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return Center(
                child: Text('Searching...'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print, color: AppColors.primaryColor),
        backgroundColor: Colors.white,
        onPressed: () => _print(_printCtrl.connectedDevice),
      ),
    );
  }
}
