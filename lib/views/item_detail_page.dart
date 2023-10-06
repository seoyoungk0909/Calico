import 'package:clovi_template/models/item_element_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:clovi_template/models/shops_model.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ItemElement itemElement = arguments['itemElement'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Item Detail Page'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ExtendedImage.network(
              itemElement.item!.itemImgUrl!,
              height: 400,
              width: 800,
              // fit: BoxFit.cover,
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
            const Divider(
              color: Colors.black,
              height: 25,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  itemElement.item!.brand!,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 550,
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                child: Text(
                  itemElement.item!.name!,
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.black),
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 25,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 17.0),
                child: Text(
                  '${NumberFormat('#,### ').format(itemElement.item!.shops![0].price)}원',
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 40,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Container(
              width: 390,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 50, left: 40)),
                      Text(
                        "판매처",
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 250),
                      Text(
                        "가격",
                        style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Column(children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 5, color: Colors.grey.shade300),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () =>
                          launchUrlString('https://www.naver.com/'),
                      child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2, right: 5),
                              child: ExtendedImage.network(
                                itemElement.item!.shops![0].logoUrl!,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Container(
                                width: 255,
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5, bottom: 5),
                                child: Text(
                                  itemElement.item!.brand!,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black),
                                )),
                            Container(
                                width: 80,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        '${NumberFormat('#,### ').format(itemElement.item!.shops![0].price)}원',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black))))
                            // const Padding(padding: EdgeInsets.only(right: 20)),
                          ])),
                    )
                  ]),
                ],
              ),
            ),
          ],
        )));
  }
}
