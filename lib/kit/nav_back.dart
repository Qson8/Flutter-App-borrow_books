import 'package:flutter/material.dart';

typedef NavBackTapCallck = void Function();

class NavBackItem extends StatelessWidget {

  final Color color;
  final NavBackTapCallck onTap;

  NavBackItem({Key key, @required this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 20),
          child: Image.asset('images/nav_back.png', color: this.color),
        ),
        onTap: onTap);
  }
}