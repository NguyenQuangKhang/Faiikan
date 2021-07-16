class Brand {
  int? _id;
  String? _name;
  String? _icon;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;

  Brand({
      int? id, 
      String? name, 
      String? icon}){
    _id = id;
    _name = name;
    _icon = icon;
}

  Brand.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    return map;
  }

}