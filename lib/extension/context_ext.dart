
import '../lib_exp.dart';

extension ContextExtensions on BuildContext {
  void pop() => Navigator.of(this).pop();

  Future<dynamic> push(Widget page) =>
      Navigator.of(this).push(CustomPageRoute(page)
          // MaterialPageRoute(builder: (_) => page),
          );

  Future<dynamic> pushAndRemoveUntil(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil(
        CustomPageRoute(page),
        (route) => false,
      );

  get queryData => MediaQuery.of(this);
  double get width => queryData.size.width;
  double get height => queryData.size.height;
  get minSize => min(width, height);
  double get fivePercentOfWidth {
    return width * 0.05;
  }

  double get tenPercentOfWidth {
    return width * 0.1;
  }
}
