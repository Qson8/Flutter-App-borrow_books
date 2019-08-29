import 'dart:convert';
import 'package:borrow_books/page/page.dart';
import 'package:borrow_books/view/view.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/util/util.dart';
import 'package:flustars/flustars.dart' show SpUtil;

class DetailsView extends StatefulWidget {
  final Map data;

  const DetailsView({Key key, this.data}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool onLoading = true;
  List xgList = [];
  bool isLogin;

  @override
  void initState() {
    super.initState();
    HudUtil.show();
    _initData();
  }

  void _initData() async {
    _initAsync();
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("data/home_list.json");
    loadString.then((String value) {
      Map<String, dynamic> obc = json.decode(value);
      setState(
        () {
          xgList = obc['xg_list'];
          print('数据：$xgList');
        },
      );
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        onLoading = false;
      });
    });
  }

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    isLogin = SpUtil.getBool('isLogin');
  }

  @override
  Widget build(BuildContext context) {
    Map item = widget.data;
    String image = ValueUtil.toStr(item['image']);
    String title = ValueUtil.toStr(item['title']);
    String content = ValueUtil.toStr(item['content']);
    // String like = ValueUtil.toStr(item['like']);
    bool isLike = ValueUtil.toBool(item['isLike']);

    double width = ScreenUtil.screenWidthDp;

    return onLoading
        ? Container()
        : Container(
            width: width,
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Container(
                  width: width,
                  child: Image.asset(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(25, 42, 33, 47),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 21),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '详     细：',
                              style: TextStyle(
                                  color: Color(0xfff656565), fontSize: 15),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text(
                                  content,
                                  maxLines: null,
                                  style: TextStyle(
                                      color: Color(0xfff000000), fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 21),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '是否可借：',
                              style: TextStyle(
                                  color: Color(0xfff656565), fontSize: 15),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Text(
                                  '可借',
                                  maxLines: null,
                                  style: TextStyle(
                                      color: Color(0xfff000000), fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0, width * 0.15, 0),
                              child: GestureDetector(
                                onTap: _tapToLike,
                                child: Image.asset(
                                  isLike
                                      ? 'images/item_like.png'
                                      : 'images/item_un_like.png',
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _tapToFav,
                              child: Container(
                                child: Image.asset('images/item_fav.png',
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: _tapToYuding,
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        width * 0.1, 0, 12, 0),
                                    child: Image.asset(
                                        'images/item_reserve.png',
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Positioned(
                                    top: 4,
                                    left: 70,
                                    child: Container(
                                      child: Text(
                                        '预定',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(28, 0, 0, 19),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          height: 11,
                          width: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        '猜你喜欢',
                        style:
                            TextStyle(color: Color(0xfff303131), fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: _buildListWidget(),
                ),
              ],
            ),
          );
  }

  _buildListWidget() {
    List<Widget> list = [];
    for (int i = 0; i < xgList.length; i++) {
      Map json = xgList[i];
      list.add(ItemCellWidget(item: json));
    }
    return list;
  }

  void _tapToLike() {
    if (!isLogin) {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) {
        return LoginPage(
          block: () {
            _initAsync();
            setState(() {});
          },
        );
      }));
      return;
    }

    HudUtil.show();

    Future.delayed(Duration(milliseconds: 500), () {
      _saveLikeData();
      HudUtil.showSuccessStr('点赞成功');
    });
  }

  void _tapToFav() {
    if (!isLogin) {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) {
        return LoginPage(
          block: () {
            _initAsync();
            setState(() {});
          },
        );
      }));
      return;
    }

    HudUtil.show();

    Future.delayed(Duration(milliseconds: 500), () {
      _saveFavData();
      HudUtil.showSuccessStr('收藏成功');
    });
  }

  void _tapToYuding() async {
    if (!isLogin) {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) {
        return LoginPage(
          block: () {
            _initAsync();
            setState(() {});
          },
        );
      }));
      return;
    }

    HudUtil.show();

    Future.delayed(Duration(milliseconds: 500), () {
      _saveYuDingData();
      // HudUtil.showSuccessStr('预定成功');

      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) {
        return CreateOrderPage(item: widget.data);
      }));
    });
  }

  _saveLikeData() async {
    if (widget.data.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('like') ?? [];

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

      await SpUtil.putObjectList('like', array);
    }
  }

  _saveFavData() async {
    if (widget.data.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('fav') ?? [];

      for (var temp in items) {
        if (temp['image'] == widget.data['image']) {
          items.remove(temp);
          break;
        }
      }

      List<Map<dynamic, dynamic>> array = [];
      array.add(widget.data);
      array.addAll(items);

      await SpUtil.putObjectList('fav', array);
    }
  }

  _saveYuDingData() async {
    if (widget.data.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('yuding') ?? [];

      for (var temp in items) {
        if (temp['image'] == widget.data['image']) {
          items.remove(temp);
          break;
        }
      }

      List<Map<dynamic, dynamic>> array = [];
      array.add(widget.data);
      array.addAll(items);

      await SpUtil.putObjectList('yuding', array);
    }
  }
}
