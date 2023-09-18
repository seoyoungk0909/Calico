import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'components/item_info_ui.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});
  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  Widget itemView(
      List items, String modelName, YoutubePlayerController ypController) {
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

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    List items = arguments['items'];
    String modelName = arguments['modelName'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Item Info Page'),
      ),
      body: GestureDetector(
        child: itemView(items, modelName, ypController),
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            ypController.play();
            Navigator.pop(context);
          }
        },

        // child: Container(
        //   child: Text('${widget.ypController}'),
        // ),
      ),
    );
  }
}
