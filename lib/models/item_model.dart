import 'package:clovi_template/models/shops_model.dart';

class Item {
  int? id;
  String? name;
  int? order;
  String? itemImgUrl;
  String? color;
  String? size;
  String? brand;
  List<String>? colorList;
  List<String>? sizeList;
  List<Shops>? shops;
  List<Item>? childItems;

  Item(
      {this.id,
      this.name,
      this.order,
      this.itemImgUrl,
      this.color,
      this.size,
      this.brand,
      this.colorList,
      this.sizeList,
      this.shops,
      this.childItems});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
    itemImgUrl = json['itemImgUrl'];
    color = json['color'];
    size = json['size'];
    brand = json['brand'];
    if (json['colorList'] != null) {
      colorList = [];
      json['colorList'].forEach((v) {
        colorList!.add(v);
      });
    }
    if (json['sizeList'] != null) {
      sizeList = [];
      json['sizeList'].forEach((v) {
        sizeList!.add(v);
      });
    }
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(Shops.fromJson(v));
      });
    }
    if (json['childItems'] != null) {
      childItems = <Item>[];
      json['childItems'].forEach((v) {
        childItems!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['itemImgUrl'] = itemImgUrl;
    data['color'] = color;
    data['size'] = size;
    data['brand'] = brand;
    if (colorList != null) {
      data['colorList'] = colorList;
    }
    if (sizeList != null) {
      data['sizeList'] = sizeList;
    }
    if (shops != null) {
      data['shops'] = shops!.map((v) => v.toJson()).toList();
    }
    if (childItems != null) {
      data['childItems'] = childItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
