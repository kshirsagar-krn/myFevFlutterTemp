// To parse this JSON data, do
//
//     final slotsModel = slotsModelFromJson(jsonString);

import 'dart:convert';

List<SlotsModel> slotsModelFromJson(String str) =>
    List<SlotsModel>.from(json.decode(str).map((x) => SlotsModel.fromJson(x)));

String slotsModelToJson(List<SlotsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlotsModel {
  DateTime? slotdate;
  String? serviceid;
  String? servicename;
  DateTime? slotstart;
  DateTime? slotend;
  String? statusmessage;
  bool? isbooked;

  SlotsModel({
    this.slotdate,
    this.serviceid,
    this.servicename,
    this.slotstart,
    this.slotend,
    this.statusmessage,
    this.isbooked,
  });

  SlotsModel copyWith({
    DateTime? slotdate,
    String? serviceid,
    String? servicename,
    DateTime? slotstart,
    DateTime? slotend,
    String? statusmessage,
    bool? isbooked,
  }) => SlotsModel(
    slotdate: slotdate ?? this.slotdate,
    serviceid: serviceid ?? this.serviceid,
    servicename: servicename ?? this.servicename,
    slotstart: slotstart ?? this.slotstart,
    slotend: slotend ?? this.slotend,
    statusmessage: statusmessage ?? this.statusmessage,
    isbooked: isbooked ?? this.isbooked,
  );

  factory SlotsModel.fromJson(Map<String, dynamic> json) => SlotsModel(
    slotdate: json["SLOTDATE"] == null
        ? null
        : DateTime.parse(json["SLOTDATE"]),
    serviceid: json["SERVICEID"],
    servicename: json["SERVICENAME"],
    slotstart: json["SLOTSTART"] == null
        ? null
        : DateTime.parse(json["SLOTSTART"]),
    slotend: json["SLOTEND"] == null ? null : DateTime.parse(json["SLOTEND"]),
    statusmessage: json["STATUSMESSAGE"],
    isbooked: json["ISBOOKED"],
  );

  Map<String, dynamic> toJson() => {
    "SLOTDATE": slotdate?.toIso8601String(),
    "SERVICEID": serviceid,
    "SERVICENAME": servicename,
    "SLOTSTART": slotstart?.toIso8601String(),
    "SLOTEND": slotend?.toIso8601String(),
    "STATUSMESSAGE": statusmessage,
    "ISBOOKED": isbooked,
  };
}
