// To parse this JSON data, do
//
//     final organizationModel = organizationModelFromJson(jsonString);

import 'dart:convert';

List<OrganizationModel> organizationModelFromJson(String str) =>
    List<OrganizationModel>.from(
      json.decode(str).map((x) => OrganizationModel.fromJson(x)),
    );

String organizationModelToJson(List<OrganizationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrganizationModel {
  String? organizationid;
  String? categoryid;
  String? organizationname;
  String? gstnumber;
  String? categoryname;
  double? latitude;
  double? longitude;
  String? mobilenumber;
  String? email;
  String? weburl;
  String? contactpersonname;
  String? contactpersonmobilenumber;
  int? cancelbookingtime;
  dynamic passwordhash;
  String? logourl;
  String? openingtime;
  String? closingtime;
  String? breakstarttime;
  String? breakendtime;
  dynamic services;
  String? address;
  bool? isactive;
  DateTime? createddate;
  dynamic createdby;
  DateTime? updateddate;
  String? updatedby;
  String? operationType;
  String? isactiveStatus;
  String? action;
  String? viewFile;
  bool? isqrgenerated;
  String? qrfilepath;
  String? qr;
  DateTime? qrgenerateddate;
  DateTime? serviceenddate;
  DateTime? servicestartdate;
  double? serviceamount;
  int? missedappointmentlimit;
  int? blockdurationdays;
  int? advancebookingdays;

  OrganizationModel({
    this.organizationid,
    this.categoryid,
    this.organizationname,
    this.gstnumber,
    this.categoryname,
    this.latitude,
    this.longitude,
    this.mobilenumber,
    this.email,
    this.weburl,
    this.contactpersonname,
    this.contactpersonmobilenumber,
    this.cancelbookingtime,
    this.passwordhash,
    this.logourl,
    this.openingtime,
    this.closingtime,
    this.breakstarttime,
    this.breakendtime,
    this.services,
    this.address,
    this.isactive,
    this.createddate,
    this.createdby,
    this.updateddate,
    this.updatedby,
    this.operationType,
    this.isactiveStatus,
    this.action,
    this.viewFile,
    this.isqrgenerated,
    this.qrfilepath,
    this.qr,
    this.qrgenerateddate,
    this.serviceenddate,
    this.servicestartdate,
    this.serviceamount,
    this.missedappointmentlimit,
    this.blockdurationdays,
    this.advancebookingdays,
  });

  OrganizationModel copyWith({
    String? organizationid,
    String? categoryid,
    String? organizationname,
    String? gstnumber,
    String? categoryname,
    double? latitude,
    double? longitude,
    String? mobilenumber,
    String? email,
    String? weburl,
    String? contactpersonname,
    String? contactpersonmobilenumber,
    int? cancelbookingtime,
    dynamic passwordhash,
    String? logourl,
    String? openingtime,
    String? closingtime,
    String? breakstarttime,
    String? breakendtime,
    dynamic services,
    String? address,
    bool? isactive,
    DateTime? createddate,
    dynamic createdby,
    DateTime? updateddate,
    String? updatedby,
    String? operationType,
    String? isactiveStatus,
    String? action,
    String? viewFile,
    bool? isqrgenerated,
    String? qrfilepath,
    String? qr,
    DateTime? qrgenerateddate,
    DateTime? serviceenddate,
    DateTime? servicestartdate,
    double? serviceamount,
    int? missedappointmentlimit,
    int? blockdurationdays,
    int? advancebookingdays,
  }) => OrganizationModel(
    organizationid: organizationid ?? this.organizationid,
    categoryid: categoryid ?? this.categoryid,
    organizationname: organizationname ?? this.organizationname,
    gstnumber: gstnumber ?? this.gstnumber,
    categoryname: categoryname ?? this.categoryname,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    mobilenumber: mobilenumber ?? this.mobilenumber,
    email: email ?? this.email,
    weburl: weburl ?? this.weburl,
    contactpersonname: contactpersonname ?? this.contactpersonname,
    contactpersonmobilenumber:
        contactpersonmobilenumber ?? this.contactpersonmobilenumber,
    cancelbookingtime: cancelbookingtime ?? this.cancelbookingtime,
    passwordhash: passwordhash ?? this.passwordhash,
    logourl: logourl ?? this.logourl,
    openingtime: openingtime ?? this.openingtime,
    closingtime: closingtime ?? this.closingtime,
    breakstarttime: breakstarttime ?? this.breakstarttime,
    breakendtime: breakendtime ?? this.breakendtime,
    services: services ?? this.services,
    address: address ?? this.address,
    isactive: isactive ?? this.isactive,
    createddate: createddate ?? this.createddate,
    createdby: createdby ?? this.createdby,
    updateddate: updateddate ?? this.updateddate,
    updatedby: updatedby ?? this.updatedby,
    operationType: operationType ?? this.operationType,
    isactiveStatus: isactiveStatus ?? this.isactiveStatus,
    action: action ?? this.action,
    viewFile: viewFile ?? this.viewFile,
    isqrgenerated: isqrgenerated ?? this.isqrgenerated,
    qrfilepath: qrfilepath ?? this.qrfilepath,
    qr: qr ?? this.qr,
    qrgenerateddate: qrgenerateddate ?? this.qrgenerateddate,
    serviceenddate: serviceenddate ?? this.serviceenddate,
    servicestartdate: servicestartdate ?? this.servicestartdate,
    serviceamount: serviceamount ?? this.serviceamount,
    missedappointmentlimit:
        missedappointmentlimit ?? this.missedappointmentlimit,
    blockdurationdays: blockdurationdays ?? this.blockdurationdays,
    advancebookingdays: advancebookingdays ?? this.advancebookingdays,
  );

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        organizationid: json["ORGANIZATIONID"],
        categoryid: json["CATEGORYID"],
        organizationname: json["ORGANIZATIONNAME"],
        gstnumber: json["GSTNUMBER"],
        categoryname: json["CATEGORYNAME"],
        latitude: json["LATITUDE"]?.toDouble(),
        longitude: json["LONGITUDE"]?.toDouble(),
        mobilenumber: json["MOBILENUMBER"],
        email: json["EMAIL"],
        weburl: json["WEBURL"],
        contactpersonname: json["CONTACTPERSONNAME"],
        contactpersonmobilenumber: json["CONTACTPERSONMOBILENUMBER"],
        cancelbookingtime: json["CANCELBOOKINGTIME"],
        passwordhash: json["PASSWORDHASH"],
        logourl: json["LOGOURL"],
        openingtime: json["OPENINGTIME"],
        closingtime: json["CLOSINGTIME"],
        breakstarttime: json["BREAKSTARTTIME"],
        breakendtime: json["BREAKENDTIME"],
        services: json["SERVICES"],
        address: json["ADDRESS"],
        isactive: json["ISACTIVE"],
        createddate: json["CREATEDDATE"] == null
            ? null
            : DateTime.parse(json["CREATEDDATE"]),
        createdby: json["CREATEDBY"],
        updateddate: json["UPDATEDDATE"] == null
            ? null
            : DateTime.parse(json["UPDATEDDATE"]),
        updatedby: json["UPDATEDBY"],
        operationType: json["OPERATION_TYPE"],
        isactiveStatus: json["ISACTIVE_STATUS"],
        action: json["Action"],
        viewFile: json["ViewFile"],
        isqrgenerated: json["ISQRGENERATED"],
        qrfilepath: json["QRFILEPATH"],
        qr: json["QR"],
        qrgenerateddate: json["QRGENERATEDDATE"] == null
            ? null
            : DateTime.parse(json["QRGENERATEDDATE"]),
        serviceenddate: json["SERVICEENDDATE"] == null
            ? null
            : DateTime.parse(json["SERVICEENDDATE"]),
        servicestartdate: json["SERVICESTARTDATE"] == null
            ? null
            : DateTime.parse(json["SERVICESTARTDATE"]),
        serviceamount: json["SERVICEAMOUNT"]?.toDouble(),
        missedappointmentlimit: json["MISSEDAPPOINTMENTLIMIT"],
        blockdurationdays: json["BLOCKDURATIONDAYS"],
        advancebookingdays: json["ADVANCEBOOKINGDAYS"],
      );

  Map<String, dynamic> toJson() => {
    "ORGANIZATIONID": organizationid,
    "CATEGORYID": categoryid,
    "ORGANIZATIONNAME": organizationname,
    "GSTNUMBER": gstnumber,
    "CATEGORYNAME": categoryname,
    "LATITUDE": latitude,
    "LONGITUDE": longitude,
    "MOBILENUMBER": mobilenumber,
    "EMAIL": email,
    "WEBURL": weburl,
    "CONTACTPERSONNAME": contactpersonname,
    "CONTACTPERSONMOBILENUMBER": contactpersonmobilenumber,
    "CANCELBOOKINGTIME": cancelbookingtime,
    "PASSWORDHASH": passwordhash,
    "LOGOURL": logourl,
    "OPENINGTIME": openingtime,
    "CLOSINGTIME": closingtime,
    "BREAKSTARTTIME": breakstarttime,
    "BREAKENDTIME": breakendtime,
    "SERVICES": services,
    "ADDRESS": address,
    "ISACTIVE": isactive,
    "CREATEDDATE": createddate?.toIso8601String(),
    "CREATEDBY": createdby,
    "UPDATEDDATE": updateddate?.toIso8601String(),
    "UPDATEDBY": updatedby,
    "OPERATION_TYPE": operationType,
    "ISACTIVE_STATUS": isactiveStatus,
    "Action": action,
    "ViewFile": viewFile,
    "ISQRGENERATED": isqrgenerated,
    "QRFILEPATH": qrfilepath,
    "QR": qr,
    "QRGENERATEDDATE": qrgenerateddate?.toIso8601String(),
    "SERVICEENDDATE": serviceenddate?.toIso8601String(),
    "SERVICESTARTDATE": servicestartdate?.toIso8601String(),
    "SERVICEAMOUNT": serviceamount,
    "MISSEDAPPOINTMENTLIMIT": missedappointmentlimit,
    "BLOCKDURATIONDAYS": blockdurationdays,
    "ADVANCEBOOKINGDAYS": advancebookingdays,
  };
}
