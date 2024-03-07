import 'package:flutter/material.dart';
import 'package:pingpong/widget/ball.dart';
import 'package:pingpong/widget/bat.dart';

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Positioned(
              child: Ball(),
              top: 0,
            ),
            Positioned(
              child: Bat(200, 25),
              bottom: 0,
            )
          ],
        );
      },
    );
  }
}
