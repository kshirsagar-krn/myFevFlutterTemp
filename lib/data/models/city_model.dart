import 'dart:convert';

List<CityModel> cityModelFromJson(String str) =>
    List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  String? cityid;
  String? cityname;

  CityModel({this.cityid, this.cityname});

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(cityid: json["CITYID"], cityname: json["CITYNAME"]);

  Map<String, dynamic> toJson() => {"CITYID": cityid, "CITYNAME": cityname};

  // ✅ ADD THESE - CRITICAL FOR DROPDOWN
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CityModel && other.cityid == cityid;
  }

  @override
  int get hashCode => cityid.hashCode;

  @override
  String toString() {
    return 'CityModel($cityname, $cityid)';
  }
}
