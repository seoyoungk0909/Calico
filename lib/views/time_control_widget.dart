import 'dart:developer';

import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TimeControlWidget extends StatefulWidget {
  final YoutubePlayerController ypController;
  final List<Duration> timestamps;

  const TimeControlWidget({
    super.key,
    required this.ypController,
    required this.timestamps,
  });

  @override
  State<TimeControlWidget> createState() => _TimeControlWidgetState();
}

class _TimeControlWidgetState extends State<TimeControlWidget> {
  int itemIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              },
              child: Text('이전 옷 보기'),
            ),
          ),
          // number
          Padding(
            padding: EdgeInsetsDirectional.only(end: 5),
            child: Text('$itemIndex/${widget.timestamps.length}'),
          ),
          // next
          Padding(
            padding: EdgeInsetsDirectional.only(end: 10),
            child: TextButton(
              onPressed: () async {
                await showNextItems();
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
    // itemIndex = (itemIndex == 1) ? 1 : --itemIndex;
    Duration rewind(Duration currentPosition) => widget.timestamps.lastWhere(
        (element) => currentPosition > element + Duration(seconds: 2),
        orElse: (() =>
            widget.ypController.metadata.duration - Duration(seconds: 1)));

    // TimeShopItems rewind(Duration currentPosition) =>
    //     widget.timeShopItemsList.lastWhere(
    //         (element) =>
    //             currentPosition > element.startTime + Duration(seconds: 2),
    //         orElse: (() => widget.timeShopItemsList[0]));

    await goToPosition(rewind);
  }

  Future showNextItems() async {
    // itemIndex = (itemIndex == widget.timestamps.length)
    //     ? widget.timestamps.length
    //     : ++itemIndex;
    Duration forward(Duration currentPosition) =>
        widget.timestamps.firstWhere((position) => currentPosition < position,
            orElse: (() => Duration(days: 1)));

    await goToPosition(forward);
  }

  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await widget.ypController.value.position;
    final newPosition = builder(currentPosition);

    widget.ypController.seekTo(newPosition);
    log("goToPosition");
  }
}
