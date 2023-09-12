import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});

  // final YoutubePlayerController ypController;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Info Page'),
      ),
      body: GestureDetector(
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
