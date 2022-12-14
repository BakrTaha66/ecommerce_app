import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWidget extends StatelessWidget {
  final String path;

  AnimationWidget(this.path);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(path);
  }
}
