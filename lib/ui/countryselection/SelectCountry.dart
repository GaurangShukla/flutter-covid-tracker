import 'package:flutter/material.dart';
import 'package:go_away_covid19/models/RpGlobal.dart';
import 'package:go_away_covid19/network/Repository.dart';
import 'package:go_away_covid19/ui/home/HomePage.dart';
import 'package:go_away_covid19/ui/home/global/GlobalBloc.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry>
    with SingleTickerProviderStateMixin {
  var selectedIndex = -1;
  var selectedCountryName = "";
  bool showConfirmButton = false;

  AnimationController controller;
  Animation<Offset> offset;
  var _repository = Repository();

  @override
  void initState() {
    super.initState();
    bloc.getGlobalData();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    offset =
        Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.1)).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: getPageBackgroundColor(),
        title: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 100,
              child: Hero(
                  tag: "ic_goaway",
                  child: Image.asset(
                    'images/ic_go_away.png',
                    fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: getPageBackgroundColor(),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Select your country',
                    style: getSelectCountryTextStyle(24),
                    textAlign: TextAlign.left,
                  )),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 15.0,
                      ),
                    ]),
                child: FutureBuilder(
                  future: _repository.getAllCountriesData(),
                  builder: (context, AsyncSnapshot<List<Country>> snapshot) {
                    if (snapshot.hasData) {
                      return buildCountryList(snapshot.data);
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('${snapshot.error.toString()}'));
                    }
                    return Center(
                        child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: LinearProgressIndicator()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCountryList(List<Country> countryList) {
    countryList.sort((a, b) => a.country.compareTo(b.country));
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: ListView.builder(
              itemCount: countryList.length,
              itemBuilder: (context, index) {
                var countryName = countryList[index].country;
                return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        selectedCountryName = countryName;
                        showConfirmButton = true;
                        controller.reverse();
//                        switch (controller.status) {
//                          case AnimationStatus.completed:
//                            controller.reverse();
//                            break;
//                          case AnimationStatus.dismissed:
//                            controller.forward();
//                            break;
//                          default:
//                        }
                      });
                    },
                    child: buildCountryNameView(countryName, index));
              }),
        ),
        showConfirmButton
            ? Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: offset,
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          controller.forward();
                          setCountryName();
                          gotoHomePage();
                        });
                        
                      },
                      color: Colors.black,
                      child: Center(
                          child: Text(
                        'CONFIRM',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buildCountryNameView(String countryName, int index) {
    return Container(
      color: selectedIndex == index ? Color(0xFFEEEEF3) : Colors.white,
      margin:
          EdgeInsets.only(left: selectedIndex == index ? 10 : 40, right: 10),
      height: 45,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            margin: EdgeInsets.only(left: selectedIndex == index ? 30 : 0),
            child: Text(
              getOnlyCountryName(countryName),
              style: getPageTitleTextStyle(14),
            )),
      ),
    );
  }

  String getOnlyCountryName(String country) {
    var splits = country.split(",");
    return splits[0];
  }

  void setCountryName() async {
    var preference = await SharedPreferences.getInstance();
    preference.setString("userCountry", selectedCountryName);
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
}
