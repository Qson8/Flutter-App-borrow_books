import 'package:flutter/material.dart';
import 'package:borrow_books/page/page.dart';
import 'package:borrow_books/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color.fromRGBO(0, 169, 80, 1.0),
      ),
      
      home: LoadingPage(),
      routes: <String, WidgetBuilder>{
        "app": (BuildContext context) => new Home(),
        "splash": (BuildContext context) => new SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
