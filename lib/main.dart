import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_away_covid19/ui/countryselection/SelectCountry.dart';
import 'package:go_away_covid19/ui/home/HomePage.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      title: 'Corona tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () {
        decideWhichPageToGo();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          child: Hero(
            tag: "ic_goaway",
            child: Image.asset('images/ic_go_away.png'),
          ),
        ),
      ),
    );
  }

  void decideWhichPageToGo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('userCountry')) {
      gotoHomePage();
    } else {
      gotoSelectCountryPage();
    }
  }

  void gotoHomePage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (_, __, ___,) => HomePage(),
      ),
    );
  }

  void gotoSelectCountryPage() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 800),
        pageBuilder: (_, __, ___,) => SelectCountry(),
      ),
    );
  }
}
