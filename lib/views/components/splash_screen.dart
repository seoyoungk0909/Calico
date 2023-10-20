import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/logo.png',
              //   width: 150,
              //   height: 150,
              // ),
              SizedBox(width: 150, height: 150, child: Text('Calico Logo'))
            ],
          ),
        ),
      ),
    );
  }
}
