import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/video_model.dart';

class TimeControlWidget extends StatefulWidget {
  final YoutubePlayerController ypController;
  final Video video;

  const TimeControlWidget({
    super.key,
    required this.ypController,
    required this.video,
  });

  @override
  State<TimeControlWidget> createState() => _TimeControlWidgetState();
}

class _TimeControlWidgetState extends State<TimeControlWidget> {
  int itemIndex = 1;

  @override
  void initState() {
    super.initState();
    // Add listener to track current position of the video
    widget.ypController.addListener(updateItemIndex);
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    widget.ypController.removeListener(updateItemIndex);
    super.dispose();
  }

  void updateItemIndex() async {
    final currentPosition = widget.ypController.value.position;
    final timestamps = widget.video.timestamps;

    int newIndex = 1;
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
            child: Text('$itemIndex/${widget.video.timestamps.length}'),
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

    Duration rewind(Duration currentPosition) =>
        widget.video.timestamps.lastWhere(
            (element) => currentPosition > element + Duration(seconds: 2),
            orElse: (() => Duration.zero));
    await goToPosition(rewind);
  }

  Future showNextItems() async {
    // itemIndex = (itemIndex == widget.timestamps.length)
    //     ? widget.timestamps.length
    //     : ++itemIndex;

    Duration forward(Duration currentPosition) => widget.video.timestamps
        .firstWhere((position) => currentPosition < position,
            orElse: (() =>
                widget.ypController.metadata.duration - Duration(seconds: 1)));

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
