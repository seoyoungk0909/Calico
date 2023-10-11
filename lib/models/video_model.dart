import 'package:clovi_template/models/data_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video {
  int? status;
  String? processStatus;
  String? message;
  String? code;
  Data? data;
  YoutubePlayerController? ypController;

  Video({
    this.status,
    this.processStatus,
    this.message,
    this.code,
    this.data,
    this.ypController,
  });

  Video.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    processStatus = json['processStatus'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    ypController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(data!.videoUrl!)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: true,
        loop: true,
        hideThumbnail: true,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['processStatus'] = processStatus;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


// import 'package:clovi_template/models/time_shop_items_model.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class Video {
//   String url = 'https://www.youtube.com/shorts/sArvwOFrXGA';
//   String modelName = 'Calico';
//   List<TimeShopItems> timeShopItemsList = [];
//   List<Duration> timestamps = [];
//   late YoutubePlayerController ypController = YoutubePlayerController(
//     initialVideoId: YoutubePlayer.convertUrlToId(url)!,
//     flags: const YoutubePlayerFlags(
//       autoPlay: true,
//       mute: false,
//       disableDragSeek: true,
//       loop: true,
//     ),
//   );

//   Video({
//     String? videoURL,
//     String? videoModelName,
//     List<TimeShopItems>? videoTimeShopItemsList,
//     YoutubePlayerController? videoypController,
//     List<Duration>? videoTimestamps,
//   }) {
//     url = videoURL ?? url;
//     modelName = videoModelName ?? modelName;
//     timeShopItemsList = videoTimeShopItemsList ?? timeShopItemsList;
//     ypController = videoypController ?? ypController;
//     timestamps = videoTimestamps ?? timestamps;
//   }
// }

// import 'package:clovi_template/models/data_model.dart';

// class Video {
//   int status;
//   String processStatus;
//   String message;
//   String code;
//   Data data;
//   // YoutubePlayerController ypController;

//   Video({
//     required this.status,
//     required this.processStatus,
//     required this.message,
//     required this.code,
//     required this.data,
//     // required this.ypController,
//   });

//   factory Video.fromJson(Map<String, dynamic> json) {
//     return Video(
//       status: json["status"],
//       processStatus: json["processStatus"],
//       message: json["message"],
//       code: json["code"],
//       data: json["data"],
//       // ypController: YoutubePlayerController(
//       //   initialVideoId: YoutubePlayer.convertUrlToId(data.videoUrl)!,
//       //   flags: const YoutubePlayerFlags(
//       //     autoPlay: true,
//       //     mute: false,
//       //     disableDragSeek: true,
//       //     loop: true,
//       //   ),
//       // ),
//     );
//   }
// }