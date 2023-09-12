import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // YoutubePlayerController? ypController;
  // String? videoURL;
  // List<Widget> videos = [];
  List<YoutubePlayerController> ypControllers = [];
  List<String> videoURLs = [
    'https://www.youtube.com/shorts/2YQloQR2Cd8',
    'https://www.youtube.com/shorts/ULx6VJC2cEo',
    'https://www.youtube.com/shorts/BtBkz9qek0M'
  ];
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();

    for (String url in videoURLs) {
      String? videoId = YoutubePlayer.convertUrlToId(url);
      ypControllers.add(YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: true,
          loop: true,
        ),
      ));
    }
  }

  Widget video(YoutubePlayerController ypController) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          // ypController!.pause();
          Navigator.pushNamed(context, 'item_info',
              arguments: {'controller': ypController});
        }
      },
      child: YoutubePlayer(
        controller: ypController,
        showVideoProgressIndicator: true,
        // onEnded: (metaData) async {
        //   log("hi");
        //   ypController!.seekTo(Duration.zero);
        //   setState(() {
        //     ypController!.play();
        //   });
        // },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        itemBuilder: (context, index) {
          return video(ypControllers[index]);
        },
        itemCount: videoURLs.length,
        scrollDirection: Axis.vertical,
      ),
      // body: swiper(),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Video Page"),
    //   ),
    //   body: Column(
    //     children: [
    //       GestureDetector(
    //         onHorizontalDragEnd: (details) {
    //           if (details.velocity.pixelsPerSecond.dx < 0) {
    //             Navigator.pushNamed(context, 'item_info');
    //           }
    //         },
    //       ),
    //       Expanded(
    //         child: YoutubePlayer(
    //           controller: ypController!, // 변수가 null을 절대 가지지 않는 경우
    //           showVideoProgressIndicator: true,
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    //   return YoutubePlayerBuilder(
    //     player: YoutubePlayer(
    //       controller: ypController!,
    //       showVideoProgressIndicator: true,
    //     ),
    //     builder: (context, player) {
    //       return Scaffold(
    //         // appBar: AppBar(
    //         //   title: Text("Video Page"),
    //         // ),
    //         body: Column(
    //           children: [
    //             Expanded(child: player),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // )
  }
}
