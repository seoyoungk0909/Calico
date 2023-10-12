import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:extended_image/extended_image.dart';
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
      // throw "Can not launch $url";
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Cannot launch $url'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
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
            top: BorderSide(
                width: 1.0, color: Color.fromARGB(255, 233, 233, 233)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ExtendedImage.network(
                itemElement.item!.itemImgUrl!,
                width: 75,
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
                            _launchURL(itemElement.item!.shops![0].shopUrl!);
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

Widget allItemUI(BuildContext context, ItemElement itemElement,
    YoutubePlayerController ypController) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'item_detail', arguments: {
          'itemElement': itemElement,
        });
      },
      child: Container(
        margin: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              itemElement.item!.itemImgUrl!,
              height: 220,
              width: 180,
              fit: BoxFit.cover,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return null;
                  case LoadState.completed:
                    return null;
                  case LoadState.failed:
                    return Container(
                        height: 220,
                        width: 180,
                        color: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'item_detail',
                                  arguments: {
                                    'itemElement': itemElement,
                                  });
                            },
                            icon: const Icon(Icons.error, size: 20)));
                }
              },
            ),
            Container(
                width: 180,
                height: 100,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${itemElement.item!.brand}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${itemElement.item!.name}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 114, 114, 114),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: NumberFormat('#,###')
                                  .format(itemElement.item!.shops![0].price),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const TextSpan(text: '원'),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ));
}

Widget itemHeader(BuildContext context, Model model) {
  return Container(
    decoration: const BoxDecoration(),
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
