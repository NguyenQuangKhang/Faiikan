class Order {
  int? _id;
  String? _status;
  String? _shipping;
  double? _grandPrice;
  List<ListItem>? _listItem;

  int? get id => _id;
  String? get status => _status;
  String? get shipping => _shipping;
  double? get grandPrice => _grandPrice;
  List<ListItem>? get listItem => _listItem;

  Order({
      int? id, 
      String? status, 
      String? shipping, 
      double? grandPrice,
      List<ListItem>? listItem}){
    _id = id;
    _status = status;
    _shipping = shipping;
    _grandPrice = grandPrice;
    _listItem = listItem;
}

  Order.fromJson(dynamic json) {
    _id = json["id"];
    _status = json["status"];
    _shipping = json["shipping"];
    _grandPrice = json["grandPrice"];
    if (json["listItem"] != null) {
      _listItem = [];
      json["listItem"].forEach((v) {
        _listItem?.add(ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["status"] = _status;
    map["shipping"] = _shipping;
    map["grandPrice"] = _grandPrice;
    if (_listItem != null) {
      map["listItem"] = _listItem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ListItem {
  int? _id;
  int? _productId;
  int? _productOptionId;
  double? _price;
  int? _quantity;
  String? _name;
  String? _color;
  String? _size;
  String? _imageUrl;

  int? get id => _id;
  int? get productId => _productId;
  int? get productOptionId => _productOptionId;
  double? get price => _price;
  int? get quantity => _quantity;
  String? get name => _name;
  String? get color => _color;
  String? get size => _size;
  String? get imageUrl => _imageUrl;

  ListItem({
      int? id, 
      int? productId, 
      int? productOptionId, 
      double? price,
      int? quantity, 
      String? name, 
      String? color, 
      String? size, 
      String? imageUrl}){
    _id = id;
    _productId = productId;
    _productOptionId = productOptionId;
    _price = price;
    _quantity = quantity;
    _name = name;
    _color = color;
    _size = size;
    _imageUrl = imageUrl;
}

  ListItem.fromJson(dynamic json) {
    _id = json["id"];
    _productId = json["productId"];
    _productOptionId = json["productOptionId"];
    _price = json["price"];
    _quantity = json["quantity"];
    _name = json["name"];
    _color = json["color"];
    _size = json["size"];
    _imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["productId"] = _productId;
    map["productOptionId"] = _productOptionId;
    map["price"] = _price;
    map["quantity"] = _quantity;
    map["name"] = _name;
    map["color"] = _color;
    map["size"] = _size;
    map["imageUrl"] = _imageUrl;
    return map;
  }

}