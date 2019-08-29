import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:borrow_books/page/page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        centerWidget: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset(
            'images/intro_01.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        // title: "人气推荐",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff40E0D0),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );

    slides.add(
      new Slide(
        centerWidget: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset(
            'images/intro_02.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        // title: "多种玩法",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFFACD),
        colorEnd: Color(0xffFF6347),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );

    slides.add(
      new Slide(
        centerWidget: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset(
            'images/intro_03.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        // title: "详情+推荐",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFA500),
        colorEnd: Color(0xff7FFFD4),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );

    slides.add(
      new Slide(
        centerWidget: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset(
            'images/intro_04.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        // title: "细分预览",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 20.0, fontFamily: 'Raleway'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        colorBegin: Color(0xffFFDAB9),
        colorEnd: Color(0xff40E0D0),
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
      ),
    );
  }

  void onDonePress() {
    _setHasSkip();
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => Home()),
        (route) => route == null);
  }

  void onSkipPress() {
    _setHasSkip();
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => Home()),
        (route) => route == null);
  }

  void _setHasSkip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("hasSkip", true);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      // renderSkipBtn: this.onSkipPress,
      nameSkipBtn: "跳过",
      nameNextBtn: "下一页",
      nameDoneBtn: "进入",
    );
  }
}
