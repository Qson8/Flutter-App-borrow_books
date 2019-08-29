import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart' show SpUtil;
import 'package:borrow_books/kit/nav_back.dart';
import 'package:borrow_books/util/util.dart';
import 'package:common_utils/common_utils.dart' show RegexUtil;

typedef LoginPageCallback = void Function();

class LoginPage extends StatefulWidget {
  final LoginPageCallback block;

  const LoginPage({Key key, this.block}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = false;

  String phone = '';
  String password = '';
  String password2 = '';

  var navBarHeight = 44.0;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    //App启动时读取Sp数据，需要异步等待Sp初始化完成。
    await SpUtil.getInstance();

    List tokens = SpUtil.getStringList('token') ?? [];
    setState(() {
      _isLogin = (tokens != null && tokens.length > 0) ? true : false;
    });
  }

  @override
  void dispose() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(navBarHeight),
        child: AppBar(
          title: Text(
            "",
            style: TextStyle(
              color: Color(0xfffFFFFFF),
              fontSize: 17,
            ),
          ),
          backgroundColor: Color(0xfffFFFFFF), // 背景颜色
          elevation: 0, // 状态栏海拔
          brightness: Brightness.light, // 状态栏样式
          leading: NavBackItem(
            color: Theme.of(context).primaryColor,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 185,
                        height: 105,
                        child: Image.asset('images/login_icon.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLogin = true;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: _isLogin
                                        ? Theme.of(context).primaryColor
                                        : Color(0xfffE6E6E6),
                                    padding: EdgeInsets.only(bottom: 1),
                                    child: Container(
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.fromLTRB(37, 17, 37, 17),
                                      child: Text(
                                        '登录',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: _isLogin
                                              ? Theme.of(context).primaryColor
                                              : Color(0xfffC9C9C9),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLogin = false;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: _isLogin
                                        ? Color(0xfffE6E6E6)
                                        : Theme.of(context).primaryColor,
                                    padding: EdgeInsets.only(bottom: 1),
                                    child: Container(
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.fromLTRB(37, 17, 37, 17),
                                      child: Text(
                                        '注册',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: _isLogin
                                              ? Color(0xfffE6E6E6)
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _isLogin ? _loginWidget() : _unLoginWidget(),
                      GestureDetector(
                        onTap: _loginBtnClick,
                        child: Container(
                          margin: EdgeInsets.only(top: 47),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              height: 47,
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Center(
                                  child: Text(
                                _isLogin ? '登录' : '注册',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xfffffffff),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Container(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 72),
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phone = value;
                setState(() {});
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入手机号码',
                hintStyle: TextStyle(fontSize: 15.0, color: Color(0xfff333333)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 30),
            child: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入密码',
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xfff333333),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  _unLoginWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 72),
            child: TextField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入手机号码',
                hintStyle: TextStyle(fontSize: 15.0, color: Color(0xfff333333)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 30),
            child: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入密码',
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xfff333333),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.only(top: 30),
            child: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password2 = value;
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请再次输入密码',
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xfff333333),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  _loginBtnClick() async {

    // 账号
    bool isMain = false;
    if(phone == '13117912581' && password == '13117912581') {
      isMain = true;
    }

    // 手机号验证
    if (!RegexUtil.isMobileExact(phone)) {
      HudUtil.showErrorStr('请输入有效的手机号');
      return;
    }

    // 密码大于6位验证
    if (password == null || password != null && password.length < 6) {
      HudUtil.showErrorStr('密码最少6位数字');
      return;
    }

    if (phone.length <= 0) {
      HudUtil.showErrorStr('请输入手机号');
      return;
    }
    if (password.length <= 0) {
      HudUtil.showErrorStr('请输入密码');
      return;
    }

    if (password2.length <= 0 && !_isLogin) {
      HudUtil.showErrorStr('请再次输入密码');
      return;
    }

    HudUtil.show();

    Future.delayed(Duration(milliseconds: 500), () {
      String token = phone + '&&&' + password;
      List<String> tokens = SpUtil.getStringList('token') ?? [];

      if (_isLogin) {
        // 登录
        bool islogin = tokens.contains(token);
        if (islogin || isMain) {
          HudUtil.showSuccessStr('登录成功');
          SpUtil.putBool('isLogin', true);
          SpUtil.putString('phone', phone);
          SpUtil.putString('password', password);
          widget.block();
          Navigator.pop(context);
        } else {
          HudUtil.showErrorStr('账号或密码有误');
        }
      } else {
        // 注册
        if (password2.length > 0 && password2 == password) {
          tokens.length == 0 ? tokens = [token] : tokens.add(token);
          SpUtil.putStringList('token', tokens);
          HudUtil.showSuccessStr('注册成功');

          setState(() {
            _isLogin = true;
          });
        } else {
          HudUtil.showErrorStr('2次密码不一样');
        }
      }
    });
  }
}
