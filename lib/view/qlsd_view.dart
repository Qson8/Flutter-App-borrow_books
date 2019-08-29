import 'dart:convert';
import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/view/view.dart';

class QLSDView extends StatefulWidget {
  @override
  _QLSDViewState createState() => _QLSDViewState();
}

class _QLSDViewState extends State<QLSDView> {
  List items = [];
  bool onLoading = true;

  @override
  void initState() {
    super.initState();
    HudUtil.show();
    _initData();
  }

  /// 拉数据
  void _initData() async {
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("data/home_list.json");
    loadString.then((String value) {
      Map<String, dynamic> obc = json.decode(value);
      setState(
        () {
          items = obc['qlsd_list'];
          print('数据：$items');
        },
      );
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        onLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return onLoading
        ? Container()
        : Container(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemCellWidget(item: items[(index)]);
              },
            ),
          );
  }
}
