import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'video');
          },
          child: Text('Start'),
        ));
  }
}
