// import 'package:clovi_template/views/home_page.dart';
import 'package:flutter/material.dart';
import 'views/video_page.dart';
// import 'views/home_page.dart';
import 'views/item_detail_page.dart';
import 'views/item_info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        'video': (context) => VideoPage(),
        'item_info': (context) => ItemInfoPage(),
        'item_detail': (context) => ItemDetailPage()
      },
      home: const VideoPage(),
    );
  }
}
