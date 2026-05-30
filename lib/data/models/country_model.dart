import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
  json.decode(str).map((x) => CountryModel.fromJson(x)),
);

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  String? countryid;
  String? countryname;

  CountryModel({this.countryid, this.countryname});

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    countryid: json["COUNTRYID"],
    countryname: json["COUNTRYNAME"],
  );

  Map<String, dynamic> toJson() => {
    "COUNTRYID": countryid,
    "COUNTRYNAME": countryname,
  };

  // ✅ ADD THESE - CRITICAL FOR DROPDOWN
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryModel && other.countryid == countryid;
  }

  @override
  int get hashCode => countryid.hashCode;

  @override
  String toString() {
    return 'CountryModel($countryname, $countryid)';
  }
}
