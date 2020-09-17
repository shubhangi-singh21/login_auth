import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:login_page_auth/config/palette.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : bluePaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        seabluePaint = Paint()
          ..color = Palette.seaBlue
          ..style = PaintingStyle.fill,
        yellowPaint = Paint()
          ..color = Palette.yellow
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        yellowAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        seablueAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> seablueAnim;
  final Animation<double> yellowAnim;

  final Paint bluePaint;
  final Paint seabluePaint;
  final Paint yellowPaint;

  @override
  void paint(Canvas canvas, Size size) {
    print('printing');
    paintBlue(canvas, size);
    paintSeaBlue(canvas, size);
    paintYellow(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, blueAnim.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, blueAnim.value),
        lerpDouble(0, size.height, blueAnim.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
      ),
    ]);
    canvas.drawPath(path, bluePaint);
  }

  void paintSeaBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(size.height / 4, size.height / 2, seablueAnim.value),
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, seablueAnim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.width / 5, size.height / 4, seablueAnim.value),
        ),
      ],
    );

    canvas.drawPath(path, seabluePaint);
  }

  void paintYellow(Canvas canvas, Size size) {
    if (yellowAnim.value > 0) {
      final path = Path();
      path.moveTo(size.width * 3 / 4, 0);
      path.lineTo(0, 0);
      path.lineTo(
        0,
        lerpDouble(0, size.height / 12, yellowAnim.value),
      );
      _addPointsToPath(path, [
        Point(
          size.width / 7,
          lerpDouble(0, size.height / 6, liquidAnim.value),
        ),
        Point(
          size.width / 3 * 2,
          lerpDouble(0, size.height / 8, liquidAnim.value),
        ),
        Point(
          size.width / 3 * 4,
          0,
        ),
      ]);

      canvas.drawPath(path, yellowPaint);
    }
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

//custom curve to give gooey spring effect
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });

  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return ((-pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
