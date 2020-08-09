import 'package:flutter/material.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewDetails extends StatefulWidget {
  String title;
  String url;

  WebViewDetails({this.title, this.url});

  @override
  _WebViewDetailsState createState() => _WebViewDetailsState();
}

class _WebViewDetailsState extends State<WebViewDetails> {
  String title;
  String url;

  WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    url = widget.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        //make status icon color to black
        iconTheme: IconThemeData(
          color: getPrimaryColor(),
        ),
        backgroundColor: getPageBackgroundColor(),
        title: Text(
          title,
          style: getFaqTitleStyle(),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _launchInBrowser(url);
            },
            child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.open_in_new,
                  color: getPrimaryColor(),
                )),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: '$url',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator())
              : Container()
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
