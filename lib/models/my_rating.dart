class MyRating {
  int? _id;
  int? _userId;
  String? _userName;
  String? _imageAvatar;
  int? _star;
  String? _size;
  String? _color;
  int? _idProduct;
  int? _idProductOption;
  String? _nameProduct;
  String? _imageProduct;
  String? _comment;
  List<FileRating>? _fileRating;
  String? _timeUpdated;

  int? get id => _id;
  int? get userId => _userId;
  String? get userName => _userName;
  String? get imageAvatar => _imageAvatar;
  int? get star => _star;
  String? get size => _size;
  String? get color => _color;
  int? get idProduct => _idProduct;
  int? get idProductOption => _idProductOption;
  String? get nameProduct => _nameProduct;
  String? get imageProduct => _imageProduct;
  String? get comment => _comment;
  List<FileRating>? get fileRating => _fileRating;
  String? get timeUpdated => _timeUpdated;

  MyRating({
      int? id, 
      int? userId, 
      String? userName, 
      String? imageAvatar, 
      int? star, 
      String? size, 
      String? color, 
      int? idProduct, 
      int? idProductOption, 
      String? nameProduct, 
      String? imageProduct, 
      String? comment, 
      List<FileRating>? fileRating, 
      String? timeUpdated}){
    _id = id;
    _userId = userId;
    _userName = userName;
    _imageAvatar = imageAvatar;
    _star = star;
    _size = size;
    _color = color;
    _idProduct = idProduct;
    _idProductOption = idProductOption;
    _nameProduct = nameProduct;
    _imageProduct = imageProduct;
    _comment = comment;
    _fileRating = fileRating;
    _timeUpdated = timeUpdated;
}

  MyRating.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["userId"];
    _userName = json["userName"];
    _imageAvatar = json["imageAvatar"];
    _star = json["star"];
    _size = json["size"];
    _color = json["color"];
    _idProduct = json["idProduct"];
    _idProductOption = json["idProductOption"];
    _nameProduct = json["nameProduct"];
    _imageProduct = json["imageProduct"];
    _comment = json["comment"];
    if (json["fileRating"] != null) {
      _fileRating = [];
      json["fileRating"].forEach((v) {
        _fileRating?.add(FileRating.fromJson(v));
      });
    }
    _timeUpdated = json["timeUpdated"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["userId"] = _userId;
    map["userName"] = _userName;
    map["imageAvatar"] = _imageAvatar;
    map["star"] = _star;
    map["size"] = _size;
    map["color"] = _color;
    map["idProduct"] = _idProduct;
    map["idProductOption"] = _idProductOption;
    map["nameProduct"] = _nameProduct;
    map["imageProduct"] = _imageProduct;
    map["comment"] = _comment;
    if (_fileRating != null) {
      map["fileRating"] = _fileRating?.map((v) => v.toJson()).toList();
    }
    map["timeUpdated"] = _timeUpdated;
    return map;
  }

}

class FileRating {
  String? _id;
  String? _linkUrl;
  String? _contentType;

  String? get id => _id;
  String? get linkUrl => _linkUrl;
  String? get contentType => _contentType;

  FileRating({
      String? id, 
      String? linkUrl, 
      String? contentType}){
    _id = id;
    _linkUrl = linkUrl;
    _contentType = contentType;
}

  FileRating.fromJson(dynamic json) {
    _id = json["id"];
    _linkUrl = json["link_url"];
    _contentType = json["content_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["link_url"] = _linkUrl;
    map["content_type"] = _contentType;
    return map;
  }

}