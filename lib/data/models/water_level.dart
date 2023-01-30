import 'dart:convert';

import 'package:intl/intl.dart';

WaterLevel waterLevelFromJson(String str) =>
    WaterLevel.fromJson(json.decode(str));

String waterLevelToJson(WaterLevel data) => json.encode(data.toJson());

class WaterLevel {
  WaterLevel({
    this.ts,
    this.date,
    required this.tinggi,
    required this.timeStamp,
  });

  String? ts;
  DateTime? date;
  double tinggi;
  DateTime timeStamp;

  factory WaterLevel.fromJson(Map<String, dynamic> json) => WaterLevel(
      ts: json["TS"],
      date: DateTime.parse(json["Date"]),
      tinggi: json["tinggi"]?.toDouble(),
      timeStamp: DateFormat("hh:mm:ss,yyy-MM-dd")
          .parse('${json["TS"]},${json["Date"]}'));

  Map<String, dynamic> toJson() => {
        "TS": ts,
        "Date":
            "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "tinggi": tinggi,
        "time_stamp": DateFormat("hh:mm:ss,YY-MM-dd").format(timeStamp)
      };
}
