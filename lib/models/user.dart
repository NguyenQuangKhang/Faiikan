class User {
  int? _id;
  String? _name;
  String? _email;
  String? _birthday;
  String? _phoneNumber;
  String? _sex;
  bool? _active;
  String? _timeCreated;
  String? _timeUpdated;
  String? _imageUrl;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get birthday => _birthday;
  String? get phoneNumber => _phoneNumber;
  String? get sex => _sex;
  bool? get active => _active;
  String? get timeCreated => _timeCreated;
  String? get timeUpdated => _timeUpdated;
  String? get imageUrl => _imageUrl;


  User({
      int? id, 
      String? name, 
      String? email, 
      String? birthday, 
      String? phoneNumber, 
      String? sex, 
      bool? active, 
      String? timeCreated, 
      String? timeUpdated, 
      String? imageUrl}){
    _id = id;
    _name = name;
    _email = email;
    _birthday = birthday;
    _phoneNumber = phoneNumber;
    _sex = sex;
    _active = active;
    _timeCreated = timeCreated;
    _timeUpdated = timeUpdated;
    _imageUrl = imageUrl;
}

  User.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _email = json["email"];
    _birthday = json["birthday"];
    _phoneNumber = json["phoneNumber"];
    _sex = json["sex"];
    _active = json["active"];
    _timeCreated = json["timeCreated"];
    _timeUpdated = json["timeUpdated"];
    _imageUrl = json["image_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["email"] = _email;
    map["birthday"] = _birthday;
    map["phoneNumber"] = _phoneNumber;
    map["sex"] = _sex;
    map["active"] = _active;
    map["timeCreated"] = _timeCreated;
    map["timeUpdated"] = _timeUpdated;
    map["image_url"] = _imageUrl;
    return map;
  }

}