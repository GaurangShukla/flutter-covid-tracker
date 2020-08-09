import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  WebViewController _controller;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://www.trackcorona.live/map',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
//              loadEmbeddedCode();
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
          isLoading ? Center(child: CircularProgressIndicator()) : Container(),
        ],
      ),
    );
  }

  String getEmbeddedCode() {
    return '<!DOCTYPE html> <html> <head><title>Page Title</title> <style>body {background-color: white;text-align: center;color: white;font-family: Arial, Helvetica, sans-serif;}</style></head> <body> <p><a href="https://commons.wikimedia.org/wiki/File:COVID-19_Outbreak_World_Map_per_Capita.svg#/media/File:COVID-19_Outbreak_World_Map_per_Capita.svg"><img style="width:4600px;height:2000px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/COVID-19_Outbreak_World_Map_per_Capita.svg/1200px-COVID-19_Outbreak_World_Map_per_Capita.svg.png" alt="COVID-19 Outbreak World Map per Capita.svg"></a></p></body></html>';
  }

  void loadEmbeddedCode() {
    _controller.loadUrl(Uri.dataFromString(getEmbeddedCode(),
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
