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
  late Brand? _brand;
  late String _material;
  late String _purpose;
  late String _suitableSeason;
  late String _madeIn;
  late int _promotionPercent;
  late int _totalQuantity;
  late Ratings _ratings;
  late RatingStar _ratingStar;
  late List<Attributes> _attributes;
  late List<Option_products> _optionProducts;
  late bool _isLiked;

  Ratings get ratings =>_ratings;
  RatingStar get ratingStar => _ratingStar;
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


  Brand? get brand => _brand;

  String get material => _material;

  String get purpose => _purpose;

  String get suitableSeason => _suitableSeason;

  String get madeIn => _madeIn;

  int get promotionPercent => _promotionPercent;

  int get totalQuantity => _totalQuantity;

  List<Attributes> get attributes => _attributes;

  List<Option_products> get optionProducts => _optionProducts;
  bool get isLiked => _isLiked;
  set isLiked(bool a) {_isLiked =a;}

  ProductDetailed(
      {required int id,
      required String name,
      required String sku,
      required String description,
      required String shortDescription,
      required String highlight,
      required String typeId,
      required bool active,
      required bool visibility,
      required bool promotion,
      required int orderCount,
      required bool freeShip,
      required Category category,
      required String categories,
      required Brand? brand,
      required String material,
      required String purpose,
      required String suitableSeason,
      required String madeIn,
        required Ratings ratings,
        required RatingStar ratingStar,
      required int promotionPercent,
      required int totalQuantity,
      required List<Attributes> attributes,
      required List<Option_products> optionProducts,
      required bool isLiked,}) {
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
    _brand = brand;
    _material = material;
    _purpose = purpose;
    _ratings =ratings;
    _ratingStar=ratingStar;
    _suitableSeason = suitableSeason;
    _madeIn = madeIn;
    _promotionPercent = promotionPercent;
    _totalQuantity = totalQuantity;
    _attributes = attributes;
    _optionProducts = optionProducts;
    _isLiked=isLiked;
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
    _category = (json["category"] != null
        ? Category.fromJson(json["category"])
        : null)!;
    _brand =  json["brand"] !=null?
    Brand.fromJson(json["brand"])
    : null;
    _material = json["material"];
    _ratings = (json["ratings"] != null ? Ratings.fromJson(json["ratings"]) : null)!;
    _ratingStar = (json["ratingStar"] != null ? RatingStar.fromJson(json["ratingStar"]) : null)!;
    _purpose = json["purpose"];
    _suitableSeason = json["suitable_season"];
    _madeIn = json["madeIn"] ?? "";
    _promotionPercent = (json["promotionPercent"] as double).toInt();
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
    _isLiked=json["liked"];
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

    map["brand"] = _brand;
    map["material"] = _material;
    if (_ratings != null) {
      map["ratings"] = _ratings.toJson();
    }
    if (_ratingStar != null) {
      map["ratingStar"] = _ratingStar.toJson();
    }
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
class Brand {
  int? _id;
  String? _name;
  String? _icon;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;

  Brand({
    int? id,
    String? name,
    String? icon}){
    _id = id;
    _name = name;
    _icon = icon;
  }

  Brand.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    return map;
  }

}

class Option_products {
  late int _productOptionId;
  late Price _price;
  late Quantity _quantity;
  late List<Option> _option;

  Price get price => _price;

  Quantity get quantity => _quantity;

  List<Option> get option => _option;
  int get productOptionId => _productOptionId;

  Option_products(
      {required int productOptionId,
        required Price price,
      required Quantity quantity,
      required List<Option> option}) {
    _productOptionId=productOptionId;
    _price = price;
    _quantity = quantity;
    _option = option;
  }

