import 'package:flutter/rendering.dart';
import 'package:login_page_auth/config/palette.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter()
      : bluePaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        seabluePaint = Paint()
          ..color = Palette.seaBlue
          ..style = PaintingStyle.fill,
        yellowPaint = Paint()
          ..color = Palette.yellow
          ..style = PaintingStyle.fill;

  final Paint bluePaint;
  final Paint seabluePaint;
  final Paint yellowPaint;

  @override
  void paint(Canvas canvas, Size size) {
    print('printing');
    paintBlue(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    _addPointsToPath(path, [
      Point(0, 0),
      Point(size.width / 2, size.height / 2),
      Point(size.width, size.height / 2),
    ]);

    canvas.drawPath(path, bluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create path');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    //to connect last 2 points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}
