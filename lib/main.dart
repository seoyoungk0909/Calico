import 'package:clovi_template/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'views/video_page.dart';
import 'views/item_detail_page.dart';
import 'views/item_info_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.removeAfter(initiailization);

  runApp(const MyApp());
}

Future initiailization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
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
      home: HomePage(),
    );
  }
}
