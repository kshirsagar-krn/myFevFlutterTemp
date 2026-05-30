import 'dart:convert';

List<StateModel> stateModelFromJson(String str) =>
    List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  String? stateid;
  String? statename;

  StateModel({this.stateid, this.statename});

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      StateModel(stateid: json["STATEID"], statename: json["STATENAME"]);

  Map<String, dynamic> toJson() => {"STATEID": stateid, "STATENAME": statename};

  // ✅ ADD THESE - CRITICAL FOR DROPDOWN
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateModel && other.stateid == stateid;
  }

  @override
  int get hashCode => stateid.hashCode;

  @override
  String toString() {
    return 'StateModel($statename, $stateid)';
  }
}
