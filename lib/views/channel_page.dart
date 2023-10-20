import 'package:clovi_template/models/model_model.dart';
import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
// import 'package:clovi_template/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

Widget channelView(String url, Model model) {
  return Column(
    children: [
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: CircleAvatar(
            backgroundImage: ExtendedNetworkImageProvider(url),
            radius: 30,
          ),
        ),
      ),
      Align(
          alignment: Alignment.center,
          child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                '${model.name}',
                style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    color: Colors.black),
              )))
    ],
  );
}

class _ChannelPageState extends State<ChannelPage> {
  List<String> urls = [
    'https://api.clovi.app/api/v1/videos?videoUrl=ovjZC0yeBkg',
    'https://api.clovi.app/api/v1/videos?videoUrl=dMqofHwI1MI',
    'https://api.clovi.app/api/v1/videos?videoUrl=ezNbBuO7_i4',
    'https://api.clovi.app/api/v1/videos?videoUrl=pKdS4ukwB24',
    'https://api.clovi.app/api/v1/videos?videoUrl=hTLdiYdwj5A',
    'https://api.clovi.app/api/v1/videos?videoUrl=a3F9Bf-sb_w',
    'https://api.clovi.app/api/v1/videos?videoUrl=mAfwiwHduxY',
    'https://api.clovi.app/api/v1/videos?videoUrl=sIuxA77B6uk',
    'https://api.clovi.app/api/v1/videos?videoUrl=0-BXWBhhzNk',
    'https://api.clovi.app/api/v1/videos?videoUrl=7U74B9Zee6M',
  ];
  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:api\.|m\.)?clovi\.app\/api\/v1\/videos\?videoUrl=([_\-a-zA-Z0-9]{11}).*$"),
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  String getThumbnail({
    required String videoId,
    String quality = ThumbnailQuality.standard,
    bool webp = true,
  }) =>
      webp
          ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp'
          : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

  Widget printThumbnail(String videoURL, YoutubePlayerController video,
      List<TimeShopItemLists> timeShopItemList, Model model) {
    double screenWidth = MediaQuery.of(context).size.width;
    String? videoId = convertUrlToId(videoURL);
    String thumbnailUrl = getThumbnail(videoId: videoId ?? "");
    // String numViews = getViews(videoId);
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'video', 
          // arguments: {
          //   'controller': video,
          //   'timeShopItems': timeShopItemList[0],
          //   'model': model,
          // }
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              thumbnailUrl,
              height: 230,
              width: screenWidth * 0.33,
              fit: BoxFit.cover,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return null;
                  case LoadState.completed:
                    return null;
                  case LoadState.failed:
                    return const Icon(Icons.error);
                }
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    List<TimeShopItemLists> timeShopItemList = arguments['timeShopItems'];
    Model model = arguments['model'];
    String profileImgUrl = arguments['profileImgUrl'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: const Alignment(-1.3, 0),
              child: Text('${model.name}',
                  style: const TextStyle(color: Colors.black, fontSize: 18)),
            )
          ],
        ),
        leading: const BackButton(color: Colors.black),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate(
                      [channelView(profileImgUrl, model)]))
            ];
          },
          body: Column(
            children: [
              const Material(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 1,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text('영상'),
                    ),
                    Tab(
                      child: Text('소개한 옷'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // 성빈 TODO

                    GridView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: urls.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.54,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (BuildContext context, int i) {
                        return printThumbnail(
                            urls[i], ypController, timeShopItemList, model);
                      },
                    ),

                    // 진욱 TODO
                    Container(
                      child: Text('소개한 옷'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
