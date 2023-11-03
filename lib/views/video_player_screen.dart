import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/views/components/splash_screen.dart';
import 'package:clovi_template/views/time_control_widget.dart';
// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  const VideoPlayerScreen({
    super.key,
    required this.video,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // late YoutubePlayerController ypController;
  late YoutubePlayer player;

  // Future<void> initializeController() async {
  //   ypController = YoutubePlayerController(
  //     initialVideoId: widget.video.data!.videoUrl!,
  //     flags: const YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //       disableDragSeek: true,
  //       loop: true,
  //       hideThumbnail: true,
  //     ),
  //   );
  // }

  Future<void> initializePlayer() async {
    player = YoutubePlayer(
      controller: widget.video.ypController!,
      showVideoProgressIndicator: true,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   ypController.dispose();

  //   super.dispose();
  // }

  void directToItemInfoPage(Video video, String dir) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, dir, arguments: {
      // 'controller': video.ypController,
      'controller': widget.video.ypController,
      'timeShopItems': video.data?.timeShopItemLists,
      'model': video.data!.timeShopItemLists![0].model!,
      'video': video,
      'profileImgUrl': video.data!.profileImgUrl,
    });
    widget.video.ypController!.play();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializePlayer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx < 0) {
                      directToItemInfoPage(widget.video, 'item_info');
                    }
                  },
                  child: player,
                ),
              ),
              TimeControlWidget(
                ypController: widget.video.ypController!,
                video: widget.video,
                refresh: false,
              ),
            ],
          );
        } else {
          return splash(context);
        }
      },
    );
  }
}
