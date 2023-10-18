import 'package:clovi_template/models/model_model.dart';
import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({super.key});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

Widget channelView(String url) {
  return Column(
    children: [
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: CircleAvatar(
            backgroundImage: ExtendedNetworkImageProvider(url),
            radius: 16,
          ),
        ),
      ),
    ],
  );
}

class _ChannelPageState extends State<ChannelPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    List<TimeShopItemLists> timeShopItemList = arguments['timeShopItems'];
    Model model = arguments['model'];
    String profileImgUrl = arguments['profileImgUrl'];

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverList(
                  delegate:
                      SliverChildListDelegate([channelView(profileImgUrl)]))
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
                    Container(
                      child: Text('영상'),
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
