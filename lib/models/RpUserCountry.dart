import 'dart:convert';

RpUserCountryData rpUserCountryDataFromJson(String str) => RpUserCountryData.fromJson(json.decode(str));

String rpUserCountryDataToJson(RpUserCountryData data) => json.encode(data.toJson());

class RpUserCountryData {
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;

  RpUserCountryData({
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
  });

  factory RpUserCountryData.fromJson(Map<String, dynamic> json) => RpUserCountryData(
    country: json["country"],
    countryInfo: CountryInfo.fromJson(json["countryInfo"]),
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    active: json["active"],
    critical: json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"].toDouble(),
    deathsPerOneMillion: json["deathsPerOneMillion"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "countryInfo": countryInfo.toJson(),
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered,
    "active": active,
    "critical": critical,
    "casesPerOneMillion": casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion,
  };
}

class CountryInfo {
  int id;
  dynamic lat;
  dynamic long;
  String flag;
  String iso3;
  String iso2;

  CountryInfo({
    this.id,
    this.lat,
    this.long,
    this.flag,
    this.iso3,
    this.iso2,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["_id"],
    lat: json["lat"],
    long: json["long"],
    flag: json["flag"],
    iso3: json["iso3"],
    iso2: json["iso2"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "lat": lat,
    "long": long,
    "flag": flag,
    "iso3": iso3,
    "iso2": iso2,
  };
}