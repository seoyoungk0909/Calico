import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/provider/item_info_provider.dart';
import 'package:clovi_template/provider/video_controller_provider.dart';
import 'package:clovi_template/views/components/splash_screen.dart';
import 'package:clovi_template/views/time_control_widget.dart';
// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late VideoControllerProvider videoControllerProvider;

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

  @override
  void initState() {
    super.initState();
    videoControllerProvider = VideoControllerProvider();
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
    return Consumer<VideoControllerProvider>(
      builder: (context, videoControllerProvider, child) {
        return Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.velocity.pixelsPerSecond.dx < 0) {
                        directToItemInfoPage(widget.video, 'item_info');
                      }
                    },
                    child: YoutubePlayer(
                      controller: widget.video.ypController!,
                      showVideoProgressIndicator: true,
                      onReady: () {
                        videoControllerProvider.videoReady = true;
                        // if (widget.video.ypController!.value.isPlaying) {
                        //   videoControllerProvider.videoReady = true;
                        //   print("isplaying!");
                        // }
                      },
                    ),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => ItemInfoProvider(),
                  child: TimeControlWidget(
                    ypController: widget.video.ypController!,
                    video: widget.video,
                    onIndexChange: (index) {
                      // print("index changed in video widget = $index");
                      Provider.of<ItemInfoProvider>(context, listen: false)
                          .currentIndex = index;
                    },
                    // refresh: false,
                  ),
                ),
              ],
            ),
            if (!videoControllerProvider.videoReady) splash(context)
          ],
        );
      },
    );
  }
}
