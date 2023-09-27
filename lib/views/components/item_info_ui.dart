import 'package:flutter/material.dart';
import 'package:clovi_template/models/item_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget videoItemUI(
    BuildContext context, Item item, YoutubePlayerController ypController) {
  Future<void> _launchURL(String url) async {
    Uri uri;
    if (!url.startsWith("https")) {
      url = "https://$url";
    }
    uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Can not launch $url";
    }
  }

  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'item_detail', arguments: {
          'item': item,
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.0, color: Color.fromARGB(255, 233, 233, 233)),
          ),
        ),
        child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  item.imageURL,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Container(
                    width: 150,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('[${item.brand}] ${item.name}'),
                        Text('${item.size} 착용'),
                      ],
                    )),
                Container(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${item.officialPrice}원'),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 111, 0),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _launchURL('www.naver.com');
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '구매 링크',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 111, 0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            )),
      ));
}

Widget allItemUI(
    BuildContext context, Item item, YoutubePlayerController ypController) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'item_detail', arguments: {
          'item': item,
        });
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              item.imageURL,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
                width: 300,
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.brand,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      item.name,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 114, 114, 114),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '${item.officialPrice} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: '원 '),
                            ],
                          ),
                        ))
                  ],
                )),
          ],
        ),
      ));
}

Widget itemHeader(BuildContext context, String modelName) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom:
            BorderSide(width: 1.0, color: Color.fromARGB(255, 233, 233, 233)),
      ),
    ),
    padding: const EdgeInsetsDirectional.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Calico 자동 검색 서비스',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            modelName,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
