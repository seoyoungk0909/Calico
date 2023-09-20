import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:clovi_template/models/item_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    Item item = arguments['item'];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Item Detail Page'),
        ),
        body: Column(
          children: [
            Image.network(item.imageURL, height: 400, width: 800),
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
                padding: EdgeInsets.only(left: 17.0),
                child: Text(
                  item.brand,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 19,
                      color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text(
                  item.name,
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
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
                  item.officialPrice.toString() + ' 원',
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
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
                  border: Border.all(color: Colors.grey.shade200)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Row(children: [
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Padding(padding: EdgeInsets.only(left: 40)),
                  Text(
                    "판매처",
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 220),
                  Text("가격",
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800))
                ]),
                TextButton(
                  style: TextButton.styleFrom(
                    side: BorderSide(width: 5, color: Colors.grey.shade300),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => launchUrlString('https://www.naver.com/'),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Padding(padding: EdgeInsets.only(left: 30)),
                          Text(
                            item.brand,
                            style: const TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                color: Colors.black),
                          ),
                          const SizedBox(width: 200),
                          Text(item.officialPrice.toString() + '원',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black))
                        ])
                      ]),
                ),
              ]),
            ),
          ],
        ));
  }
}
