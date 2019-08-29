import 'package:borrow_books/kit/nav_back.dart';
import 'package:borrow_books/util/util.dart';
import 'package:flustars/flustars.dart' show SpUtil;
import 'package:flutter/material.dart';

typedef MeSettingCallback = void Function();

class MeSettingPage extends StatefulWidget {
  final MeSettingCallback block;

  const MeSettingPage({
    Key key,
    this.block,
  }) : super(key: key);

  @override
  _MeSettingPageState createState() => _MeSettingPageState();
}

class _MeSettingPageState extends State<MeSettingPage> {
  String phone = '';

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    phone = SpUtil.getString('phone') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var navBarHeight = 44.0;
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    String account = phone;
    String pwd = '******';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(navBarHeight),
        child: AppBar(
          title: Text(
            '账号设置',
            style: TextStyle(
              color: Colors.white,
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(16, 19, 16, 46),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      '账号',
                      style: TextStyle(color: Color(0xfff333333), fontSize: 15),
                    ),
                  ),
                  Text(
                    account,
                    style: TextStyle(color: Color(0xfff333333), fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 19, 16, 46),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      '密码',
                      style: TextStyle(color: Color(0xfff333333), fontSize: 15),
                    ),
                  ),
                  Text(
                    pwd,
                    style: TextStyle(color: Color(0xfff333333), fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: _loginOut,
              child: Stack(
                alignment:Alignment.center,
                children:[
                  Container(
                  padding: EdgeInsets.only(bottom: 55),
                  child: 
                      Image.asset(
                        'images/log_out.png',
                        color: Theme.of(context).primaryColor,
                      ),

                  ),
                Positioned(
                  top: 18,
                  child: Center(child: Text('退出登录',style: TextStyle(color: Colors.white,fontSize: 18),),),
                ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginOut() {
    HudUtil.show();
    SpUtil.putBool('isLogin', false);
    SpUtil.putString('phone', '');
    SpUtil.putString('password', '');

    widget.block();

    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }
}
