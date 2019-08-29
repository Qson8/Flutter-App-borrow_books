import 'package:borrow_books/kit/nav_back.dart';
import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';

class MeAboutPage extends StatefulWidget {
  @override
  _MeAboutPageState createState() => _MeAboutPageState();
}

class _MeAboutPageState extends State<MeAboutPage> {
  var navBarHeight = 44.0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(navBarHeight),
        child: AppBar(
          title: Text(
            "关于我们",
            style: TextStyle(
              color: Color(0xfffFFFFFF),
              fontSize: 17,
            ),
          ),
          
          elevation: 0, // 状态栏海拔
          brightness: Brightness.dark, // 状态栏样式
          leading: NavBackItem(
            color: Color(0xfffffffff),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(26, 38, 26, 0),
        child: Text(
          '借书易App，是一款本地图书馆内借书用的借书软件，节省借书时间，提前预定，到店凭二维码借出，让你最快最方便的借到您想要的书籍。',
          style: TextStyle(color: Color(0xfff333333), fontSize: 14,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
