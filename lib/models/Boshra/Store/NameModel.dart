class ShopName {
  String name;

  int id;

  factory ShopName.fromJson(Map<String, dynamic> json) {
    return ShopName(name: json['value'], id: json['id']);
  }

  ShopName({required this.name, required this.id});
}

class ShopNameModel {
  List<ShopName> data;

  ShopNameModel({required this.data});

  factory ShopNameModel.fromJson(Map<String, dynamic> json) {
    return ShopNameModel(
        data: List<ShopName>.from(json['data'].map((p) => ShopName.fromJson(p)))
            .toList());
  }
}
