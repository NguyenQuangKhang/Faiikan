class User {
  int? _id;
  String? _name;
  String? _email;
  String? _birthday;
  String? _phoneNumber;
  String? _sex;
  String? _address;
  bool? _active;
  String? _timeCreated;
  String? _timeUpdated;
  ImageAvatar? _imageAvatar;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get birthday => _birthday;
  String? get phoneNumber => _phoneNumber;
  String? get sex => _sex;
  String? get address => _address;
  bool? get active => _active;
  String? get timeCreated => _timeCreated;
  String? get timeUpdated => _timeUpdated;
  ImageAvatar? get imageAvatar => _imageAvatar;
  set id(int? id){this.id=id;}

  User({
      int? id,
      String? name,
      String? email,
      String? birthday,
      String? phoneNumber,
      String? sex,
      String? address,
      bool? active,
      String? timeCreated,
      String? timeUpdated,
      ImageAvatar? imageAvatar}){
    _id = id;
    _name = name;
    _email = email;
    _birthday = birthday;
    _phoneNumber = phoneNumber;
    _sex = sex;
    _address = address;
    _active = active;
    _timeCreated = timeCreated;
    _timeUpdated = timeUpdated;
    _imageAvatar = imageAvatar;
}

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _birthday = json["birthday"];
    _phoneNumber = json["phoneNumber"];
    _sex = json["sex"];
    _address = json["address"];
    _active = json["active"];
    _timeCreated = json["timeCreated"];
    _timeUpdated = json["timeUpdated"];
    _imageAvatar = json["imageAvatar"] != null ? ImageAvatar.fromJson(json["imageAvatar"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["birthday"] = _birthday;
    map["phoneNumber"] = _phoneNumber;
    map["sex"] = _sex;
    map["address"] = _address;
    map["active"] = _active;
    map["timeCreated"] = _timeCreated;
    map["timeUpdated"] = _timeUpdated;
    if (_imageAvatar != null) {
      map["imageAvatar"] = _imageAvatar!.toJson();
    }
    return map;
  }

}

class ImageAvatar {
  String? _link;

  String? get link => _link;

  ImageAvatar({
      String? link}){
    _link = link;
}

  ImageAvatar.fromJson(dynamic json) {
    _link = json["link"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["link"] = _link;
    return map;
  }

}