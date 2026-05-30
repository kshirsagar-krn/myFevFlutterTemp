// To parse this JSON data, do
//
//     final organizationDetailsModel = organizationDetailsModelFromJson(jsonString);

import 'dart:convert';

OrganizationDetailsModel organizationDetailsModelFromJson(String str) =>
    OrganizationDetailsModel.fromJson(json.decode(str));

String organizationDetailsModelToJson(OrganizationDetailsModel data) =>
    json.encode(data.toJson());

class OrganizationDetailsModel {
  OrganizationMaster? organizationMaster;
  List<Service>? services;

  OrganizationDetailsModel({this.organizationMaster, this.services});

  OrganizationDetailsModel copyWith({
    OrganizationMaster? organizationMaster,
    List<Service>? services,
  }) => OrganizationDetailsModel(
    organizationMaster: organizationMaster ?? this.organizationMaster,
    services: services ?? this.services,
  );

  factory OrganizationDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrganizationDetailsModel(
        organizationMaster: json["OrganizationMaster"] == null
            ? null
            : OrganizationMaster.fromJson(json["OrganizationMaster"]),
        services: json["Services"] == null
            ? []
            : List<Service>.from(
                json["Services"]!.map((x) => Service.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "OrganizationMaster": organizationMaster?.toJson(),
    "Services": services == null
        ? []
        : List<dynamic>.from(services!.map((x) => x.toJson())),
  };
}

class OrganizationMaster {
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

  OrganizationMaster({
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

  OrganizationMaster copyWith({
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
  }) => OrganizationMaster(
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

  factory OrganizationMaster.fromJson(Map<String, dynamic> json) =>
      OrganizationMaster(
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

class Service {
  String? serviceid;
  String? organizationid;
  String? servicename;
  int? slotduration;
  bool? isactive;

  Service({
    this.serviceid,
    this.organizationid,
    this.servicename,
    this.slotduration,
    this.isactive,
  });

  Service copyWith({
    String? serviceid,
    String? organizationid,
    String? servicename,
    int? slotduration,
    bool? isactive,
  }) => Service(
    serviceid: serviceid ?? this.serviceid,
    organizationid: organizationid ?? this.organizationid,
    servicename: servicename ?? this.servicename,
    slotduration: slotduration ?? this.slotduration,
    isactive: isactive ?? this.isactive,
  );

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceid: json["SERVICEID"],
    organizationid: json["ORGANIZATIONID"],
    servicename: json["SERVICENAME"],
    slotduration: json["SLOTDURATION"],
    isactive: json["ISACTIVE"],
  );

  Map<String, dynamic> toJson() => {
    "SERVICEID": serviceid,
    "ORGANIZATIONID": organizationid,
    "SERVICENAME": servicename,
    "SLOTDURATION": slotduration,
    "ISACTIVE": isactive,
  };
}
