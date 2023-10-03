import 'dart:convert';

import 'package:clovi_template/models/video_model.dart';
// import 'package:clovi_template/services/remote_service.dart';
import 'package:clovi_template/views/time_control_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Future<Video> getVideoApi() async {
    var uri =
        Uri.parse('https://api.clovi.app/api/v1/videos?videoUrl=ovjZC0yeBkg');
    final response = await http.get(uri);

    // var data = jsonDecode(response.body.toString());
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return Video.fromJson(data);
    } else {
      return Video.fromJson(data);
    }
  }

  int currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  // }

  void directToItemInfoPage(Video video) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, 'item_info', arguments: {
      'controller': video.ypController,
      'timeShopItems': video.data?.timeShopItemLists,
      'model': video.data!.timeShopItemLists![0].model!,
    });
    video.ypController?.play();
  }

  Widget videoWidget(Video video) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          directToItemInfoPage(video);
        }
      },
      child: YoutubePlayer(
        controller: video.ypController!,
        showVideoProgressIndicator: true,
      ),
    );
  }

  bool shouldRefresh = false;
  void refreshWidget() {
    setState(() {
      shouldRefresh = !shouldRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Video>(
        future: getVideoApi(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Swiper(
                    itemBuilder: (context, index) {
                      return videoWidget(snapshot.data!);
                    },
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    onIndexChanged: (index) => {
                      setState(
                        () {
                          currentIndex = index;
                          refreshWidget();
                        },
                      )
                    },
                  ),
                ),
                TimeControlWidget(
                  ypController: snapshot.data!.ypController!,
                  video: snapshot.data!,
                  key: UniqueKey(),
                )
              ],
            );
          } else {
            return Text("Loading..");
          }
        },
      ),
    );
  }
}



// temporary items
// Item item1 = Item(
//   itemName: 'knit',
//   itemBrand: 'Zara',
//   itemSize: 'M',
//   itemImageURL:
//       'https://static.zara.net/photos///2023/I/0/2/p/2621/406/700/2/w/1126/2621406700_6_1_1.jpg?ts=1688039025940',
//   itemOfficialPrice: 100000,
// );
// Item item2 = Item(
//   itemName: 'jeans',
//   itemBrand: 'Zara',
//   itemSize: 'M',
//   itemImageURL:
//       'https://static.zara.net/photos///2023/I/0/2/p/8062/405/406/2/w/1126/8062405406_6_1_1.jpg?ts=1688122815082',
//   itemOfficialPrice: 80000,
// );
// Item item3 = Item(
//   itemName: 'jacket',
//   itemBrand: 'AMI',
//   itemSize: '95',
//   itemImageURL:
//       'https://image.msscdn.net/images/goods_img/20200305/1337097/1337097_16941460640029_500.jpg',
//   itemOfficialPrice: 260000,
// );
// Item item4 = Item(
//   itemName: 'pants',
//   itemBrand: 'MUSINSA',
//   itemSize: 'L',
//   itemImageURL:
//       'https://image.msscdn.net/images/goods_img/20190201/947201/947201_3_500.jpg',
//   itemOfficialPrice: 70000,
// );

// late TimeShopItems tsi1 = TimeShopItems(
//   itemsItems: [item1],
//   itemsStartTime: Duration(seconds: 0),
// );

// late TimeShopItems tsi2 = TimeShopItems(
//   itemsItems: [item2],
//   itemsStartTime: Duration(seconds: 10),
// );

// late TimeShopItems tsi3 = TimeShopItems(
//   itemsItems: [item3],
//   itemsStartTime: Duration(seconds: 0),
// );

// late TimeShopItems tsi4 = TimeShopItems(
//   itemsItems: [item4],
//   itemsStartTime: Duration(seconds: 13),
// );

// late Video video1 = Video(
//   videoURL: 'https://www.youtube.com/shorts/2YQloQR2Cd8',
//   videoModelName: 'Whu.s',
//   videoTimeShopItemsList: [tsi1, tsi2],
//   videoTimestamps: [tsi1.startTime, tsi2.startTime],
// );

// late Video video2 = Video(
//   videoURL: 'https://www.youtube.com/shorts/BtBkz9qek0M',
//   videoModelName: 'Whu.s',
//   videoTimeShopItemsList: [tsi3, tsi4],
//   videoTimestamps: [tsi3.startTime, tsi4.startTime],
// );

// late Video video3 = Video(
//   videoURL: 'https://www.youtube.com/shorts/49V5aWetW2M',
//   videoModelName: 'Whu.s',
//   videoTimeShopItemsList: [tsi1, tsi2],
//   videoTimestamps: [tsi1.startTime, tsi2.startTime],
// );

// late List<Video> videos = [video1, video2, video3];
