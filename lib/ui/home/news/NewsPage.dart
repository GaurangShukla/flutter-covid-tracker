import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_away_covid19/models/RpNews.dart';
import 'package:go_away_covid19/ui/webview/WebViewDetails.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/ui/home/news/NewsBloc.dart';
import 'package:go_away_covid19/util/ShimmerLoading.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    bloc.getNewses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBackgroundColor(),
      body: StreamBuilder(
        stream: bloc.newses,
        builder: (context, AsyncSnapshot<RpNews> snapshot) {
          if (snapshot.hasData) {
            return buildNewsList(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return getNewsShimmerLoading();
        },
      ),
    );
  }

  Widget buildNewsList(RpNews newses) {
    return ListView.builder(
        itemCount: newses.articles.length,
        itemBuilder: (context, index) {
          var news = newses.articles[index];
          return InkWell(onTap: () {
            var webViewDetails = WebViewDetails(title: news.title, url: news.url);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => webViewDetails),
            );
          }, child: getSingleNewsView(news));
        });
  }

  Widget getSingleNewsView(Article news) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Container(
              height: 150,
              width: double.infinity,
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                      ),
                  errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Center(
                          child: Icon(
                        Icons.broken_image,
                        size: 50.0,
                        color: Colors.grey[300],
                      ))),
                  imageUrl: "${news.urlToImage}"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Text(
              news.title,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: getNewsTitleStyle(),
            ),
          )
        ],
      ),
    );
  }

}
