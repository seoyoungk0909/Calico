import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'item_model.dart';

class Video {
  String url = 'https://www.youtube.com/shorts/sArvwOFrXGA';
  String modelName = 'Calico';
  List<TimeShopItems> timeShopItemsList = [];
  List<Duration> timestamps = [];
  late YoutubePlayerController ypController = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(url)!,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
      disableDragSeek: true,
      loop: true,
    ),
  );

  Video({
    String? videoURL,
    String? videoModelName,
    List<TimeShopItems>? videoTimeShopItemsList,
    YoutubePlayerController? videoypController,
    List<Duration>? videoTimestamps,
  }) {
    url = videoURL ?? url;
    modelName = videoModelName ?? modelName;
    timeShopItemsList = videoTimeShopItemsList ?? timeShopItemsList;
    ypController = videoypController ?? ypController;
    timestamps = videoTimestamps ?? timestamps;
  }
}
