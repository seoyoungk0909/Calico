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
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 250,
                expandedHeight: 250,
                flexibleSpace: channelView(profileImgUrl),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  const TabBar(
                    tabs: [
                      Tab(
                        text: '영상',
                      ),
                      Tab(
                        text: '소개한 옷',
                      ),
                    ],
                    indicatorColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                  ),
                ),
                floating: true,
                pinned: true,
              )
            ];
          },
          body: TabBarView(
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
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabbar;

  MyDelegate(this.tabbar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return tabbar;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => tabbar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => tabbar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
