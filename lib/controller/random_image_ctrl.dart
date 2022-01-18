import '../lib_exp.dart';

class RandomImageCtrl with ChangeNotifier {
  String? randomImage;
  RandomImageCtrl({required this.randomImage});

  void createRandomImageUrl() {
    randomImage = categoryCakes[Random().nextInt(categoryCakes.length)];
    notifyListeners();
  }

  void setImageURl(String? url) {
    randomImage = url;
  }
}
