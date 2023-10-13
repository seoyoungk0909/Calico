import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'video');
              },
              child: Text('Video'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'shorts_video');
              },
              child: Text('Shorts Video'),
            ),
          ],
        ),
      ),
    );
  }
}
