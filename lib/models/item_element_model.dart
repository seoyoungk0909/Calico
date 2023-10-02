import 'package:clovi_template/models/item_model.dart';
import 'package:clovi_template/models/shops_model.dart';

class ItemElement {
  Item? item;
  Shops? affiliationLink;

  ItemElement({this.item, this.affiliationLink});

  ItemElement.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    affiliationLink = json['affiliationLink'] != null
        ? Shops.fromJson(json['affiliationLink'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (affiliationLink != null) {
      data['affiliationLink'] = affiliationLink!.toJson();
    }
    return data;
  }
}
