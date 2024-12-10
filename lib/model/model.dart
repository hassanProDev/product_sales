class AccessoryModel {
  String name;
  String id;
  double price;

  AccessoryModel({required this.name, required this.id, required this.price});

  factory AccessoryModel.fromJson(Map json) {
    return AccessoryModel(
      name: json[JsonKey.name],
      id: json[JsonKey.id],
      price: json[JsonKey.price],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      JsonKey.name: name,
      JsonKey.id: id,
      JsonKey.price: price,
    };
  }
}

class JsonKey {
  static const String name = 'name';
  static const String price = 'price';
  static const String id = 'id';
}
