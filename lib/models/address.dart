class Address {
late  int _id;
late  String _specificAddress;
late  String _name;
late  String _numberPhone;
late  String _createdAt;
late  String _updateAt;
late  bool _defaultIs;
late  Province _province;
late  District _district;
late  Ward _ward;

  int get id => _id;
  String get specificAddress => _specificAddress;
  String get name => _name;
  String get numberPhone => _numberPhone;
  String get createdAt => _createdAt;
  String get updateAt => _updateAt;
  bool get defaultIs => _defaultIs;
  Province get province => _province;
  District get district => _district;
  Ward get ward => _ward;

  Address({
   required   int id,
   required   String specificAddress,
   required   String name,
   required   String numberPhone,
   required   String createdAt,
   required   String updateAt,
   required   bool defaultIs,
   required   Province province,
   required   District district,
   required   Ward ward}){
    _id = id;
    _specificAddress = specificAddress;
    _name = name;
    _numberPhone = numberPhone;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _defaultIs = defaultIs;
    _province = province;
    _district = district;
    _ward = ward;
}

  Address.fromJson(dynamic json) {
    _id = json["id"];
    _specificAddress = json["specificAddress"];
    _name = json["name"];
    _numberPhone = json["numberPhone"];
    _createdAt = json["createdAt"];
    _updateAt = json["updateAt"];
    _defaultIs = json["defaultIs"];
    _province = (json["province"] != null ? Province.fromJson(json["province"]) : null)!;
    _district = (json["district"] != null ? District.fromJson(json["district"]) : null)!;
    _ward = (json["ward"] != null ? Ward.fromJson(json["ward"]) : null)!;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["specificAddress"] = _specificAddress;
    map["name"] = _name;
    map["numberPhone"] = _numberPhone;
    map["createdAt"] = _createdAt;
    map["updateAt"] = _updateAt;
    map["defaultIs"] = _defaultIs;
    if (_province != null) {
      map["province"] = _province.toJson();
    }
    if (_district != null) {
      map["district"] = _district.toJson();
    }
    if (_ward != null) {
      map["ward"] = _ward.toJson();
    }
    return map;
  }

}

class Ward {
late  int _id;
late  String _name;
late  String _prefix;

  int get id => _id;
  String get name => _name;
  String get prefix => _prefix;

  Ward({
  required    int id,
  required    String name,
  required    String prefix}){
    _id = id;
    _name = name;
    _prefix = prefix;
}

  Ward.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _prefix = json["prefix"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["prefix"] = _prefix;
    return map;
  }

}

class District {
late  int _id;
late  String _name;
late  String _prefix;

  int get id => _id;
  String get name => _name;
  String get prefix => _prefix;

  District({
   required   int id,
   required   String name,
   required   String prefix}){
    _id = id;
    _name = name;
    _prefix = prefix;
}

  District.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _prefix = json["prefix"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["prefix"] = _prefix;
    return map;
  }

}

class Province {
late  int _id;
late  String _name;
late  String _code;

  int get id => _id;
  String get name => _name;
  String get code => _code;

  Province({
  required    int id,
  required    String name,
  required    String code}){
    _id = id;
    _name = name;
    _code = code;
}

  Province.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["code"] = _code;
    return map;
  }

}