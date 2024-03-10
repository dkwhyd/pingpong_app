import 'package:flutter/material.dart';
import 'package:pingpong/widget/pong.dart';

class HomeScreenPingpong extends StatelessWidget {
  const HomeScreenPingpong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pingpong'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body:   const SafeArea(
        child: Pong(),
      ),
    );
  }
}
