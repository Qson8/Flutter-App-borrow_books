import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/view/view.dart';

class MePage extends StatefulWidget {
  final key = GlobalKey<_MePageState>();

  MePage({Key key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  void updateSate() {
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    var navBarHeight = 44.0;
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(navBarHeight),
          child: AppBar(
            title: Text(
              '我的',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0, // 状态栏海拔
            brightness: Brightness.dark, // 状态栏样式
          ),
        ),
        body: MeViewWidget(),
      ),
    );
  }
}
