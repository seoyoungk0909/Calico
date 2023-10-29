import 'package:clovi_template/utils/color_utils.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final PageController pageController;

  const BottomButtons({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              pageController.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_back,
                color: CalicoColors.representWhite,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: CalicoColors.representOrange,
                elevation: 0,
                shadowColor: Colors.transparent,
                onPrimary: CalicoColors.representOrange,
                shape: CircleBorder())),
        ElevatedButton(
            onPressed: () {
              pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Container(
              height: 30,
              width: 30,
              child: Icon(
                Icons.arrow_forward,
                color: CalicoColors.representWhite,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: CalicoColors.representOrange,
                elevation: 0,
                shadowColor: Colors.transparent,
                onPrimary: CalicoColors.representOrange,
                shape: CircleBorder())),
      ],
    ));
  }
}
