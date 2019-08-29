import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:borrow_books/page/page.dart';

//加载页面
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    //在加载页面停顿2秒
    new Future.delayed(Duration(seconds: 2), () {
      _getHasSkip();
    });
  }

  void _getHasSkip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSkip = prefs.getBool("hasSkip");
    if (hasSkip == null || !hasSkip) {
      Navigator.of(context).pushReplacementNamed("splash");
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => Home()),
          (route) => route == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: new Center(
        child: Container(
          child: Stack(
            children: <Widget>[
              //加载页面居中背景图 使用cover模式
              SizedBox(
                width:100,
                height: 100,
                child: Image.asset(
                  "images/login_icon.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
