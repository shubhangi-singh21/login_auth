import 'package:flutter/material.dart';
import 'package:login_page_auth/main.dart';
import 'package:login_page_auth/screens/auth/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Material App Bar'),
          ),
          body: AuthScreen()),
    );
  }
}
