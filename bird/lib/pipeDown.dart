import 'package:flutter/material.dart';
import 'package:bird/main.dart';

class PipeDown extends StatelessWidget {
  const PipeDown({
    Key? key,
    required this.pipeX,
    required this.pipeY,
    required this.pipeSize,
  }) : super(key: key);

  final double pipeX;
  final double pipeY;
  final double pipeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(pipeX, pipeY),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/PipeDown.png'),
              fit: BoxFit.fill), //障碍物贴图，使用fill填充方式
        ),
        width: pipWidth,
        height: pipeSize,
      ),
    );
  }
}
