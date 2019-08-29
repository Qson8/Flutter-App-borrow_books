import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:borrow_books/page/page.dart';

const mainColor = Color.fromRGBO(70, 150, 236, 1.0);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    ClassifPage(),
    MePage(),
  ];

  final List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      activeIcon: Container(
        child: Image.asset(
          'images/tab_home.png',
          color: mainColor,
        ),
      ),
      icon: Image.asset(
        'images/tab_home.png',
        color: Color(0xfffAFAFAF),
      ),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      activeIcon: Container(
        child: Image.asset(
          'images/tab_cate.png',
          color: mainColor,
        ),
      ),
      icon: Image.asset(
        'images/tab_cate.png',
        color: Color(0xfffAFAFAF),
      ),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      activeIcon: Container(
        child: Image.asset(
          'images/tab_me.png',
          color: mainColor,
        ),
      ),
      icon: Image.asset(
        'images/tab_me.png',
        color: Color(0xfffAFAFAF),
      ),
      title: Text('我'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        activeColor: mainColor,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: _tabs,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
