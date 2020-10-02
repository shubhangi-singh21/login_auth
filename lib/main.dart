import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:login_page_auth/config/palette.dart';
import 'package:login_page_auth/main.dart';
import 'package:login_page_auth/screens/auth/auth.dart';
import 'package:login_page_auth/screens/home.dart';
import 'package:login_page_auth/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.muliTextTheme(),
          accentColor: Palette.yellow,
          appBarTheme: const AppBarTheme(
            brightness: Brightness.dark,
            color: Palette.darkBlue,
          ),
        ),
        //home: LitAuthState(
        //authenticated: HomeScreen(), unauthenticated: AuthScreen(),),
        home: SplashScreen(),
      ),
    );
  }
}
