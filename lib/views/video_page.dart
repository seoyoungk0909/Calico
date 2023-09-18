import 'package:clovi_template/models/item_model.dart';
import 'package:clovi_template/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // temporary items
  Item item1 = Item(
    itemName: 'knit',
    itemBrand: 'Zara',
    itemSize: 'M',
    itemImageURL:
        'https://static.zara.net/photos///2023/I/0/2/p/2621/406/700/2/w/1126/2621406700_6_1_1.jpg?ts=1688039025940',
    itemOfficialPrice: 100000,
    itemTime: 5,
  );
  Item item2 = Item(
    itemName: 'jeans',
    itemBrand: 'Zara',
    itemSize: 'M',
    itemImageURL:
        'https://static.zara.net/photos///2023/I/0/2/p/8062/405/406/2/w/1126/8062405406_6_1_1.jpg?ts=1688122815082',
    itemOfficialPrice: 80000,
    itemTime: 20,
  );
  Item item3 = Item(
    itemName: 'jacket',
    itemBrand: 'AMI',
    itemSize: '95',
    itemImageURL:
        'https://image.msscdn.net/images/goods_img/20200305/1337097/1337097_16941460640029_500.jpg',
    itemOfficialPrice: 260000,
    itemTime: 3,
  );
  Item item4 = Item(
    itemName: 'pants',
    itemBrand: 'MUSINSA',
    itemSize: 'L',
    itemImageURL:
        'https://image.msscdn.net/images/goods_img/20200305/1337097/1337097_16941460640029_500.jpg',
    itemOfficialPrice: 70000,
    itemTime: 10,
  );

  late Video video1 = Video(
    videoURL: 'https://www.youtube.com/shorts/2YQloQR2Cd8',
    videoModelName: 'Whu.s',
    videoItems: [item1, item2],
  );
  late Video video2 = Video(
    videoURL: 'https://www.youtube.com/shorts/BtBkz9qek0M',
    videoModelName: 'Whu.s',
    videoItems: [item3, item4],
  );

  late List<Video> videos = [video1, video2];

  Widget video(Video video) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          // ypController!.pause();
          Navigator.pushNamed(context, 'item_info',
              arguments: {'controller': video.ypController});
        }
      },
      child: YoutubePlayer(
        controller: video.ypController,
        showVideoProgressIndicator: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Swiper(
      //   itemBuilder: (context, index) {
      //     return video(ypControllers[index]);
      //   },
      //   itemCount: videoURLs.length,
      //   scrollDirection: Axis.vertical,
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Swiper(
              itemBuilder: (context, index) {
                return video(videos[index]);
              },
              itemCount: videos.length,
              scrollDirection: Axis.vertical,
            ),
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // previous
          //     Padding(
          //       padding: EdgeInsetsDirectional.only(end: 5),
          //       child: TextButton(
          //         onPressed: null,
          //         child: Text('이전 옷 보기'),
          //       ),
          //     ),
          //     // number
          //     Padding(
          //       padding: EdgeInsetsDirectional.only(end: 5),
          //       child: Text('1/7'),
          //     ),
          //     // next
          //     Padding(
          //       padding: EdgeInsetsDirectional.only(end: 5),
          //       child: TextButton(
          //         onPressed: null,
          //         child: Text('다음 옷 보기'),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
