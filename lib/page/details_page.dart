import 'package:borrow_books/util/util.dart';
import 'package:borrow_books/view/view.dart';
import 'package:flustars/flustars.dart' show SpUtil;
import 'package:flutter/material.dart';
import 'package:borrow_books/kit/nav_back.dart';
import 'package:common_utils/common_utils.dart';

class DetailsPage extends StatefulWidget {
  final Map data;

  const DetailsPage({Key key, this.data}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  double navBarHeight = 44.0;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    String title = ValueUtil.toStr(widget.data['title']);

    _saveHistory();

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(navBarHeight),
          child: AppBar(
            title: Text(
              title,
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
        body: DetailsView(data: widget.data),
      ),
    );
  }

  _saveHistory() async {
    if (widget.data.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('history') ?? [];

      for (var temp in items) {
      if (temp['image'] == widget.data['image']) {
        items.remove(temp);
        break;
      }
    }

      List<Map<dynamic, dynamic>> array = [];
      widget.data['date'] = DateUtil.getNowDateStr();
      array.add(widget.data);
      array.addAll(items);

      await SpUtil.putObjectList('history', array);
    }
  }
}
