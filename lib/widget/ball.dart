import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({super.key});
  @override
  Widget build(BuildContext context) {
    const double diameter = 50;

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: Colors.amber[400],
        shape: BoxShape.circle,
      ),
    );
  }
}
