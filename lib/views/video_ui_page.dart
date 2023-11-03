import 'dart:convert';
import 'dart:io';
import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/utils/keys.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideoUIPage extends StatefulWidget {
  final Video video;

  const VideoUIPage({
    super.key,
    required this.video,
  });

  @override
  State<VideoUIPage> createState() => _VideoUIPageState();
}

class _VideoUIPageState extends State<VideoUIPage> {
  final String baseUrl = 'www.googleapis.com';
  String? likeCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLike();
  }

  void directToChannelPage(Video video) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, 'channel', arguments: {
      'controller': video.ypController,
      'timeShopItems': video.data?.timeShopItemLists,
      'model': video.data!.timeShopItemLists![0].model!,
      'profileImgUrl': video.data!.profileImgUrl,
    });
    video.ypController?.play();
  }

  Future<String> fetchVideoLikes(String videoId) async {
    Map<String, String> parameters = {
      'part': 'statistics',
      'id': videoId,
      'key': API_KEY,
    };

    Uri uri = Uri.https(baseUrl, 'youtube/v3/videos', parameters);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      var statistics = jsonMap['items'][0]['statistics'];
      return statistics['likeCount'];
    } else {
      return '';
    }
  }

  initLike() async {
    String likes = await fetchVideoLikes(widget.video.data!.videoUrl!);
    setState(() {
      likeCount = likes;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log('$likeCount');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Padding(
            padding: EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // SizedBox(height: 110),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 5),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        '$likeCount',
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Icon(
                        Icons.bookmark_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
                // 영상 타이틀
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '${widget.video.data!.title}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 10),
                    // 유튜버 아이콘
                    GestureDetector(
                      onTap: () {
                        directToChannelPage(widget.video);
                      },
                      child: CircleAvatar(
                        backgroundImage: ExtendedNetworkImageProvider(
                            widget.video.data!.profileImgUrl!),
                        radius: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    // 채널 타이틀
                    Container(
                      width: 230,
                      child: Text(
                        '${widget.video.data!.creator}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your button's onPressed logic here
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                          // Add additional styling properties for the button
                        ),
                        child: Text('Subscribe'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
