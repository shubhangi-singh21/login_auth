import 'package:flutter/rendering.dart';
import 'package:login_page_auth/config/palette.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawPaint(Paint()..color = Palette.darkBlue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
