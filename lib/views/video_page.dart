import 'package:clovi_template/controllers/video_controller.dart';
import 'package:clovi_template/models/item_model.dart';
import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/views/time_control_widget.dart';
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
  );
  Item item2 = Item(
    itemName: 'jeans',
    itemBrand: 'Zara',
    itemSize: 'M',
    itemImageURL:
        'https://static.zara.net/photos///2023/I/0/2/p/8062/405/406/2/w/1126/8062405406_6_1_1.jpg?ts=1688122815082',
    itemOfficialPrice: 80000,
  );
  Item item22 = Item(
    itemName: 'shirt',
    itemBrand: 'Zara',
    itemSize: 'M',
    itemImageURL:
        'https://static.zara.net/photos///2023/I/0/2/p/7380/306/104/2/w/1126/7380306104_6_1_1.jpg?ts=1689087350804',
    itemOfficialPrice: 59900,
  );
  Item item3 = Item(
    itemName: 'jacket',
    itemBrand: 'AMI',
    itemSize: '95',
    itemImageURL:
        'https://image.msscdn.net/images/goods_img/20200305/1337097/1337097_16941460640029_500.jpg',
    itemOfficialPrice: 260000,
  );
  Item item4 = Item(
    itemName: 'pants',
    itemBrand: 'MUSINSA',
    itemSize: 'L',
    itemImageURL:
        'https://image.msscdn.net/images/goods_img/20190201/947201/947201_3_500.jpg',
    itemOfficialPrice: 70000,
  );
  Item item44 = Item(
    itemName: 'cap',
    itemBrand: 'MUSINSA',
    itemSize: 'L',
    itemImageURL:
        'https://image.msscdn.net/images/goods_img/20180314/734900/734900_5_500.jpg',
    itemOfficialPrice: 19900,
  );

  late TimeShopItems tsi1 = TimeShopItems(
    itemsItems: [item1],
    itemsStartTime: Duration(seconds: 0),
  );

  late TimeShopItems tsi2 = TimeShopItems(
    itemsItems: [item2],
    itemsStartTime: Duration(seconds: 10),
  );

  late TimeShopItems tsi22 = TimeShopItems(
    itemsItems: [item22],
    itemsStartTime: Duration(seconds: 20),
  );

  late TimeShopItems tsi3 = TimeShopItems(
    itemsItems: [item3],
    itemsStartTime: Duration(seconds: 0),
  );

  late TimeShopItems tsi4 = TimeShopItems(
    itemsItems: [item4],
    itemsStartTime: Duration(seconds: 13),
  );

  late TimeShopItems tsi44 = TimeShopItems(
    itemsItems: [item44],
    itemsStartTime: Duration(seconds: 23),
  );

  late Video video1 = Video(
    videoURL: 'https://www.youtube.com/shorts/2YQloQR2Cd8',
    videoModelName: 'Whu.s',
    videoTimeShopItemsList: [tsi1, tsi2, tsi22],
    videoTimestamps: [tsi1.startTime, tsi2.startTime, tsi22.startTime],
  );

  late Video video2 = Video(
    videoURL: 'https://www.youtube.com/shorts/BtBkz9qek0M',
    videoModelName: 'Whu.s',
    videoTimeShopItemsList: [tsi3, tsi4, tsi44],
    videoTimestamps: [tsi3.startTime, tsi4.startTime, tsi44.startTime],
  );

  late List<Video> videos = [video1, video2];

  int currentIndex = 0;

  void directToItemInfoPage(Video video) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, 'item_info', arguments: {
      'controller': video.ypController,
      'timeShopItems': video.timeShopItemsList,
      'modelName': video.modelName,
    });
    video.ypController.play();
  }

  Widget video(Video video) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          directToItemInfoPage(video);
          // video.ypController.pause();
          // Navigator.pushNamed(context, 'item_info', arguments: {
          //   'controller': video.ypController,
          //   'items': video.items,
          //   'modelName': video.modelName,
          // });
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
    // int i = 0;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Swiper(
              itemBuilder: (context, index) {
                // i = index;
                return video(videos[index]);
              },
              itemCount: videos.length,
              scrollDirection: Axis.vertical,
              onIndexChanged: (index) => {
                setState(
                  () {
                    currentIndex = index;
                  },
                )
              },
            ),
          ),
          TimeControlWidget(
              ypController: videos[currentIndex].ypController,
              timestamps: videos[currentIndex].timestamps)
        ],
      ),
    );
  }
}
