import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../lib_exp.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SpinKitDoubleBounce(
            color: AppColors.primaryColor,
            size: 50,
          ),
          SizedBox(height: 48),
          Text(
            'Loading',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
