import 'dart:async';

import 'package:bird/pipeDown.dart';
import 'package:bird/pipeUp.dart';
import 'package:bird/scoreboard.dart';
import 'package:bird/start.dart';
import 'package:flutter/material.dart';

import 'bird.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flappy bird'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double gapSize = 0.7; //上下管道间距
const double initPipeOneX = 0.2;
const double initPipeTwoX = 0.9;
const double pipWidth = 60; //障碍物宽度

class _MyHomePageState extends State<MyHomePage> {
  double birdY = 0;
  double birdYLastTime = 0;
  bool isRunning = false;
  double pipeSize = 200;
  double pipeOneX = initPipeOneX;
  double gapOneCenter = 0.2;
  double gapTwoCenter = 0;
  double pipeTwoX = initPipeTwoX;
  Direction birdDirection = Direction.Down;
  int score = 0; //分数
  double time = 0;

  void initGameState(bool isGameOver) {
    setState(() {
      isRunning = !isGameOver;
      pipeOneX = initPipeOneX;
      pipeTwoX = initPipeTwoX;
      birdY = 0;
      birdYLastTime = 0;
      time = 0;
      score = 0;
    });
  }

  bool checkCrash(double center, pipeX) {
    final double deltaWidth =
        (pipWidth + birdSize) / MediaQuery.of(context).size.width;

    if (pipeX <= birdX + deltaWidth) {
      //是否与管道碰撞
      if ((birdY > (center + gapSize / 2)) ||
          (birdY < (center - gapSize / 2))) {
        return true;
      }
    } else if (birdY >= 1.08) {
      //是否与地面碰撞
      return true;
    }

    return false;
  }

  Timer createTimer() {
    const double g = 9.8;

    return Timer.periodic(Duration(milliseconds: 40), (timer) {
      final double newPipeOneX = pipeOneX - 0.01; //障碍物左移
      final double newPipeTwoX = pipeTwoX - 0.01;
      bool isCrash = false; //初始时，碰撞检测为false

      time += 0.02;
      // -(gt^2) / 2 + vt
      birdY = -(g / 2) * time * time + 1 * time;
      setState(() {
        //小鸟自动下落
        birdY = birdYLastTime - birdY;
      });

      isCrash = checkCrash(gapOneCenter, pipeOneX);
      isCrash |= checkCrash(gapTwoCenter, pipeTwoX);

      if (newPipeOneX <= -1 || newPipeTwoX <= -1) {
        setState(() {
          score += 1;
        });
      }

      if (isCrash == true) {
        //碰到障碍物，游戏结束
        initGameState(true); //回到初始状态

        timer.cancel();
      } else {
        setState(() {
          pipeOneX = newPipeOneX < -1 ? 1.3 : newPipeOneX;
          pipeTwoX = newPipeTwoX < -1 ? 1.3 : newPipeTwoX;
        });
      }
    });
  }

  startGame() {
    initGameState(false);

    createTimer();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 3 / 4; //除去地面后的高度

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: GestureDetector(
          onTap: () {
            setState(() {
              birdYLastTime = birdY;
              time = 0;
            });
          },
          child: Container(
            color: Colors.white, //背景颜色
            child: Stack(
              children: [
                Column(
                  //将页面分为两部分，上面3/4为天空，下1/4为地面
                  children: [
                    Expanded(
                        //障碍物和bird
                        flex: 3,
                        child: Stack(children: [
                          PipeDown(
                              pipeX: pipeOneX,
                              pipeY: -1,
                              pipeSize: maxHeight *
                                  (gapOneCenter - gapSize / 2 + 1) /
                                  2),
                          PipeUp(
                              pipeX: pipeOneX,
                              pipeY: 1,
                              pipeSize: maxHeight *
                                  (1 - (gapOneCenter + gapSize / 2)) /
                                  2),
                          PipeDown(
                              pipeX: pipeTwoX,
                              pipeY: -1,
                              pipeSize: maxHeight *
                                  (gapTwoCenter - gapSize / 2 + 1) /
                                  2),
                          PipeUp(
                              pipeX: pipeTwoX,
                              pipeY: 1,
                              pipeSize: maxHeight *
                                  (1 - (gapTwoCenter + gapSize / 2)) /
                                  2),
                          Bird(
                            birdY: birdY,
                          ),
                        ])),
                    Expanded(
                        //地面和记分板
                        flex: 1,
                        child: ScoreBoard(
                          curScore: score,
                        ))
                  ],
                ),
                if (isRunning == false) //游戏未开始
                  GestureDetector(
                    onTap: () {
                      //点击开始游戏
                      startGame();
                    },
                    child: StartSceen(),
                  )
              ],
            ),
          )),
      backgroundColor: Colors.blue,
    );
  }
}
