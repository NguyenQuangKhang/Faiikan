class CartItem {
late int _cartId;
late int _productId;
late String _nameProduct;
late int _amount;
late OptionProduct _optionProduct;
bool isChosen=false;
  int get cartId => _cartId;
  int get productId => _productId;
  String get nameProduct => _nameProduct;
  int get amount => _amount;
  OptionProduct get optionProduct => _optionProduct;
  set optionProduct(OptionProduct o) {_optionProduct=o;}
   set amount(int i) {_amount=i;}
  CartItem({
   required   int cartId,
   required   int productId,
   required   String nameProduct,
   required   int amount,
   required   OptionProduct optionProduct}){
    _cartId = cartId;
    _productId = productId;
    _nameProduct = nameProduct;
    _amount = amount;
    _optionProduct = optionProduct;
}

  CartItem.fromJson(dynamic json) {
    _cartId = json["cart-id"];
    _productId = json["product-id"];
    _nameProduct = json["name-product"];
    _amount = json["amount"];
    _optionProduct = (json["option-product"] != null ? OptionProduct.fromJson(json["option-product"]) : null)!;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cart-id"] = _cartId;
    map["product-id"] = _productId;
    map["name-product"] = _nameProduct;
    map["amount"] = _amount;
    if (_optionProduct != null) {
      map["option-product"] = _optionProduct.toJson();
    }
    return map;
  }

}

class OptionProduct {
late  int _productOptionId;
late  Price _price;
late  Quantity _quantity;
late  Color _color;
late  Size _size;
late  Image _image;

  int get productOptionId => _productOptionId;
  Price get price => _price;
  Quantity get quantity => _quantity;
  Color get color => _color;
  Size get size => _size;
  Image get image => _image;

  OptionProduct({
  required    int productOptionId,
  required    Price price,
  required    Quantity quantity,
  required    Color color,
  required    Size size,
  required    Image image}){
    _productOptionId = productOptionId;
    _price = price;
    _quantity = quantity;
    _color = color;
    _size = size;
    _image = image;
}

  OptionProduct.fromJson(dynamic json) {
    _productOptionId = json["product-option-id"];
    _price = (json["price"] != null ? Price.fromJson(json["price"]) : null)!;
    _quantity = (json["quantity"] != null ? Quantity.fromJson(json["quantity"]) : null)!;
    _color = (json["color"] != null ? Color.fromJson(json["color"]) : null)!;
    _size = (json["size"] != null ? Size.fromJson(json["size"]) : null)!;
    _image = (json["image"] != null ? Image.fromJson(json["image"]) : null)!;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product-option-id"] = _productOptionId;
    if (_price != null) {
      map["price"] = _price.toJson();
    }
    if (_quantity != null) {
      map["quantity"] = _quantity.toJson();
    }
    if (_color != null) {
      map["color"] = _color.toJson();
    }
    if (_size != null) {
      map["size"] = _size.toJson();
    }
    if (_image != null) {
      map["image"] = _image.toJson();
    }
    return map;
  }

}

class Image {
late  int _id;
 late String _value;

  int get id => _id;
  String get value => _value;

  Image({
   required   int id,
  required    String value}){
    _id = id;
    _value = value;
}

  Image.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}

class Size {
  late int _id;
 late String _value;

  int get id => _id;
  String get value => _value;

  Size({
    required  int id,
      required String value}){
    _id = id;
    _value = value;
}

  Size.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}

class Color {
  late int _id;
 late String _value;

  int get id => _id;
  String get value => _value;

  Color({
    required  int id,
    required  String value}){
    _id = id;
    _value = value;
}

  Color.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}

class Quantity {
  late int _id;
  late int _value;

  int get id => _id;
  int get value => _value;

  Quantity({
   required   int id,
   required   int value}){
    _id = id;
    _value = value;
}

  Quantity.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}

class Price {
 late int _id;
 late double _value;

  int get id => _id;
  double get value => _value;

  Price({
    required  int id,
    required  double value}){
    _id = id;
    _value = value;
}

  Price.fromJson(dynamic json) {
    _id = json["id"];
    _value = json["value"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["value"] = _value;
    return map;
  }

}