import 'package:flutter/material.dart';
import 'package:go_away_covid19/ui/webview/WebViewDetails.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {

  var howItSpreadsUrl = "https://www.cdc.gov/coronavirus/2019-ncov/prepare/transmission.html";
  var symptomsUrl = "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html";
  var howToUseMaskUrl = "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/when-and-how-to-use-masks";
  var mediaResourcesUrl = "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/media-resources/press-briefings";
  var adviceForPublicUrl = "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(title: 'How it spreads?', url: howItSpreadsUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => webViewDetails),
              );
            },
            child: getSingleFaqView('How it spreads?',
                'Learn how Covid-19 spreads', 'images/faq_howitspreads.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(title: 'Symptoms', url: symptomsUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => webViewDetails),
              );
            },
            child: getSingleFaqView('Symptoms',
                'Learn Covid-19 symptoms', 'images/faq_symptoms.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(title: 'How to use Mask?', url: howToUseMaskUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => webViewDetails),
              );
            },
            child: getSingleFaqView('How to use Mask?',
                'When & How to use Mask.', 'images/faq_protectyourself.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(title: 'Media resources', url: mediaResourcesUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => webViewDetails),
              );
            },
            child: getSingleFaqView('Media resources',
                'Visit to get the resources', 'images/faq_mediaresources.png'),
          ),
          InkWell(
            onTap: () {
              var webViewDetails = WebViewDetails(title: 'Advice for public', url: adviceForPublicUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => webViewDetails),
              );
            },
            child: getSingleFaqView('Advice for public',
                'WHO advice for public', 'images/faq_mythbusters.png'),
          ),
        ],
      ),
    );
  }

  Widget getSingleFaqView(String title, String subtitle, String imageSrc) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ]),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset(
              imageSrc,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            height: 40,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: getFaqTitleStyle(),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    subtitle,
                    style: getFaqSubtitleStyle(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
