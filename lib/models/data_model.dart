import 'package:clovi_template/models/time_shop_items_model.dart';

class Data {
  int? id;
  String? title;
  String? creator;
  String? profileImgUrl;
  String? videoUrl;
  String? uploadDate;
  List<TimeShopItemLists>? timeShopItemLists;

  Data({
    this.id,
    this.title,
    this.creator,
    this.profileImgUrl,
    this.videoUrl,
    this.uploadDate,
    this.timeShopItemLists,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    creator = json['creator'];
    profileImgUrl = json['profileImgUrl'];
    videoUrl = json['videoUrl'];
    uploadDate = json['uploadDate'];
    if (json['timeShopItemLists'] != null) {
      timeShopItemLists = <TimeShopItemLists>[];
      json['timeShopItemLists'].forEach((v) {
        timeShopItemLists!.add(TimeShopItemLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['creator'] = creator;
    data['profileImgUrl'] = profileImgUrl;
    data['videoUrl'] = videoUrl;
    data['uploadDate'] = uploadDate;
    if (timeShopItemLists != null) {
      data['timeShopItemLists'] =
          timeShopItemLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
