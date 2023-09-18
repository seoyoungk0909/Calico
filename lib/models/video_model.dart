import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  String url = 'https://www.youtube.com/shorts/sArvwOFrXGA';
  String modelName = 'Calico';
  List items = [];
  late YoutubePlayerController ypController = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    flags: const YoutubePlayerFlags(
      // autoPlay: true,
      autoPlay: true,
      mute: false,
      disableDragSeek: true,
      loop: true,
    ),
  );

  Video({
    String? videoURL,
    String? videoModelName,
    List? videoItems,
    YoutubePlayerController? videoypController,
  }) {
    url = videoURL ?? url;
    modelName = videoModelName ?? modelName;
    items = videoItems ?? items;
    ypController = videoypController ?? ypController;
  }
}
