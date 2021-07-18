class FlashSaleProduct {
  int? _id;
  int? _percentDiscount;
  int? _quantity;
  int? _saleAmount;
  Product_item? _productItem;

  int? get id => _id;
  int? get percentDiscount => _percentDiscount;
  int? get quantity => _quantity;
  int? get saleAmount => _saleAmount;
  Product_item? get productItem => _productItem;

  FlashSaleProduct({
      int? id, 
      int? percentDiscount, 
      int? quantity, 
      int? saleAmount, 
      Product_item? productItem}){
    _id = id;
    _percentDiscount = percentDiscount;
    _quantity = quantity;
    _saleAmount = saleAmount;
    _productItem = productItem;
}

  FlashSaleProduct.fromJson(dynamic json) {
    _id = json["id"];
    _percentDiscount = json["percentDiscount"];
    _quantity = json["quantity"];
    _saleAmount = json["saleAmount"];
    _productItem = json["product_item"] != null ? Product_item.fromJson(json["product_item"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["percentDiscount"] = _percentDiscount;
    map["quantity"] = _quantity;
    map["saleAmount"] = _saleAmount;
    if (_productItem != null) {
      map["product_item"] = _productItem?.toJson();
    }
    return map;
  }

}

class Product_item {
  String? _name;
  Category? _category;
  Price? _price;
  String? _brand;
  int? _id;
  bool? _freeShipping;
  double? _promotionPercent;
  int? _orderCount;
  String? _imgUrl;
  double? _percentStar;
  int? _countRating;
  int? _quantity;
  String? _shortDescription;

  String? get name => _name;
  Category? get category => _category;
  Price? get price => _price;
  String? get brand => _brand;
  int? get id => _id;
  bool? get freeShipping => _freeShipping;
  double? get promotionPercent => _promotionPercent;
  int? get orderCount => _orderCount;
  String? get imgUrl => _imgUrl;
  double? get percentStar => _percentStar;
  int? get countRating => _countRating;
  int? get quantity => _quantity;
  String? get shortDescription => _shortDescription;

  Product_item({
      String? name, 
      Category? category, 
      Price? price, 
      String? brand, 
      int? id, 
      bool? freeShipping, 
      double? promotionPercent,
      int? orderCount, 
      String? imgUrl, 
      double? percentStar, 
      int? countRating, 
      int? quantity, 
      String? shortDescription}){
    _name = name;
    _category = category;
    _price = price;
    _brand = brand;
    _id = id;
    _freeShipping = freeShipping;
    _promotionPercent = promotionPercent;
    _orderCount = orderCount;
    _imgUrl = imgUrl;
    _percentStar = percentStar;
    _countRating = countRating;
    _quantity = quantity;
    _shortDescription = shortDescription;
}

  Product_item.fromJson(dynamic json) {
    _name = json["name"];
    _category = json["category"] != null ? Category.fromJson(json["category"]) : null;
    _price = json["price"] != null ? Price.fromJson(json["price"]) : null;
    _brand = json["brand"];
    _id = json["id"];
    _freeShipping = json["free_shipping"];
    _promotionPercent = json["promotion_percent"];
    _orderCount = json["order_count"];
    _imgUrl = json["img_url"];
    _percentStar = json["percent_star"];
    _countRating = json["count_rating"];
    _quantity = json["quantity"];
    _shortDescription = json["short_description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    if (_category != null) {
      map["category"] = _category?.toJson();
    }
    if (_price != null) {
      map["price"] = _price?.toJson();
    }
    map["brand"] = _brand;
    map["id"] = _id;
    map["free_shipping"] = _freeShipping;
    map["promotion_percent"] = _promotionPercent;
    map["order_count"] = _orderCount;
    map["img_url"] = _imgUrl;
    map["percent_star"] = _percentStar;
    map["count_rating"] = _countRating;
    map["quantity"] = _quantity;
    map["short_description"] = _shortDescription;
    return map;
  }

}

class Price {
  double? _priceMax;
  double? _priceMin;

  double? get priceMax => _priceMax;
  double? get priceMin => _priceMin;

  Price({
      double? priceMax,
      double? priceMin}){
    _priceMax = priceMax;
    _priceMin = priceMin;
}

  Price.fromJson(dynamic json) {
    _priceMax = json["price_max"];
    _priceMin = json["price_min"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["price_max"] = _priceMax;
    map["price_min"] = _priceMin;
    return map;
  }

}

class Category {
  int? _id;
  String? _name;
  String? _icon;
  int? _level;
  String? _path;
  String? _pathVarchar;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  int? get level => _level;
  String? get path => _path;
  String? get pathVarchar => _pathVarchar;

  Category({
      int? id, 
      String? name, 
      String? icon, 
      int? level, 
      String? path, 
      String? pathVarchar}){
    _id = id;
    _name = name;
    _icon = icon;
    _level = level;
    _path = path;
    _pathVarchar = pathVarchar;
}

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
    _level = json["level"];
    _path = json["path"];
    _pathVarchar = json["pathVarchar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    map["level"] = _level;
    map["path"] = _path;
    map["pathVarchar"] = _pathVarchar;
    return map;
  }

}