  Option_products.fromJson(dynamic json) {
    _productOptionId= json["product_option_id"];
    _price = (json["price"] != null ? Price.fromJson(json["price"]) : null)!;
    _quantity = (json["quantity"] != null
        ? Quantity.fromJson(json["quantity"])
        : null)!;
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

  Option({required int id, required String value}) {
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

  Quantity({required int id, required int value}) {
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

  Price({required int id, required double value}) {
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
  late String _type;
  late String _label;
  late String _code;
  late List<Options> _options;

  int get id => _id;

  String get type => _type;

  String get label => _label;

  String get code => _code;

  List<Options> get options => _options;

  Attributes(
      {required int id,
      required String type,
      required String label,
      required String code,
      required List<Options> options}) {
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

  Options({required int id, required String value}) {
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
  late int _id;
  late String _name;
  late dynamic _icon;
  late int _level;
  late List<dynamic> _categories;

  int get id => _id;

  String get name => _name;

  dynamic get icon => _icon;

  int get level => _level;

  List<dynamic> get categories => _categories;

  Category(
      {required int id,
      required String name,
      required dynamic icon,
      required int level,
      required List<dynamic> categories}) {
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
        _categories = [];
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

class RatingStar {
  late int _id;
  late int _star1;
  late int _star2;
  late int _star3;
  late int _star4;
  late int _star5;

  int get id => _id;

  int get star1 => _star1;

  int get star2 => _star2;

  int get star3 => _star3;

  int get star4 => _star4;

  int get star5 => _star5;

  RatingStar(
      {required int id,
      required int star1,
      required int star2,
      required int star3,
      required int star4,
      required int star5}) {
    _id = id;
    _star1 = star1;
    _star2 = star2;
    _star3 = star3;
    _star4 = star4;
    _star5 = star5;
  }

  RatingStar.fromJson(dynamic json) {
    _id = json["id"];
    _star1 = json["star1"];
    _star2 = json["star2"];
    _star3 = json["star3"];
    _star4 = json["star4"];
    _star5 = json["star5"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["star1"] = _star1;
    map["star2"] = _star2;
    map["star3"] = _star3;
    map["star4"] = _star4;
    map["star5"] = _star5;
    return map;
  }
}

class Ratings {
  late List<Listrating> _listrating;
  late TotalCount _totalCount;

  List<Listrating> get listrating => _listrating;
  TotalCount get totalCount => _totalCount;
  Ratings({required List<Listrating> listrating,required TotalCount totalCount}) {
    _listrating = listrating;
    _totalCount =totalCount;
  }

  Ratings.fromJson(dynamic json) {
    if (json["list-rating"] != []) {
      _listrating = [];
      json["list-rating"].forEach((v) {
        _listrating.add(Listrating.fromJson(v));
      });
    }
    else _listrating=[];
    if(json["total_count"]!=null)
      {
          _totalCount=TotalCount.fromJson(json["total_count"]);
      }

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_listrating != null) {
      map["list-rating"] = _listrating.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Listrating {
  late String _imageAvatar;
  late String _comment;
  late int _star;
  late String _timeUpdated;
  late List<String> _imageRating;
  late String? _size;
  late String? _color;
  late int _ratingId;
  late String _userName;

  String get imageAvatar => _imageAvatar;

  String get comment => _comment;

  int get star => _star;

  String get timeUpdated => _timeUpdated;

  List<String> get imageRating => _imageRating;

  String? get size => _size;

  String? get color => _color;

  int get ratingId => _ratingId;

  String get userName => _userName;


  Listrating(
      {required String imageAvatar,
      required String comment,
      required int star,
      required String timeUpdated,
      required List<String> imageRating,
      required String size,
      required String color,
      required int ratingId,
      required String userName,
      required int customerId}) {
    _imageAvatar = imageAvatar;
    _comment = comment;
    _star = star;
    _timeUpdated = timeUpdated;
    _imageRating = imageRating;
    _size = size;
    _color = color;
    _ratingId = ratingId;
    _userName = userName;
  }

  Listrating.fromJson(dynamic json) {
    if(json["image-avatar"]==null)
      _imageAvatar="";
   else _imageAvatar = json["image_avatar"];
    if(json["comment"]==null)
      _comment="";
   else _comment = json["comment"];
    _star = json["star"];
    _timeUpdated = json["time_updated"];
    if (json["file_rating"] != []) {
      _imageRating=[];
      json["file_rating"].forEach((v) {
        _imageRating.add(v);
      });
    }
    else _imageRating=[];
    if(json["size"] ==null)
      _size="";
  else  _size = json["size"];

    _color = json["color"];
    _ratingId = json["rating_id"];
    _userName = json["user_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image-avatar"] = _imageAvatar;
    map["comment"] = _comment;
    map["star"] = _star;
    map["time-updated"] = _timeUpdated;
    map["images-rating"] = _imageRating;

    map["size"] = _size;
    map["color"] = _color;
    map["rating_id"] = _ratingId;
    map["user_name"] = _userName;
    return map;
  }
}


class TotalCount {
  late int _totalAll;
  late int _totalImage;
  late int _totalStar1;
  late int _totalStar2;
  late int _totalStar3;
  late int _totalStar4;
  late int _totalStar5;

  int get totalAll => _totalAll;
  int get totalImage => _totalImage;
  int get totalStar1 => _totalStar1;
  int get totalStar2 => _totalStar2;
  int get totalStar3 => _totalStar3;
  int get totalStar4 => _totalStar4;
  int get totalStar5 => _totalStar5;

  TotalCount({
    required   int totalAll,
    required   int totalImage,
    required   int totalStar1,
    required   int totalStar2,
    required   int totalStar3,
    required   int totalStar4,
    required   int totalStar5}){
    _totalAll = totalAll;
    _totalImage = totalImage;
    _totalStar1 = totalStar1;
    _totalStar2 = totalStar2;
    _totalStar3 = totalStar3;
    _totalStar4 = totalStar4;
    _totalStar5 = totalStar5;
  }

  TotalCount.fromJson(dynamic json) {
    _totalAll = json["total_all"];
    _totalImage = json["total_image"];
    _totalStar1 = json["total_star1"];
    _totalStar2 = json["total_star2"];
    _totalStar3 = json["total_star3"];
    _totalStar4 = json["total_star4"];
    _totalStar5 = json["total_star5"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total_all"] = _totalAll;
    map["total_image"] = _totalImage;
    map["total_star1"] = _totalStar1;
    map["total_star2"] = _totalStar2;
    map["total_star3"] = _totalStar3;
    map["total_star4"] = _totalStar4;
    map["total_star5"] = _totalStar5;
    return map;
  }

}


class ProductOption {

  late List<Attributes> _attributes;
  late List<Option_products> _optionProducts;
  List<Attributes> get attributes => _attributes;

  List<Option_products> get optionProducts => _optionProducts;
  ProductOption(
      {
        required List<Attributes> attributes,
        required List<Option_products> optionProducts,
      }) {

    _attributes = attributes;
    _optionProducts = optionProducts;
  }

  ProductOption.fromJson(dynamic json) {

    if (json["attributes"] != null) {
      _attributes = [];
      json["attributes"].forEach((v) {
        _attributes.add(Attributes.fromJson(v));
      });
    }
    if (json["product-options"] != null) {
      _optionProducts = [];
      json["product-options"].forEach((v) {
        _optionProducts.add(Option_products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if (_attributes != null) {
      map["attributes"] = _attributes.map((v) => v.toJson()).toList();
    }
    if (_optionProducts != null) {
      map["product-options"] = _optionProducts.map((v) => v.toJson()).toList();
    }
    return map;
  }
}