class Category {
late int _id;
late String _name;
late String _icon;
late int _level;

  int get id => _id;
  String get name => _name;
  String get icon => _icon;
  int get level => _level;

  Category({
      required int id,
      required String name,
      required String icon,
      required int level}){
    _id = id;
    _name = name;
    _icon = icon;
    _level = level;
}

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    if(json["icon"]==null)
      _icon ="";
    else _icon = json["icon"];
    _level = json["level"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    map["level"] = _level;
    return map;
  }

}