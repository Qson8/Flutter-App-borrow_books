import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:borrow_books/util/util.dart';
import 'package:borrow_books/view/item_cell_view.dart';
import 'package:borrow_books/page/page.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List items = [];

  @override
  void initState() {
    super.initState();
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
          items = obc['home_list'];
          print('数据：$items');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items.length + 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _bannerWidget();
          } else if (index == 1) {
            return _actionWidget();
          } else if (index == 2) {
            return _recTitleWidget();
          }
          return ItemCellWidget(item: items[(index - 3)]);
        },
      ),
    );
  }

  Widget _recTitleWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 8),
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
            style: TextStyle(color: Color(0xfff303131), fontSize: 14),
          ),
        ],
      ),
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: <Widget>[
    //     Container(
    //       padding: EdgeInsets.fromLTRB(15, 20, 15, 8),
    //       child: Image.asset('images/home_rec_title.png',color: Theme.of(context).primaryColor,),
    //     ),
    //   ],
    // );
  }

  Widget _actionWidget() {
    return Container(
      color: Color(0xfffFFFFFF),
      margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(
                        builder: (context) {
                          return MoodsPage();
                        },
                        settings: RouteSettings()));
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'images/home_action3.png',
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: Text('人气推荐'),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) {
                  return NewsPage();
                }));
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'images/home_action2.png',
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: Text('新品上架'),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (context) {
                  return HeatPage();
                }));
              },
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'images/home_action1.png',
                    color: Theme.of(context).primaryColor,
                  ),
                  Container(
                    child: Text('热度排行'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerWidget() {
    double width = ScreenUtil.screenWidthDp;
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
            builder: (context) {
              return DetailsPage(
                data: {
                  "image": "images/list_image_5.png",
                  "title": "丝绸之路:一部全新的世界史",
                  "content": "鬼屋是当代喜欢刺激的年轻人到游乐园必玩的游戏之一。",
                  "isLike": true,
                  "like": 1346
                },
              );
            },
            settings: RouteSettings()));
      },
      child: Container(
        child: Image.asset(
          'images/list_image_5.png',
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
