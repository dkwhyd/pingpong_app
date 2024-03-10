import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation!.addListener(() {
      checkBorders();
      setState(() {
        (hDir == Direction.right ? posX += speed : posX -= speed);
        (vDir == Direction.down ? posY += speed : posY -= speed);
      });
    });
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width! / 5;
        batHeigth = height! / 20;
        return Stack(
          children: [
            Positioned(
              top: posY,
              left: posX,
              child: Ball(),
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) =>
                    moveBat(update),
                child: Bat(batWidth, batHeigth),
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
      print('kiri');
    }
    if ((posX >= width! - 50) && (hDir == Direction.right)) {
      hDir = Direction.left;
      print('kanan');
    }
    if (posY >= height! - 50 - batHeigth && vDir == Direction.down) {
      if (posX >= (batPosition - 50) && posX <= (batPosition + batWidth + 50)) {
        vDir = Direction.up;
        print('bawah');
      } else {
        controller!.stop();
        dispose();
        print('game over');
      }
    }

    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      print("atas");
    }
  }

  void moveBat(DragUpdateDetails update) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }
}
