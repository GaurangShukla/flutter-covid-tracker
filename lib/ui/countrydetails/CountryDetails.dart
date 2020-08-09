import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_away_covid19/models/RpGlobal.dart';
import 'package:go_away_covid19/util/ColorUtil.dart';
import 'package:go_away_covid19/util/StyleUtil.dart';
import 'package:pie_chart/pie_chart.dart';

class CountryDetails extends StatefulWidget {

  Country country;

  CountryDetails({this.country});

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {

  final casesColor = Color(0xFF2C94FC);
  final recoveredColor = Color(0xFF2ECCE3);
  final deathsColor = Color(0xFFF73E3E);
  Country userCountryData;

  Map<String, double> dataMap = new Map();
  List<Color> graphColorList = [];

  @override
  void initState() {
    super.initState();

    graphColorList.add(casesColor);
    graphColorList.add(recoveredColor);
    graphColorList.add(deathsColor);

    userCountryData = widget.country;
    dataMap.putIfAbsent("Confirmed", () => userCountryData.cases.toDouble());
    dataMap.putIfAbsent("Recovered", () => userCountryData.recovered.toDouble());
    dataMap.putIfAbsent("Deaths", () => userCountryData.deaths.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: getPrimaryColor(),
        ),
        backgroundColor: getPageBackgroundColor(),
        title: Text(
          '${userCountryData.country.toUpperCase()}',
          style: getPageTitleTextStyle(14),
        ),
      ),
      body: Container(
        color: getPageBackgroundColor(),
        child: ListView(
          children: <Widget>[
            getUserCountryStats(),
            getPieChart(),
            createChartLegends(),
          ],
        ),
      ),
    );
  }

  Widget getUserCountryStats() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 25, top: 16),
              child: Container(
                height: 20,
                width: 30,
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(
                          color: Colors.grey[200],
                        ),
                    errorWidget: (context, url, error) =>
                        Container(
                            color: Colors.grey.withOpacity(0.2),
                            child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50.0,
                                  color: Colors.grey.withOpacity(0.5),
                                ))),
                    imageUrl: "${userCountryData.countryInfo.flag}"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '${userCountryData.cases}',
                      style: getWorldWideCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Confirmed',
                      style: getConfirmedRecoveredTextStyle(),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Text(
                      '${userCountryData.recovered}',
                      style: getWorldWideCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Recovered',
                      style: getConfirmedRecoveredTextStyle(),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Text(
                      '${userCountryData.deaths}',
                      style: getDeathCountdownNumberStyle(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Death',
                      style: getDeathTitleTextStyle(),
                    ),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getPieChart() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ]),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Padding(
        padding: EdgeInsets.only(top: 40, bottom: 40),
        child: PieChart(
          dataMap: dataMap,
          chartRadius: 180,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 60.0,
          colorList: graphColorList,
          showLegends: false,
          legendPosition: LegendPosition.right,
          decimalPlaces: 1,
          showChartValueLabel: false,
          initialAngle: 0,
          chartValueStyle: defaultChartValueStyle.copyWith(
            color: Colors.blueGrey[100],
          ),
          chartType: ChartType.ring,
        ),
      ),
    );
  }

  Widget createChartLegends() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 45, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ]),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          getLegend(casesColor, "Confirmed Cases"),
          SizedBox(height: 40,),
          getLegend(recoveredColor, "Recovered"),
          SizedBox(height: 40,),
          getLegend(deathsColor, "Death"),
          SizedBox(height: 40,),
        ],
      ),
    );
  }

  Widget getLegend(Color color, String legendLabel) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 30,),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: color,
            ),
          ),
          SizedBox(width: 20,),
          Text(legendLabel, style: getGraphLegendStyle(),
            textAlign: TextAlign.left,),
          Spacer(),
          Text(getGraphValueInPercentage(legendLabel),
            style: getGraphValueStyle(),),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  String getGraphValueInPercentage(String legendLabel) {
    String value = "0";
    int total = userCountryData.cases + userCountryData.recovered +
        userCountryData.deaths;

    if (legendLabel == 'Confirmed Cases') {
      value = '${getPercentage(total, userCountryData.cases).toStringAsFixed(1)}%';
    } else if (legendLabel == 'Recovered') {
      value = '${getPercentage(total, userCountryData.recovered).toStringAsFixed(1)}%';
    } else {
      value = '${getPercentage(total, userCountryData.deaths).toStringAsFixed(1)}%';
    }
    return value;
  }

  double getPercentage(int total, int value) {
    double cases = value / total;
    return cases * 100;
  }
}
