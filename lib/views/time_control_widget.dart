import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_model.dart';

class TimeControlWidget extends StatefulWidget {
  final YoutubePlayerController ypController;
  final Video video;
  final bool refresh;

  const TimeControlWidget({
    super.key,
    required this.ypController,
    required this.video,
    required this.refresh,
  });

  @override
  State<TimeControlWidget> createState() => _TimeControlWidgetState();
}

class _TimeControlWidgetState extends State<TimeControlWidget> {
  int itemIndex = 1;
  List<Duration> timestamps = [];

  void addStartTime() {
    List<TimeShopItemLists> temp = widget.video.data!.timeShopItemLists!;
    for (int i = 0; i < temp.length; i++) {
      timestamps.add(Duration(seconds: temp[i].times!.start!));
    }
  }

  @override
  void initState() {
    super.initState();
    // Add listener to track current position of the video
    widget.ypController.addListener(updateItemIndex);
    addStartTime();
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    widget.ypController.removeListener(updateItemIndex);
    super.dispose();
  }

  void updateItemIndex() async {
    final currentPosition = widget.ypController.value.position;

    int newIndex = 0;
    for (int i = 0; i < timestamps.length; i++) {
      if (currentPosition >= timestamps[i]) {
        newIndex = i + 1;
      } else {
        break;
      }
    }

    if (newIndex != itemIndex) {
      setState(() {
        itemIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    updateItemIndex();
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // previous
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: TextButton(
              onPressed: () async {
                await showPreviousItems();
                widget.refresh
                    ? (setState(() {
                        // refreshing the page
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'item_info', arguments: {
                          'controller': widget.ypController,
                          'timeShopItems': widget.video.data?.timeShopItemLists,
                          'model':
                              widget.video.data!.timeShopItemLists![0].model!,
                          'video': widget.video,
                          'profileImgUrl': widget.video.data!.profileImgUrl,
                        });
                      }))
                    : null;
              },
              child: Text('이전 옷 보기'),
            ),
          ),
          // number
          Padding(
            padding: EdgeInsetsDirectional.only(end: 5),
            child: Text('$itemIndex/${timestamps.length}'),
          ),
          // next
          Padding(
            padding: EdgeInsetsDirectional.only(end: 10),
            child: TextButton(
              onPressed: () async {
                await showNextItems();
                widget.refresh
                    ? (setState(() {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'item_info', arguments: {
                          'controller': widget.ypController,
                          'timeShopItems': widget.video.data?.timeShopItemLists,
                          'model':
                              widget.video.data!.timeShopItemLists![0].model!,
                          'video': widget.video,
                          'profileImgUrl': widget.video.data!.profileImgUrl,
                        });
                      }))
                    : null;
              },
              /* look for items*/
              child: Text('다음 옷 보기'),
            ),
          ),
        ],
      ),
    );
  }

  Future showPreviousItems() async {
    Duration rewind(Duration currentPosition) => timestamps.lastWhere(
        (element) => currentPosition > element + Duration(seconds: 2),
        orElse: (() => Duration.zero));
    print('showpreviousitem ${widget.ypController.metadata.title}');
    await goToPosition(rewind);
  }

  Future showNextItems() async {
    Duration forward(Duration currentPosition) =>
        timestamps.firstWhere((position) => currentPosition < position,
            orElse: (() =>
                widget.ypController.metadata.duration - Duration(seconds: 1)));
    print('shownextitem ${widget.ypController.metadata.title}');

    await goToPosition(forward);
  }

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await widget.ypController.value.position;
    final newPosition = builder(currentPosition);

    widget.ypController.seekTo(newPosition);
    // log("current=$currentPosition, new=$newPosition");
  }
}
