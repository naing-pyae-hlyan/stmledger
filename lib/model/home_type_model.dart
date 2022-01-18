enum HomeTypeEnum {
  category,
  sale,
  summary,
}

class HomeTypeModel {
  String? name;
  String? url;
  HomeTypeEnum? type;
  HomeTypeModel({required this.name, required this.url, required this.type});
}
