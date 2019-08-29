import 'package:borrow_books/kit/nav_back.dart';
import 'package:borrow_books/util/util.dart';
import 'package:borrow_books/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart' show SpUtil;

class MeTicketsPage extends StatefulWidget {
  @override
  _MeTicketsPageState createState() => _MeTicketsPageState();
}

class _MeTicketsPageState extends State<MeTicketsPage> {
  List<Map> items = [];

  void initData() async {
    await SpUtil.getInstance();

    items = SpUtil.getObjectList('yuding') ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  var navBarHeight = 44.0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(navBarHeight),
        child: AppBar(
          title: Text(
            "我的预定",
            style: TextStyle(
              color: Color(0xfffFFFFFF),
              fontSize: 17,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
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
      body: items.length > 0
          ? Container(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCellView(
                    key: Key('{$items[index]}'),
                    item: items[index],
                    type: 3,
                    removeCallBack: (item) {
                      _removeCache(item);
                    },
                  );
                },
              ),
            )
          : Container(
              child: Center(
                child: Text('暂无数据'),
              ),
            ),
    );
  }

  _removeCache(item) {
    List arr = SpUtil.getObjectList('yuding') ?? [];
    for (var temp in arr) {
      if (temp['image'] == item['image']) {
        arr.remove(temp);
        break;
      }
    }

    SpUtil.putObjectList('yuding', arr);

    setState(() {
      items = arr;
    });
  }
}
