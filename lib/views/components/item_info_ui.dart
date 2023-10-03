import 'package:cached_network_image/cached_network_image.dart';
import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

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
            Padding(
              padding: const EdgeInsets.all(8),
              child: CachedNetworkImage(
                  imageUrl: itemElement.item!.itemImgUrl!,
                  width: 75,
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
            ),
            Container(
                width: 170,
                height: 100,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '[${itemElement.item!.brand}] ${itemElement.item!.name}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '${itemElement.item!.color} / ${itemElement.item!.size} 착용',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 96, 96, 96),
                            ),
                          )),
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${NumberFormat('#,###').format(itemElement.item!.shops![0].price)}원',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
                            child: Text(
                              '구매 링크',
                              style: TextStyle(
                                  fontSize: 14,
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

Widget itemHeader(BuildContext context, Model model) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom:
            BorderSide(width: 9.0, color: Color.fromARGB(255, 233, 233, 233)),
      ),
    ),
    padding: const EdgeInsetsDirectional.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Calico 자동 검색 서비스',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            '${model.name} ${model.heightCm?.toStringAsFixed(0)}cm ${model.weightKg?.toStringAsFixed(0)}kg',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
