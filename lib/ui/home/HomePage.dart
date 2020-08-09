import 'package:flutter/material.dart';
import 'package:go_away_covid19/ui/home/faq/FaqPage.dart';
import 'package:go_away_covid19/ui/home/global/GlobalPage.dart';
import 'package:go_away_covid19/ui/home/map/MapPage.dart';
import 'package:go_away_covid19/ui/home/news/NewsPage.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> screens = [GlobalPage(), FaqPage(), NewsPage(), MapPage()];
  Widget currentScreen = GlobalPage();
  final PageStorageBucket bucket = PageStorageBucket();
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor:
            currentTab == 3 ? Colors.white : getPageBackgroundColor(),
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
            Spacer(),
            InkWell(
                onTap: () {
                  removeUserCountry();
                },
                child: Text(getPageTitle(currentTab),
                    style: getPageTitleTextStyle(18.0)))
          ],
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      backgroundColor: getBottomNavigationBarColor(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_global.png",
            ),
            color: currentTab == 0 ? getPrimaryColor() : Color(0xffcccccc),
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_faq.png",
            ),
            color: currentTab == 1 ? getPrimaryColor() : Color(0xffcccccc),
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_news.png",
            ),
            color: currentTab == 2 ? getPrimaryColor() : Color(0xffcccccc),
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "images/tab_icon_map.png",
            ),
            color: currentTab == 3 ? getPrimaryColor() : Color(0xffcccccc),
          ),
          title: Container(
            margin: EdgeInsets.all(8.0),
          ),
        )
      ],
      onTap: (index) {
        setState(() {
          currentScreen = screens[index];
          currentTab = index;
        });
      },
    );
  }

  String getPageTitle(int currentTab) {
    var pageTitle = "GLOBAL";
    switch (currentTab) {
      case 0:
        pageTitle = 'GLOBAL';
        break;
      case 1:
        pageTitle = 'FAQ';
        break;
      case 2:
        pageTitle = 'NEWS';
        break;
      case 3:
        pageTitle = 'MAP';
        break;
    }
    setState(() {
      pageTitle = pageTitle;
    });
    return pageTitle;
  }
}


void removeUserCountry() async  {
  var preference = await SharedPreferences.getInstance();
  preference.remove('userCountry');
}