import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pingpong/widget/ball.dart';
import 'package:pingpong/widget/bat.dart';

class Pong extends StatefulWidget {
  const Pong({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  double? width;
  double? height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeigth = 0;
  double batPosition = 0;

  @override
  void initState() {
    super.initState();

    posX = 0;
    posX = 0;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 1),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation!.addListener(() {
      setState(() {
        posX++;
        posY++;
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
              child: Bat(batWidth, batHeigth),
            ),
          ],
        );
      },
    );
  }
}
