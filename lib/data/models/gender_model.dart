import 'dart:convert';

List<GenderModel> genderModelFromJson(String str) => List<GenderModel>.from(
  json.decode(str).map((x) => GenderModel.fromJson(x)),
);

String genderModelToJson(List<GenderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenderModel {
  String? genderId;
  String? genderName;

  GenderModel({this.genderId, this.genderName});

  factory GenderModel.fromJson(Map<String, dynamic> json) =>
      GenderModel(genderId: json["GENDERID"], genderName: json["GENDERNAME"]);

  Map<String, dynamic> toJson() => {
    "GENDERID": genderId,
    "GENDERNAME": genderName,
  };

  // ✅ ADD THESE - CRITICAL FOR DROPDOWN
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GenderModel && other.genderId == genderId;
  }

  @override
  int get hashCode => genderId.hashCode;

  @override
  String toString() {
    return 'GenderModel($genderName, $genderId)';
  }
}
