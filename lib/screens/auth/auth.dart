import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:login_page_auth/config/palette.dart';
import 'package:login_page_auth/screens/auth/register.dart';
import 'package:login_page_auth/screens/auth/sign_in.dart';
import 'package:login_page_auth/screens/background_painter.dart';
import 'package:login_page_auth/screens/home.dart';

class AuthScreen extends StatefulWidget {
  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );

  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ValueNotifier<bool> showSignInPage = ValueNotifier<bool>(true);

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LitAuth.custom(
        errorNotification: const NotificationConfig(
          backgroundColor: Palette.darkBlue,
          icon: Icon(
            Icons.error_outline,
            color: Colors.orange,
            size: 32,
          ),
        ),
        onAuthSuccess: () {
          Navigator.of(context).pushReplacement(HomeScreen.route);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: BackgroundPainter(
                  animation: _controller.view,
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: ValueListenableBuilder<bool>(
                  valueListenable: showSignInPage,
                  builder: (context, value, child) {
                    return PageTransitionSwitcher(
                      reverse: !value,
                      duration: Duration(milliseconds: 800),
                      transitionBuilder:
                          (child, animation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.vertical,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: value
                          ? SignIn(
                              key: ValueKey('SignIn'),
                              onRegisterClicked: () {
                                context.resetSignInForm();
                                showSignInPage.value = false;
                                _controller.forward();
                              },
                            )
                          : Register(
                              key: ValueKey('Register'),
                              onSignInPressed: () {
                                context.resetSignInForm();
                                showSignInPage.value = true;
                                _controller.reverse();
                              },
                            ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
