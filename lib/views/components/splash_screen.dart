import 'package:clovi_template/views/survey_page.dart';
import 'package:flutter/material.dart';
// import 'package:clovi_template/views/home_page.dart';
import 'package:flutter_svg/svg.dart';

Widget splash(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset('assets/icons/logo.svg')),
          ],
        ),
      ),
    ),
  );
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wait for 2.5 second and then navigate to HomePage()
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SurveyPage()),
      );
    });

    return splash(context);
  }
}
