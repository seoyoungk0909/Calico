class Shops {
  int? id;
  String? name;
  String? shopUrl;
  String? logoUrl;
  int? price;

  Shops({this.id, this.name, this.shopUrl, this.logoUrl, this.price});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopUrl = json['shopUrl'];
    logoUrl = json['logoUrl'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shopUrl'] = shopUrl;
    data['logoUrl'] = logoUrl;
    data['price'] = price;
    return data;
  }
}
