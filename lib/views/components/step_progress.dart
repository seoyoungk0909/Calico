import 'package:clovi_template/utils/color_utils.dart';
import 'package:flutter/material.dart';

class StepProgress extends StatefulWidget {
  final double currentStep;
  final double steps;

  StepProgress({Key? key, required this.currentStep, required this.steps})
      : super(key: key);

  @override
  _StepProgressState createState() => _StepProgressState();
}

class _StepProgressState extends State<StepProgress> {
  double widthProgress = 0;

  @override
  void initState() {
    _onSizeWidget();
    super.initState();
  }

  void _onSizeWidget() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (context.size is Size) {
        Size size = context.size!;
        widthProgress = size.width / (widget.steps - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: 4,
          width: screenWidth,
          margin: EdgeInsets.symmetric(vertical: 1),
          child: Stack(
            children: [
              AnimatedContainer(
                width: widthProgress * widget.currentStep,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    color: CalicoColors.representOrange,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(128, 217, 217, 217),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        )
      ],
    );
  }
}
