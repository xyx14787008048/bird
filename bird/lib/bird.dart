import 'package:flutter/material.dart';

enum Direction { Up, Down }

const double birdX = -0.9;
const double birdSize = 40;//小鸟大小，后续开发可能会更改以改变难度

class Bird extends StatelessWidget {//传入参数为birdY，小鸟y轴坐标，用于控制小鸟位置
  const Bird({
    Key? key,
    required this.birdY,
  }) : super(key: key);

  final double birdY;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 0),
        alignment: Alignment(birdX, birdY),
        child: Container(
            width: birdSize,
            height: birdSize,
            child: Image.asset("images/bird.gif")));
  }
}
