import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShortsVideoPage extends StatefulWidget {
  const ShortsVideoPage({super.key});

  @override
  State<ShortsVideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<ShortsVideoPage> {
  List<String> urls = [
    'q74Jvtn8Wgo',
    'uQufPwYQbns',
    '15HbNrxz3-M',
    'ZF6oM4B5ZD4',
    '49V5aWetW2M',
    'lQafF7leeiw',
    'AoNaaiJhjqc',
    '1zZuCWra-mI',
    'rUIc7wkWPUI',
    '6jFqD12-6wI',
    'hHx4Qx6pi6Y',
    'fQ-n1rK0Vn8',
    '9uNwio1UwvM',
  ];

  List<YoutubePlayer> videos = [];

  void getVideos(List<String> urls) {
    for (String url in urls) {
      videos.add(video(url));
    }
  }

  YoutubePlayer video(String url) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: true,
          loop: true,
          hideThumbnail: true,
        ),
      ),
      showVideoProgressIndicator: true,
    );
  }

  @override
  void initState() {
    super.initState();
    getVideos(urls);
  }

  bool shouldRefresh = false;
  void refreshWidget() {
    setState(() {
      shouldRefresh = !shouldRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreloadPageView.builder(
      scrollDirection: Axis.vertical,
      preloadPagesCount: videos.length,
      itemBuilder: (context, index) {
        return video(urls[index % videos.length]);
      },
      controller: PreloadPageController(initialPage: 0),
      onPageChanged: (value) {
        // setState(
        //   () {
        //     // snapshot.data![value].ypController!.play();
        //   },
        // );
        videos[value % videos.length].controller.play();
        // currentIndex = value;
      },
    );
  }
}
