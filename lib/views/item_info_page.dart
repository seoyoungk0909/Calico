import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'components/item_info_ui.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});
  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  Widget itemView(List<ItemElement> items, Model model,
      YoutubePlayerController ypController) {
    return Column(children: [
      itemHeader(context, model),
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

  Widget timeItemView(List<TimeShopItemLists> timeShopItemsList, Model model,
      YoutubePlayerController ypController) {
    for (int i = 0; i < timeShopItemsList.length; i++) {
      TimeShopItemLists currentItem = timeShopItemsList[i];
      TimeShopItemLists? nextItem =
          (i + 1 < timeShopItemsList.length) ? timeShopItemsList[i + 1] : null;

      if (currentItem.times!.start! <= ypController.value.position.inSeconds &&
          (nextItem == null ||
              nextItem.times!.start! > ypController.value.position.inSeconds)) {
        return itemView(currentItem.items!, model, ypController);
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
    List<TimeShopItemLists> timeShopItemList = arguments['timeShopItems'];
    Model model = arguments['model'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Info Page'),
      ),
      body: GestureDetector(
        // child: itemView(items, model, ypController),
        child: timeItemView(timeShopItemList, model, ypController),
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
