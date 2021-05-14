class ProductDetailed {
 late int _id;
 late String _name;
 late String _sku;
 late String _description;
 late String _shortDescription;
 late String _highlight;
 late String _typeId;
 late bool _active;
 late bool _visibility;
 late bool _promotion;
 late int _orderCount;
 late bool _freeShip;
 late Category _category;
 late String _categories;
 late String _brand;
 late String _material;
 late  String _purpose;
 late String _suitableSeason;
 late String _madeIn;
 late int _promotionPercent;
 late int _totalQuantity;
 late List<Attributes> _attributes;
 late List<Option_products> _optionProducts;

  int get id => _id;
  String get name => _name;
  String get sku => _sku;
  String get description => _description;
  String get shortDescription => _shortDescription;
  String get highlight => _highlight;
  String get typeId => _typeId;
  bool get active => _active;
  bool get visibility => _visibility;
  bool get promotion => _promotion;
  int get orderCount => _orderCount;
  bool get freeShip => _freeShip;
  Category get category => _category;
  String get categories => _categories;
  String get brand => _brand;
  String get material => _material;
  String get purpose => _purpose;
  String get suitableSeason => _suitableSeason;
  String get madeIn => _madeIn;
  int get promotionPercent => _promotionPercent;
  int get totalQuantity => _totalQuantity;
  List<Attributes> get attributes => _attributes;
  List<Option_products> get optionProducts => _optionProducts;

  ProductDetailed({
    required  int id,
   required   String name,
   required   String sku,
   required   String description,
   required   String shortDescription,
   required   String highlight,
   required   String typeId,
   required   bool active,
   required   bool visibility,
   required   bool promotion,
   required   int orderCount,
   required   bool freeShip,
   required   Category category,
   required   String categories,
   required   String brand,
   required   String material,
   required   String purpose,
   required   String suitableSeason,
   required   String madeIn,
   required   int promotionPercent,
   required   int totalQuantity,
   required   List<Attributes> attributes,
   required   List<Option_products> optionProducts}){
    _id = id;
    _name = name;
    _sku = sku;
    _description = description;
    _shortDescription = shortDescription;
    _highlight = highlight;
    _typeId = typeId;
    _active = active;
    _visibility = visibility;
    _promotion = promotion;
    _orderCount = orderCount;
    _freeShip = freeShip;
    _category = category;
    _categories = categories;
    _brand = brand;
    _material = material;
    _purpose = purpose;
    _suitableSeason = suitableSeason;
    _madeIn = madeIn;
    _promotionPercent = promotionPercent;
    _totalQuantity = totalQuantity;
    _attributes = attributes;
    _optionProducts = optionProducts;
}

  ProductDetailed.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _sku = json["sku"];
    _description = json["description"];
    _shortDescription = json["shortDescription"];
    _highlight = json["highlight"];
    _typeId = json["typeId"];
    _active = json["active"];
    _visibility = json["visibility"];
    _promotion = json["promotion"];
    _orderCount = json["orderCount"];
    _freeShip = json["freeShip"];
    _category = (json["category"] != null ? Category.fromJson(json["category"]) : null)!;
    _categories = json["categories"];
    _brand = json["brand"];
    _material = json["material"];
    _purpose = json["purpose"];
    _suitableSeason = json["suitable_season"];
    _madeIn = json["madeIn"];
    _promotionPercent = json["promotionPercent"];
    _totalQuantity = json["total_quantity"];
    if (json["attributes"] != null) {
      _attributes = [];
      json["attributes"].forEach((v) {
        _attributes.add(Attributes.fromJson(v));
      });
    }
    if (json["option_products"] != null) {
      _optionProducts = [];
      json["option_products"].forEach((v) {
        _optionProducts.add(Option_products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["sku"] = _sku;
    map["description"] = _description;
    map["shortDescription"] = _shortDescription;
    map["highlight"] = _highlight;
    map["typeId"] = _typeId;
    map["active"] = _active;
    map["visibility"] = _visibility;
    map["promotion"] = _promotion;
    map["orderCount"] = _orderCount;
    map["freeShip"] = _freeShip;
    if (_category != null) {
      map["category"] = _category.toJson();
    }
    map["categories"] = _categories;
    map["brand"] = _brand;
    map["material"] = _material;
    map["purpose"] = _purpose;
    map["suitable_season"] = _suitableSeason;
    map["madeIn"] = _madeIn;
    map["promotionPercent"] = _promotionPercent;
    map["total_quantity"] = _totalQuantity;
    if (_attributes != null) {
      map["attributes"] = _attributes.map((v) => v.toJson()).toList();
    }
    if (_optionProducts != null) {
      map["option_products"] = _optionProducts.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Option_products {
late Price _price;
late Quantity _quantity;
late List<Option> _option;

  Price get price => _price;
  Quantity get quantity => _quantity;
  List<Option> get option => _option;

  Option_products({
  required    Price price,
  required    Quantity quantity,
  required    List<Option> option}){
    _price = price;
    _quantity = quantity;
    _option = option;
}

  Option_products.fromJson(dynamic json) {
    _price = (json["price"] != null ? Price.fromJson(json["price"]) : null)!;
    _quantity = (json["quantity"] != null ? Quantity.fromJson(json["quantity"]) : null)!;
    if (json["option"] != null) {
      _option = [];
      json["option"].forEach((v) {
        _option.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_price != null) {
      map["price"] = _price.toJson();
    }
    if (_quantity != null) {
      map["quantity"] = _quantity.toJson();
    }
    if (_option != null) {
      map["option"] = _option.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Option {
 late int _id;
 late String _value;

  int get id => _id;
  String get value => _value;

  Option({
    required  int id,
    required  String value}){
    _id = id;
    _value = value;
}

  Option.fromJson(dynamic json) {
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
    required  int id,
    required  int value}){
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
 late int _value;

  int get id => _id;
  int get value => _value;

  Price({
   required   int id,
   required   int value}){
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

class Attributes {
late int _id;
late  String _type;
late  String _label;
late  String _code;
late  List<Options> _options;

  int get id => _id;
  String get type => _type;
  String get label => _label;
  String get code => _code;
  List<Options> get options => _options;

  Attributes({
   required   int id,
   required   String type,
   required   String label,
   required   String code,
   required   List<Options> options}){
    _id = id;
    _type = type;
    _label = label;
    _code = code;
    _options = options;
}

  Attributes.fromJson(dynamic json) {
    _id = json["id"];
    _type = json["type"];
    _label = json["label"];
    _code = json["code"];
    if (json["options"] != null) {
      _options = [];
      json["options"].forEach((v) {
        _options.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["type"] = _type;
    map["label"] = _label;
    map["code"] = _code;
    if (_options != null) {
      map["options"] = _options.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Options {
 late int _id;
 late String _value;

  int get id => _id;
  String get value => _value;

  Options({
    required  int id,
   required   String value}){
    _id = id;
    _value = value;
}

  Options.fromJson(dynamic json) {
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

class Category {
late  int _id;
late  String _name;
late  dynamic _icon;
late  int _level;
late  List<dynamic> _categories;

  int get id => _id;
  String get name => _name;
  dynamic get icon => _icon;
  int get level => _level;
  List<dynamic> get categories => _categories;

  Category({
  required   int id,
  required   String name,
  required   dynamic icon,
  required   int level,
  required   List<dynamic> categories}){
    _id = id;
    _name = name;
    _icon = icon;
    _level = level;
    _categories = categories;
}

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
    _level = json["level"];
    if (json["categories"] != null) {
      _categories = [];
      json["categories"].forEach((v) {
        _categories=[];
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    map["level"] = _level;
    if (_categories != null) {
      map["categories"] = _categories.map((v) => v.toJson()).toList();
    }
    return map;
  }

}