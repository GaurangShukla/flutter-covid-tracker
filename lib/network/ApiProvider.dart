import 'dart:convert';
import 'dart:io';

import 'package:go_away_covid19/models/RpGlobal.dart';
import 'package:go_away_covid19/models/RpLatest.dart';
import 'package:go_away_covid19/models/RpNews.dart';
import 'package:go_away_covid19/models/RpUserCountry.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ApiProvider {
  Client client = new Client();
  final _covid19DataSource = "https://coronavirus-tracker-api.herokuapp.com/v2";
  final _newsDataSource =
      "http://newsapi.org/v2/everything?q=COVID&apiKey=a8e98ea61ecc4aa69be04b13de6508bd&from=2020-03-27&sortBy=publishedAt&page=1&language=en";

  Future<List<Country>> getAllCountriesData() async {
    print('getGlobalData()');
    var response = await client.get('https://corona.lmao.ninja/v2/countries?sort=cases',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    print("global data response: ${response.body.toString()}");

    if (response.statusCode == 200) {
      return rpAllCountriesFromJson((response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }

  Future<RpLatest> getGloballyLatestData() async {
    print('getGloballyLatestData()');
    var response = await client.get('https://corona.lmao.ninja/v2/all',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    print("global data response: ${response.body.toString()}");

    if (response.statusCode == 200) {
      return RpLatest.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }

  Future<RpNews> getNewses() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    print('getNewses() from: http://newsapi.org/v2/everything?q=coronavirus&apiKey=a8e98ea61ecc4aa69be04b13de6508bd&from=$formattedDate&sortBy=publishedAt&page=1&language=en');
    var response = await client.get('http://newsapi.org/v2/everything?q=COVID&apiKey=a8e98ea61ecc4aa69be04b13de6508bd&from=$formattedDate&sortBy=publishedAt&page=1&language=en',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    print("newses response: ${response.body.toString()}");

    if (response.statusCode == 200) {
      return RpNews.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get newses');
    }
  }

  Future<Country> getUserCountryData(String country) async {
    print('getUserCountryData()');
    var response = await client.get('https://corona.lmao.ninja/v2/countries/$country',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    print("user country data response: ${response.body.toString()}");

    if (response.statusCode == 200) {
      return Country.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }
}
