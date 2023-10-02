import 'package:cached_network_image/cached_network_image.dart';
import 'package:clovi_template/models/item_element_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

Widget videoItemUI(BuildContext context, ItemElement itemElement,
    YoutubePlayerController ypController) {
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
          'itemElement': itemElement,
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
                width: 10.0, color: Color.fromARGB(255, 233, 233, 233)),
            right: BorderSide(
                width: 10.0, color: Color.fromARGB(255, 233, 233, 233)),
            top: BorderSide(
                width: 0.0, color: Color.fromARGB(255, 233, 233, 233)),
            bottom: BorderSide(
                width: 9.0, color: Color.fromARGB(255, 233, 233, 233)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.network(
            //   itemElement.item!.itemImgUrl!,
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            //   errorBuilder: (context, error, stackTrace) {
            //     return Icon(Icons.error);
            //   },
            // ),
            CachedNetworkImage(
                imageUrl: itemElement.item!.itemImgUrl!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Container(
                    color: Colors.black12,
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                }),
            Container(
                width: 150,
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '[${itemElement.item!.brand}] ${itemElement.item!.name}'),
                    Text('${itemElement.item!.size} 착용'),
                  ],
                )),
            Container(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${itemElement.item!.shops![0].price}원'),
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
        ),
      ));
}

Widget itemHeader(BuildContext context, String modelName) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom:
            BorderSide(width: 9.0, color: Color.fromARGB(255, 233, 233, 233)),
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
