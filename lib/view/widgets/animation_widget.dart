import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatelessWidget {
  final String path;
  final String txt;

  AnimationWidget(this.path, this.txt);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Lottie.asset(path)),
        SizedBox(
          height: 10,
        ),
        Text(
          txt,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
