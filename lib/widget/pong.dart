import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingpong/widget/ball.dart';
import 'package:pingpong/widget/bat.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  Random randomPos = Random();
  double? width;
  double? height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeigth = 0;
  double batPosition = 0;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  double speed = 5;

  int score = 0;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation!.addListener(() {
      setState(() {
        (hDir == Direction.right ? posX += speed : posX -= speed);
        (vDir == Direction.down ? posY += speed : posY -= speed);
      });

      checkBorders();
    });
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight - 100;
        width = constraints.maxWidth;
        batWidth = width! / 4;
        batHeigth = height! / 25;
        return Stack(
          children: [
            Positioned(
              top: 0,
              right: 1,
              child: Column(
                children: [
                  const Text('Score :'),
                  Text(score.toString())
                ],
              ),
            ),
            Positioned(
              top: posY,
              left: posX,
              child: const Ball(),
            ),
            Positioned(
              bottom: 100,
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) =>
                    moveBat(update),
                child: Bat(batWidth, batHeigth),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Text('Level : '),
                    ElevatedButton(
                        onPressed: () {
                          decrementSpeed();
                        },
                        child: const Text('-')),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(speed.toString()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        incrementSpeed();
                      },
                      child: const Text('+'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        restartPingpong();
                      },
                      child: const Text('restart'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if ((posX >= width! - 50) && (hDir == Direction.right)) {
      hDir = Direction.left;
    }
    if (posY >= height! - 50 - batHeigth && vDir == Direction.down) {
      if (posX >= (batPosition - 50) && posX <= (batPosition + batWidth + 50)) {
        vDir = Direction.up;
        setState(() {
          score += 1;
        });
      } else {
        resetScore();
        controller!.stop();
        gameOver(context);
        // dispose();
      }
    }

    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  void moveBat(DragUpdateDetails update) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }

  void safeSetState(Function function) {
    if (mounted && controller!.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void incrementSpeed() {
    setState(() {
      speed += 5;
    });
  }

  void decrementSpeed() {
    if (speed > 5) {
      setState(() {
        speed -= 5;
      });
    }
  }

  void resetScore() {
    setState(() {
      score = 0;
    });
  }

  void restartPingpong() {
    controller!.forward();
    setState(() {
      posX = 0;
      posY = 0;
      speed = 5;
    });
  }

  void gameOver(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text('Game Over'),
            ),
            content: SizedBox(
              height: 40,
              child: Column(
                children: [
                  Text('Score :$score'),
                  const Text('High score: '),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                    onPressed: () =>
                        {Navigator.of(context).pop(), restartPingpong()},
                    child: const Text('Restart')),
              )
            ],
          );
        });
  }
}
