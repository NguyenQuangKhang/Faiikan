class OrderDetail {
  int? _id;
  Address? _address;
  Shipping? _shipping;
  Payment? _payment;
  double? _grandPrice;
  double? _subTotal;
  double? _shippingFee;
  double? _discount;
  String? _content;
  String? _createdAt;
  String? _updatedAt;
  String? _payAt;
  List<ListItem>? _listItem;

  int? get id => _id;
  Address? get address => _address;
  Shipping? get shipping => _shipping;
  Payment? get payment => _payment;
  double? get grandPrice => _grandPrice;
  double? get subTotal => _subTotal;
  double? get shippingFee => _shippingFee;
  double? get discount => _discount;
  String? get content => _content;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get payAt => _payAt;
  List<ListItem>? get listItem => _listItem;

  OrderDetail({
      int? id, 
      Address? address, 
      Shipping? shipping, 
      Payment? payment, 
      double? grandPrice,
      double? subTotal,
      double? shippingFee,
      double? discount,
      String? content, 
      String? createdAt, 
      String? updatedAt, 
      String? payAt, 
      List<ListItem>? listItem}){
    _id = id;
    _address = address;
    _shipping = shipping;
    _payment = payment;
    _grandPrice = grandPrice;
    _subTotal = subTotal;
    _shippingFee = shippingFee;
    _discount = discount;
    _content = content;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _payAt = payAt;
    _listItem = listItem;
}

  OrderDetail.fromJson(dynamic json) {
    _id = json["id"];
    _address = json["address"] != null ? Address.fromJson(json["address"]) : null;
    _shipping = json["shipping"] != null ? Shipping.fromJson(json["shipping"]) : null;
    _payment = json["payment"] != null ? Payment.fromJson(json["payment"]) : null;
    _grandPrice = json["grandPrice"];
    _subTotal = json["subTotal"];
    _shippingFee = json["shippingFee"];
    _discount = json["discount"];
    _content = json["content"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _payAt = json["payAt"];
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
    if (_address != null) {
      map["address"] = _address?.toJson();
    }
    if (_shipping != null) {
      map["shipping"] = _shipping?.toJson();
    }
    if (_payment != null) {
      map["payment"] = _payment?.toJson();
    }
    map["grandPrice"] = _grandPrice;
    map["subTotal"] = _subTotal;
    map["shippingFee"] = _shippingFee;
    map["discount"] = _discount;
    map["content"] = _content;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["payAt"] = _payAt;
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

class Payment {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Payment({
      int? id, 
      String? name}){
    _id = id;
    _name = name;
}

  Payment.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

class Shipping {
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Shipping({
      int? id, 
      String? name}){
    _id = id;
    _name = name;
}

  Shipping.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

class Address {
  int? _id;
  String? _specificAddress;
  String? _name;
  String? _numberPhone;
  String? _createdAt;
  String? _updateAt;
  bool? _defaultIs;
  Province? _province;
  District? _district;
  Ward? _ward;

  int? get id => _id;
  String? get specificAddress => _specificAddress;
  String? get name => _name;
  String? get numberPhone => _numberPhone;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  bool? get defaultIs => _defaultIs;
  Province? get province => _province;
  District? get district => _district;
  Ward? get ward => _ward;

  Address({
      int? id, 
      String? specificAddress, 
      String? name, 
      String? numberPhone, 
      String? createdAt, 
      String? updateAt, 
      bool? defaultIs, 
      Province? province, 
      District? district, 
      Ward? ward}){
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
    _province = json["province"] != null ? Province.fromJson(json["province"]) : null;
    _district = json["district"] != null ? District.fromJson(json["district"]) : null;
    _ward = json["ward"] != null ? Ward.fromJson(json["ward"]) : null;
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
      map["province"] = _province?.toJson();
    }
    if (_district != null) {
      map["district"] = _district?.toJson();
    }
    if (_ward != null) {
      map["ward"] = _ward?.toJson();
    }
    return map;
  }

}

class Ward {
  int? _id;
  String? _name;
  String? _prefix;

  int? get id => _id;
  String? get name => _name;
  String? get prefix => _prefix;

  Ward({
      int? id, 
      String? name, 
      String? prefix}){
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
  int? _id;
  String? _name;
  String? _prefix;

  int? get id => _id;
  String? get name => _name;
  String? get prefix => _prefix;

  District({
      int? id, 
      String? name, 
      String? prefix}){
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
  int? _id;
  String? _name;
  String? _code;

  int? get id => _id;
  String? get name => _name;
  String? get code => _code;

  Province({
      int? id, 
      String? name, 
      String? code}){
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