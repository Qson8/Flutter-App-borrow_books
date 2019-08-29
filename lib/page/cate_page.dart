import 'dart:convert';
import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/page/page.dart';

class ClassifPage extends StatefulWidget {
  @override
  _ClassifPageState createState() => _ClassifPageState();
}

class _ClassifPageState extends State<ClassifPage> {
  double navBarHeight = 44.0;
  List items = [];

  /// 拉数据
  void _initData() async {
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("data/home_list.json");
    loadString.then((String value) {
      Map<String, dynamic> obc = json.decode(value);
      setState(
        () {
          items = obc['cate_list'];
          print('数据：$items');
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    double width = 110;
    int col = 3;
    double marginX =
        (ScreenUtil.screenWidthDp - col * width) / (1.0 * (col + 1));
    double marginY = marginX;

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(navBarHeight),
          child: AppBar(
            title: Text(
              '分类',
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
        body: Container(
          margin: EdgeInsets.fromLTRB(marginX, marginX, marginX, marginX),
          child: Wrap(
            spacing: marginX,
            runSpacing: marginY,
            children: _itemsBuilder(),
          ),
        ),
      ),
    );
  }

  List<Widget> _itemsBuilder() {
    double width = 110;
    return items.map<Widget>((json) {
      // String image = ValueUtil.toStr(json['image']);
      String id = ValueUtil.toStr(json['id']);
      String title = ValueUtil.toStr(json['name']);
      return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) {
                  return ListPage(
                    id: id,
                    title: title,
                  );
                },
                settings: RouteSettings()));
          },
          child: Container(
            width: width,
            height: width,
            color: Color.fromRGBO(70, 150, 236, 0.5),
            child: Center(child: Text(
              title,
              style: TextStyle(color: Colors.white,fontSize: 16),
            ),),
            // child: Image.asset(
            //   image,
            //   fit: BoxFit.fitWidth,
            // ),
          ));
    }).toList();
  }
}
