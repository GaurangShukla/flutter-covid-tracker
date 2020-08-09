import 'dart:convert';

RpLatest rpLatestFromJson(String str) => RpLatest.fromJson(json.decode(str));

String rpLatestToJson(RpLatest data) => json.encode(data.toJson());

class RpLatest {
  int cases;
  int deaths;
  int recovered;
  int updated;

  RpLatest({
    this.cases,
    this.deaths,
    this.recovered,
    this.updated,
  });

  factory RpLatest.fromJson(Map<String, dynamic> json) => RpLatest(
    cases: json["cases"],
    deaths: json["deaths"],
    recovered: json["recovered"],
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "cases": cases,
    "deaths": deaths,
    "recovered": recovered,
    "updated": updated,
  };
}
