import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget spinKit(TickerProvider vsync) {
  return SpinKitFadingCube(
    color: Colors.pink,
    size: 50.0,
    controller: AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 1200)),
  );
}
