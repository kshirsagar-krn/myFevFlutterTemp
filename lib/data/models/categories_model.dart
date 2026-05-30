// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) =>
    List<CategoriesModel>.from(
      json.decode(str).map((x) => CategoriesModel.fromJson(x)),
    );

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  String? categoryid;
  String? categoryname;
  String? description;
  bool? isactive;
  DateTime? createddate;
  String? createdby;
  DateTime? updateddate;
  String? updatedby;
  String? operationType;
  String? action;
  String? isactiveStatus;

  CategoriesModel({
    this.categoryid,
    this.categoryname,
    this.description,
    this.isactive,
    this.createddate,
    this.createdby,
    this.updateddate,
    this.updatedby,
    this.operationType,
    this.action,
    this.isactiveStatus,
  });

  CategoriesModel copyWith({
    String? categoryid,
    String? categoryname,
    String? description,
    bool? isactive,
    DateTime? createddate,
    String? createdby,
    DateTime? updateddate,
    String? updatedby,
    String? operationType,
    String? action,
    String? isactiveStatus,
  }) => CategoriesModel(
    categoryid: categoryid ?? this.categoryid,
    categoryname: categoryname ?? this.categoryname,
    description: description ?? this.description,
    isactive: isactive ?? this.isactive,
    createddate: createddate ?? this.createddate,
    createdby: createdby ?? this.createdby,
    updateddate: updateddate ?? this.updateddate,
    updatedby: updatedby ?? this.updatedby,
    operationType: operationType ?? this.operationType,
    action: action ?? this.action,
    isactiveStatus: isactiveStatus ?? this.isactiveStatus,
  );

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categoryid: json["CATEGORYID"],
        categoryname: json["CATEGORYNAME"],
        description: json["DESCRIPTION"],
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
        action: json["Action"],
        isactiveStatus: json["ISACTIVE_STATUS"],
      );

  Map<String, dynamic> toJson() => {
    "CATEGORYID": categoryid,
    "CATEGORYNAME": categoryname,
    "DESCRIPTION": description,
    "ISACTIVE": isactive,
    "CREATEDDATE": createddate?.toIso8601String(),
    "CREATEDBY": createdby,
    "UPDATEDDATE": updateddate?.toIso8601String(),
    "UPDATEDBY": updatedby,
    "OPERATION_TYPE": operationType,
    "Action": action,
    "ISACTIVE_STATUS": isactiveStatus,
  };
}
