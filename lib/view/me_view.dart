import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:borrow_books/util/util.dart';
import 'package:borrow_books/page/page.dart';
import 'package:flustars/flustars.dart' show SpUtil;

class MeViewWidget extends StatefulWidget {
  @override
  _MeViewWidgetState createState() => _MeViewWidgetState();
}

class _MeViewWidgetState extends State<MeViewWidget> {
  bool isLogin = false;
  List items;

  Map headData = {
    'name': "阅读爱好者",
    'des': "爱看书，爱上生活！",
  };

  // Map item = {
  //   'image': 'images/me_gywm.png',
  //   'title': '我的门票',
  // };

  void _initData() {
    _initAsync();
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("data/home_list.json");
    loadString.then((String value) {
      Map<String, dynamic> obc = json.decode(value);
      setState(
        () {
          items = obc['me'];
          print('数据：$items');
        },
      );
    });
  }

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    bool hasLogin = SpUtil.getBool('isLogin');
    setState(() {
      isLogin = hasLogin;
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: items == null ? 0 : items.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return !isLogin ? _headerViewNotLogged() : _headerView(headData);
          } else
            return _rowCell(items[index - 1]);
        },
      ),
    );
  }

  _headerViewNotLogged() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.fromLTRB(9, 32, 9, 32),
      margin: EdgeInsets.only(bottom: 15),
      child: Container(
        height: 100,
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                'images/login_icon.png',
                width: 50,
                height: 50,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                            builder: (context) {
                              return LoginPage(
                                block: () {
                                  _initAsync();
                                  setState(() {});
                                },
                              );
                            },
                            settings: RouteSettings()));
                  },
                  child: Text(
                    '点击登录',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _headerView(Map json) {
    String name = ValueUtil.toStr(json['name']);
    String des = ValueUtil.toStr(json['des']);
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.fromLTRB(9, 32, 9, 32),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Container(
            child: ClipOval(
              child: Container(
                width: 93,
                height: 93,
                color: Colors.white,
                child: Image.asset('images/def_icon.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    des,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _rowCell(Map item) {
    String image = ValueUtil.toStr(item['image']);
    String title = ValueUtil.toStr(item['title']);
    String id = ValueUtil.toStr(item['id']);

    return GestureDetector(
      onTap: () {
        if (id == '0' && isLogin) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeOrdersPage();
            }),
          );
        } else if (id == '1' && isLogin) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeTicketsPage();
            }),
          );
        } 
        else if (id == '2' && isLogin) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeFavPage();
            }),
          );
        } else if (id == '3' && isLogin) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeLikePage();
            }),
          );
        } else if (id == '4' && isLogin) {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeHistoryPage();
            }),
          );
        } else if (id == '5') {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) {
              return MeAboutPage();
            }),
          );
        } else if (id == '6') {
          Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (context) {
            return MeSettingPage(block: () {
              setState(() {
                isLogin = SpUtil.getBool('isLogin');
              });
            });
          }));
        } else {
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
          } else {}
        }
      },
      child: (id == '6' && !isLogin)
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              height: 50,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image.asset(image,color: Theme.of(context).primaryColor,),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 9),
                      child: Text(
                        title,
                        style:
                            TextStyle(color: Color(0xfff323232), fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      child: Image.asset('images/arrow_gray.png'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
