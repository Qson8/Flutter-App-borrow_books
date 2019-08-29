import 'package:borrow_books/kit/nav_back.dart';
import 'package:borrow_books/util/util.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateOrderPage extends StatefulWidget {
  final Map item;

  const CreateOrderPage({Key key, this.item}) : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> with AutomaticKeepAliveClientMixin {
  double navBarHeight = 44.0;

  @override
  bool get wantKeepAlive => true;
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(navBarHeight),
          child: AppBar(
            title: Text(
              '二维码',
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
          child: _contentView(),
        ),
      ),
    );
  }

  _contentView() {
    String title = ValueUtil.toStr(widget.item['title']);

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text('书名:$title', textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ),
        QrImage(
          data: title,
          size: ScreenUtil.screenWidthDp * 0.6,
          onError: null,
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text('请将二维码置于自助机器中扫描\n或交于柜台人工处理', textAlign: TextAlign.center),
        ),
      ],
    ));
  }
}
