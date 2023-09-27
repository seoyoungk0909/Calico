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
        physics: NeverScrollableScrollPhysics(),
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

  Widget allItemView(
    List<TimeShopItems> timeShopItems,
    YoutubePlayerController ypController,
  ) {
    List<Item> allItems = timeShopItems.expand((item) => item.items).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.only(left: 20),
          child: const Text(
            '영상에 나온 옷들',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )),
      Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double screenHeight = MediaQuery.of(context).size.height;
              double desiredHeight = screenHeight * 0.7; // 70% of screen height
              return SizedBox(
                height: desiredHeight,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (BuildContext context, int index) {
                    return allItemUI(context, allItems[index], ypController);
                  },
                ),
              );
            },
          )),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (
                  BuildContext context,
                  int i,
                ) {
                  return timeItemView(
                      timeShopItemsList, modelName, ypController);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (
                  BuildContext context,
                  int i,
                ) {
                  return allItemView(timeShopItemsList, ypController);
                },
              ),
            ],
          ),
        ),
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
