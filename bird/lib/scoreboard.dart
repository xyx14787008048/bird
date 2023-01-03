import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {//传入参数为分数，用于显示分数
  final int curScore; //分数
  const ScoreBoard({
    Key? key,
    required this.curScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/land.png"), fit: BoxFit.fill)),
      child: Row(
        //展示当前分数和最高分，两者并列
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, //水平对齐方式
        crossAxisAlignment: CrossAxisAlignment.center, //纵轴对齐方式
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("分数",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(curScore.toString(),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("最高分",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text("128",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          )
        ],
      ),
    );
  }
}
