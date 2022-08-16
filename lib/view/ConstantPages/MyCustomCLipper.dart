
import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 10);
    path.cubicTo(size.width / 2, size.height / 4 , size.width / 2, size.height - 10,
        size.width, size.height - 10);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
