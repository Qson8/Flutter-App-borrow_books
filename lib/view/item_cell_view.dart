import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:borrow_books/util/util.dart';
import 'package:borrow_books/page/page.dart';
import 'package:flustars/flustars.dart' show SpUtil;

class ItemCellWidget extends StatefulWidget {
  final Map item;

  const ItemCellWidget({Key key, this.item}) : super(key: key);

  @override
  _ItemCellWidgetState createState() => _ItemCellWidgetState();
}

class _ItemCellWidgetState extends State<ItemCellWidget> {
  bool isLogin;

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    isLogin = SpUtil.getBool('isLogin');
  }

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  @override
  Widget build(BuildContext context) {
    Map item = widget.item;
    String image = ValueUtil.toStr(item['image']);
    String title = ValueUtil.toStr(item['title']);
    String content = ValueUtil.toStr(item['content']);
    String like = ValueUtil.toStr(item['like']);
    bool isLike = ValueUtil.toBool(item['isLike']);

    double width = ScreenUtil.screenWidthDp - 30;

    return GestureDetector(
      onTap: _tapToDetails,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0, 0),
                blurRadius: 1,
                spreadRadius: 1),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Container(
                  child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
                width: width,
              )),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 6),
              child: Text(
                title,
                style: TextStyle(color: Color(0xfff000000), fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 6),
              child: Text(
                content,
                style: TextStyle(color: Color(0xfff000000), fontSize: 14),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: _tapToLike,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, width * 0.15, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                            isLike
                                ? 'images/item_like.png'
                                : 'images/item_un_like.png',
                            color: Theme.of(context).primaryColor),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            like,
                            style: TextStyle(
                                color: Color(0xfff979797), fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _tapToFav,
                  child: Container(
                    padding: EdgeInsets.only(right: width * 0.15),
                    child: Image.asset(
                      'images/item_fav.png',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _tapToYuding,
                  child: Stack(
                    children: [
                      Container(
                        child: Image.asset('images/item_reserve.png',
                            color: Theme.of(context).primaryColor),
                      ),
                      Positioned(
                        top: 4,
                        left: 35,
                        child: Container(
                          child: Text(
                            '预定',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _tapToDetails() async {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) {
          print('详情数据1：${widget.item}');
          return DetailsPage(
            data: widget.item,
          );
        },
        settings: RouteSettings()));
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
        return CreateOrderPage(item: widget.item);
      }));
    });
  }

  _saveLikeData() async {
    if (widget.item.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('like') ?? [];

      for (var temp in items) {
        if (temp['image'] == widget.item['image']) {
          items.remove(temp);
          break;
        }
      }

      List<Map<dynamic, dynamic>> array = [];
      widget.item['date'] = DateUtil.getNowDateStr();
      array.add(widget.item);
      array.addAll(items);

      await SpUtil.putObjectList('like', array);
    }
  }

  _saveFavData() async {
    if (widget.item.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('fav') ?? [];

      for (var temp in items) {
        if (temp['image'] == widget.item['image']) {
          items.remove(temp);
          break;
        }
      }

      List<Map<dynamic, dynamic>> array = [];
      array.add(widget.item);
      array.addAll(items);

      await SpUtil.putObjectList('fav', array);
    }
  }

  _saveYuDingData() async {
    if (widget.item.length > 0) {
      List<Map<dynamic, dynamic>> items = SpUtil.getObjectList('yuding') ?? [];

      for (var temp in items) {
        if (temp['image'] == widget.item['image']) {
          items.remove(temp);
          break;
        }
      }

      List<Map<dynamic, dynamic>> array = [];
      array.add(widget.item);
      array.addAll(items);

      await SpUtil.putObjectList('yuding', array);
    }
  }
}

typedef ItemCellViewRemoveCallback = void Function(Map item);

class ItemCellView extends StatefulWidget {
  final Map item;
  final int type; // 0 历史 1 收藏 2 点赞 3 预定
  ItemCellViewRemoveCallback removeCallBack;

  ItemCellView({Key key, this.item, this.type = 0, this.removeCallBack})
      : super(key: key);

  @override
  _ItemCellViewState createState() => _ItemCellViewState(item);
}

class _ItemCellViewState extends State<ItemCellView> {
  Map json;
  _ItemCellViewState(item) : json = item;

  @override
  Widget build(BuildContext context) {
    String image = json['image'];
    String title = json['title'];
    String time = ValueUtil.toStr(json['date']) ?? '';

    int type = widget.type;
    var iconBtn = Container();
    if (type == 1) {
      iconBtn = Container(
        child: Image.asset('images/item_unFav.png',color: Theme.of(context).primaryColor,),
      );
    } else if (type == 2) {
      iconBtn = Container(
        width: 26,
        height: 26,
        child: Image.asset('images/item_like.png',color: Theme.of(context).primaryColor,),
      );
    } else if (type == 0) {
      iconBtn = Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          '删除',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (type == 3) {
      iconBtn = Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          '取消预定',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else if (type == 4) {
      iconBtn = Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          '归还书本',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    var timeWidget = Container();
    if (type == 0) {
      timeWidget = Container(
        child: Text(
          time,
          style: TextStyle(color: Color(0xfffCACACA), fontSize: 14),
        ),
      );
    } else if (type == 2) {
      timeWidget = Container(
        child: Text(
          time,
          style: TextStyle(color: Color(0xfffCACACA), fontSize: 14),
        ),
      );
    } else if (type == 3) {
      timeWidget = Container(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(builder: (context) {
              return CreateOrderPage(item: widget.item);
            }));
          },
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              '出示借书码',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(7, 24, 15, 21),
            height: 100.0 + 2 * 15 - 24 - 21,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    title,
                    style: TextStyle(color: Color(0xfff000000), fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  width: ScreenUtil.screenWidthDp - 100 - 7 - 15 - 2 * 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          HudUtil.show();

                          Future.delayed(Duration(milliseconds: 500), () {
                            if (type == 0) {
                              HudUtil.showSuccessStr('删除成功');
                              widget.removeCallBack(json);
                            } else if (type == 1) {
                              HudUtil.showSuccessStr('取消收藏');
                              widget.removeCallBack(json);
                            } else if (type == 2) {
                              HudUtil.showSuccessStr('取消点赞');
                              widget.removeCallBack(json);
                            } else if (type == 3) {
                              HudUtil.showSuccessStr('取消预定');
                              widget.removeCallBack(json);
                            } else if (type == 4) {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(builder: (context) {
                                return CreateOrderPage(item: widget.item);
                              }));
                            }
                          });
                        },
                        child: iconBtn,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      timeWidget,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
