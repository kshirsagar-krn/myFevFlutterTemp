// To parse this JSON data, do
//
//     final bookingHistoryModel = bookingHistoryModelFromJson(jsonString);

import 'dart:convert';

List<BookingHistoryModel> bookingHistoryModelFromJson(String str) =>
    List<BookingHistoryModel>.from(
      json.decode(str).map((x) => BookingHistoryModel.fromJson(x)),
    );

String bookingHistoryModelToJson(List<BookingHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingHistoryModel {
  String? bookingid;
  String? operationType;
  String? organizationid;
  String? serviceid;
  String? customerid;
  DateTime? slotstart;
  DateTime? slotend;
  String? statusid;
  dynamic cancelremark;
  String? organizationname;
  String? servicename;
  String? customername;
  String? statusname;
  dynamic qrticketurl;
  bool? isactive;
  dynamic checkedintime;
  bool? ischeckedin;
  dynamic qrscannedtime;
  bool? isqrscanned;
  DateTime? createddate;
  dynamic updateddate;

  BookingHistoryModel({
    this.bookingid,
    this.operationType,
    this.organizationid,
    this.serviceid,
    this.customerid,
    this.slotstart,
    this.slotend,
    this.statusid,
    this.cancelremark,
    this.organizationname,
    this.servicename,
    this.customername,
    this.statusname,
    this.qrticketurl,
    this.isactive,
    this.checkedintime,
    this.ischeckedin,
    this.qrscannedtime,
    this.isqrscanned,
    this.createddate,
    this.updateddate,
  });

  BookingHistoryModel copyWith({
    String? bookingid,
    String? operationType,
    String? organizationid,
    String? serviceid,
    String? customerid,
    DateTime? slotstart,
    DateTime? slotend,
    String? statusid,
    dynamic cancelremark,
    String? organizationname,
    String? servicename,
    String? customername,
    String? statusname,
    dynamic qrticketurl,
    bool? isactive,
    dynamic checkedintime,
    bool? ischeckedin,
    dynamic qrscannedtime,
    bool? isqrscanned,
    DateTime? createddate,
    dynamic updateddate,
  }) => BookingHistoryModel(
    bookingid: bookingid ?? this.bookingid,
    operationType: operationType ?? this.operationType,
    organizationid: organizationid ?? this.organizationid,
    serviceid: serviceid ?? this.serviceid,
    customerid: customerid ?? this.customerid,
    slotstart: slotstart ?? this.slotstart,
    slotend: slotend ?? this.slotend,
    statusid: statusid ?? this.statusid,
    cancelremark: cancelremark ?? this.cancelremark,
    organizationname: organizationname ?? this.organizationname,
    servicename: servicename ?? this.servicename,
    customername: customername ?? this.customername,
    statusname: statusname ?? this.statusname,
    qrticketurl: qrticketurl ?? this.qrticketurl,
    isactive: isactive ?? this.isactive,
    checkedintime: checkedintime ?? this.checkedintime,
    ischeckedin: ischeckedin ?? this.ischeckedin,
    qrscannedtime: qrscannedtime ?? this.qrscannedtime,
    isqrscanned: isqrscanned ?? this.isqrscanned,
    createddate: createddate ?? this.createddate,
    updateddate: updateddate ?? this.updateddate,
  );

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      BookingHistoryModel(
        bookingid: json["BOOKINGID"],
        operationType: json["OPERATION_TYPE"],
        organizationid: json["ORGANIZATIONID"],
        serviceid: json["SERVICEID"],
        customerid: json["CUSTOMERID"],
        slotstart: json["SLOTSTART"] == null
            ? null
            : DateTime.parse(json["SLOTSTART"]),
        slotend: json["SLOTEND"] == null
            ? null
            : DateTime.parse(json["SLOTEND"]),
        statusid: json["STATUSID"],
        cancelremark: json["CANCELREMARK"],
        organizationname: json["ORGANIZATIONNAME"],
        servicename: json["SERVICENAME"],
        customername: json["CUSTOMERNAME"],
        statusname: json["STATUSNAME"],
        qrticketurl: json["QRTICKETURL"],
        isactive: json["ISACTIVE"],
        checkedintime: json["CHECKEDINTIME"],
        ischeckedin: json["ISCHECKEDIN"],
        qrscannedtime: json["QRSCANNEDTIME"],
        isqrscanned: json["ISQRSCANNED"],
        createddate: json["CREATEDDATE"] == null
            ? null
            : DateTime.parse(json["CREATEDDATE"]),
        updateddate: json["UPDATEDDATE"],
      );

  Map<String, dynamic> toJson() => {
    "BOOKINGID": bookingid,
    "OPERATION_TYPE": operationType,
    "ORGANIZATIONID": organizationid,
    "SERVICEID": serviceid,
    "CUSTOMERID": customerid,
    "SLOTSTART": slotstart?.toIso8601String(),
    "SLOTEND": slotend?.toIso8601String(),
    "STATUSID": statusid,
    "CANCELREMARK": cancelremark,
    "ORGANIZATIONNAME": organizationname,
    "SERVICENAME": servicename,
    "CUSTOMERNAME": customername,
    "STATUSNAME": statusname,
    "QRTICKETURL": qrticketurl,
    "ISACTIVE": isactive,
    "CHECKEDINTIME": checkedintime,
    "ISCHECKEDIN": ischeckedin,
    "QRSCANNEDTIME": qrscannedtime,
    "ISQRSCANNED": isqrscanned,
    "CREATEDDATE": createddate?.toIso8601String(),
    "UPDATEDDATE": updateddate,
  };
}
