import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:clovi_template/models/times_model.dart';

class TimeShopItemLists {
  Times? times;
  Model? model;
  List<ItemElement>? items;

  TimeShopItemLists({
    this.times,
    this.model,
    this.items,
  });

  TimeShopItemLists.fromJson(Map<String, dynamic> json) {
    times = json['times'] != null ? Times.fromJson(json['times']) : null;
    model = json['model'] != null ? Model.fromJson(json['model']) : null;
    if (json['items'] != null) {
      items = <ItemElement>[];
      json['items'].forEach((v) {
        items!.add(ItemElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (times != null) {
      data['times'] = times!.toJson();
    }
    if (model != null) {
      data['model'] = model!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
