import 'item_model.dart';

class TimeShopItems {
  Duration startTime = Duration.zero;
  List<Item> items = [];

  TimeShopItems({
    Duration? itemsStartTime,
    List<Item>? itemsItems,
  }) {
    startTime = itemsStartTime ?? startTime;
    items = itemsItems ?? items;
  }
}
