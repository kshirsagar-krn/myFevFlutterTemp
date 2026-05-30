// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? customerid;
  String? genderid;
  String? fullname;
  DateTime? dob;
  String? gendername;
  String? email;
  String? mobilenumber;
  String? address;
  String? pincode;
  String? countryid;
  String? countryname;
  String? stateid;
  String? statename;
  String? cityid;
  String? cityname;
  String? profileimage;
  bool? isactive;
  String? createdby;
  DateTime? createdate;
  dynamic updatedby;
  dynamic updatedate;

  UserModel({
    this.customerid,
    this.genderid,
    this.fullname,
    this.dob,
    this.gendername,
    this.email,
    this.mobilenumber,
    this.address,
    this.pincode,
    this.countryid,
    this.countryname,
    this.stateid,
    this.statename,
    this.cityid,
    this.cityname,
    this.profileimage,
    this.isactive,
    this.createdby,
    this.createdate,
    this.updatedby,
    this.updatedate,
  });

  UserModel copyWith({
    String? customerid,
    String? genderid,
    String? fullname,
    DateTime? dob,
    String? gendername,
    String? email,
    String? mobilenumber,
    String? address,
    String? pincode,
    String? countryid,
    String? countryname,
    String? stateid,
    String? statename,
    String? cityid,
    String? cityname,
    String? profileimage,
    bool? isactive,
    String? createdby,
    DateTime? createdate,
    dynamic updatedby,
    dynamic updatedate,
  }) => UserModel(
    customerid: customerid ?? this.customerid,
    genderid: genderid ?? this.genderid,
    fullname: fullname ?? this.fullname,
    dob: dob ?? this.dob,
    gendername: gendername ?? this.gendername,
    email: email ?? this.email,
    mobilenumber: mobilenumber ?? this.mobilenumber,
    address: address ?? this.address,
    pincode: pincode ?? this.pincode,
    countryid: countryid ?? this.countryid,
    countryname: countryname ?? this.countryname,
    stateid: stateid ?? this.stateid,
    statename: statename ?? this.statename,
    cityid: cityid ?? this.cityid,
    cityname: cityname ?? this.cityname,
    profileimage: profileimage ?? this.profileimage,
    isactive: isactive ?? this.isactive,
    createdby: createdby ?? this.createdby,
    createdate: createdate ?? this.createdate,
    updatedby: updatedby ?? this.updatedby,
    updatedate: updatedate ?? this.updatedate,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    customerid: json["CUSTOMERID"],
    genderid: json["GENDERID"],
    fullname: json["FULLNAME"],
    dob: json["DOB"] == null ? null : DateTime.parse(json["DOB"]),
    gendername: json["GENDERNAME"],
    email: json["EMAIL"],
    mobilenumber: json["MOBILENUMBER"],
    address: json["ADDRESS"],
    pincode: json["PINCODE"],
    countryid: json["COUNTRYID"],
    countryname: json["COUNTRYNAME"],
    stateid: json["STATEID"],
    statename: json["STATENAME"],
    cityid: json["CITYID"],
    cityname: json["CITYNAME"],
    profileimage: json["PROFILEIMAGE"],
    isactive: json["ISACTIVE"],
    createdby: json["CREATEDBY"],
    createdate: json["CREATEDATE"] == null
        ? null
        : DateTime.parse(json["CREATEDATE"]),
    updatedby: json["UPDATEDBY"],
    updatedate: json["UPDATEDATE"],
  );

  Map<String, dynamic> toJson() => {
    "CUSTOMERID": customerid,
    "GENDERID": genderid,
    "FULLNAME": fullname,
    "DOB": dob?.toIso8601String(),
    "GENDERNAME": gendername,
    "EMAIL": email,
    "MOBILENUMBER": mobilenumber,
    "ADDRESS": address,
    "PINCODE": pincode,
    "COUNTRYID": countryid,
    "COUNTRYNAME": countryname,
    "STATEID": stateid,
    "STATENAME": statename,
    "CITYID": cityid,
    "CITYNAME": cityname,
    "PROFILEIMAGE": profileimage,
    "ISACTIVE": isactive,
    "CREATEDBY": createdby,
    "CREATEDATE": createdate?.toIso8601String(),
    "UPDATEDBY": updatedby,
    "UPDATEDATE": updatedate,
  };
}
