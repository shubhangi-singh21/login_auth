import 'package:flutter/material.dart';
import 'package:login_page_auth/screens/background_painter.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: CustomPaint(
            painter: BackgroundPainter(),
          ))
        ],
      ),
    );
  }
}
