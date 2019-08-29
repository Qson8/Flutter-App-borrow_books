import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/view/view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double navBarHeight = 44.0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(navBarHeight),
        child: AppBar(
          title: Text(
            '首页',
            style: TextStyle(
              color: Color(0xfffFFFFFF),
              fontSize: 17,
            ),
          ),
          
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0, // 状态栏海拔
          brightness: Brightness.dark, // 状态栏样式
        ),
        ),
        body: HomeView(),
      ),
    );
  }
}