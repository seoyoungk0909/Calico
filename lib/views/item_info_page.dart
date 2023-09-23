import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/item_model.dart';
import 'components/item_info_ui.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});
  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  Widget itemView(List<Item> items, String modelName,
      YoutubePlayerController ypController) {
    return Column(children: [
      itemHeader(context, modelName),
      ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (
          BuildContext context,
          int i,
        ) {
          return videoItemUI(context, items[i], ypController);
        },
      ),
    ]);
  }

  Widget timeItemView(List<TimeShopItems> timeShopItemsList, String modelName,
      YoutubePlayerController ypController) {
    for (int i = 0; i < timeShopItemsList.length; i++) {
      TimeShopItems currentItem = timeShopItemsList[i];
      TimeShopItems? nextItem =
          (i + 1 < timeShopItemsList.length) ? timeShopItemsList[i + 1] : null;

      if (currentItem.startTime <= ypController.value.position &&
          (nextItem == null ||
              nextItem.startTime > ypController.value.position)) {
        return itemView(currentItem.items, modelName, ypController);
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    // List<Item> items = arguments['items'];
    List<TimeShopItems> timeShopItemsList = arguments['timeShopItems'];
    String modelName = arguments['modelName'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Info Page'),
      ),
      body: GestureDetector(
        // child: itemView(items, modelName, ypController),
        child: timeItemView(timeShopItemsList, modelName, ypController),
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
