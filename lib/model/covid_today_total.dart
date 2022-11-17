// To parse this JSON data, do
//
//     final covid19ThTotal = covid19ThTotalFromJson(jsonString);

import 'dart:convert';

List<Covid19ThTotal> covid19ThTotalFromJson(String str) =>
    List<Covid19ThTotal>.from(
        json.decode(str).map((x) => Covid19ThTotal.fromJson(x)));

String covid19ThTotalToJson(List<Covid19ThTotal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Covid19ThTotal {
  Covid19ThTotal({
    // required this.txnDate,
    required this.newCase,
    required this.totalCase,
    required this.newCaseExcludeabroad,
    required this.totalCaseExcludeabroad,
    required this.newDeath,
    required this.totalDeath,
    required this.newRecovered,
    required this.totalRecovered,
    required this.updateDate,
  });

  // DateTime txnDate;
  int newCase;
  int totalCase;
  int newCaseExcludeabroad;
  int totalCaseExcludeabroad;
  int newDeath;
  int totalDeath;
  int newRecovered;
  int totalRecovered;
  DateTime updateDate;

  factory Covid19ThTotal.fromJson(Map<String, dynamic> json) => Covid19ThTotal(
        // txnDate: DateTime.parse(json["txn_date"] ?? "2012-12-12"),
        newCase: json["new_case"],
        totalCase: json["total_case"],
        newCaseExcludeabroad: json["new_case_excludeabroad"],
        totalCaseExcludeabroad: json["total_case_excludeabroad"],
        newDeath: json["new_death"],
        totalDeath: json["total_death"],
        newRecovered: json["new_recovered"],
        totalRecovered: json["total_recovered"],
        updateDate: DateTime.parse(json["update_date"]),
      );

  Map<String, dynamic> toJson() => {
        // "txn_date":
        //     "${txnDate.year.toString().padLeft(4, '0')}-${txnDate.month.toString().padLeft(2, '0')}-${txnDate.day.toString().padLeft(2, '0')}",
        "new_case": newCase,
        "total_case": totalCase,
        "new_case_excludeabroad": newCaseExcludeabroad,
        "total_case_excludeabroad": totalCaseExcludeabroad,
        "new_death": newDeath,
        "total_death": totalDeath,
        "new_recovered": newRecovered,
        "total_recovered": totalRecovered,
        "update_date": updateDate.toIso8601String(),
      };
}
