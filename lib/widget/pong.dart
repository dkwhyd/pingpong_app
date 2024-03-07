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
    posX = 0;
    posX = 0;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width! / 4;
        batHeigth = height! / 25;
        return Stack(
          children: [
            const Positioned(
              top: 0,
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
