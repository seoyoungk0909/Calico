import 'package:flutter/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.ypController});

  final YoutubePlayerController ypController;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return YoutubePlayer(
      controller: widget.ypController,
      showVideoProgressIndicator: true,
      onReady: () {
        widget.ypController.play();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
