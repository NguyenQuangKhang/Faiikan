class Product {
late String _name;
late Price _price;
late int _id;
late bool _freeShipping;
late int _promotionPercent;
late int _orderCount;
late String _imgUrl;
late double _percentStar;
late int _countRating;
bool isLiked=true;

 String get name => _name;
 Price get price => _price;
 int get id => _id;
 bool get freeShipping => _freeShipping;
 int get promotionPercent => _promotionPercent;
 int get orderCount => _orderCount;
 String get imgUrl => _imgUrl;
 double get percentStar => _percentStar;
 int get countRating => _countRating;

  Product({
   required   String name,
   required   Price price,
   required   int id,
   required   bool freeShipping,
   required   int promotionPercent,
   required   int orderCount,
   required   String imgUrl,
   required   double percentStar,
   required   int countRating}){
    _name = name;
    _price = price;
    _id = id;
    _freeShipping = freeShipping;
    _promotionPercent = promotionPercent;
    _orderCount = orderCount;
    _imgUrl = imgUrl;
    _percentStar = percentStar;
    _countRating = countRating;
}

  Product.fromJson(dynamic json) {
    _name = json["name"];
    _price = (json["price"] != null ? Price.fromJson(json["price"]) : null)!;
    _id = json["id"];
    _freeShipping = json["free_shipping"];
    _promotionPercent = (json["promotion_percent"] as double).toInt();
    _orderCount = json["order_count"];
    _imgUrl = json["img_url"];
    _percentStar = json["percent_star"];
    _countRating = json["count_rating"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    if (_price != null) {
      map["price"] = _price.toJson();
    }
    map["id"] = _id;
    map["free_shipping"] = _freeShipping;
    map["promotion_percent"] = _promotionPercent;
    map["order_count"] = _orderCount;
    map["img_url"] = _imgUrl;
    map["percent_star"] = _percentStar;
    map["count_rating"] = _countRating;
    return map;
  }

}

class Price {
 late double _priceMax;
 late double _priceMin;
 double get priceMax => _priceMax;
 double get priceMin => _priceMin;

  Price({
   required  double priceMax,
   required  double priceMin}){
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
 late int _id;
 late String _name;
  dynamic _icon;
 late int _level;


  int get id => _id;
  String get name => _name;
  dynamic get icon => _icon;
  int get level => _level;


  Category({
      required int id,
      required String name,
      dynamic icon, 
      required int level,
      }){
    _id = id;
    _name = name;
    _icon = icon;
    _level = level;
}

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
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