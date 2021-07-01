class InputOrderItem {
late  int _productId;
late  int _productOptionId;
late  String _imageUrl;
late  int _price;
late  int _quantity;

  int get productId => _productId;
  int get productOptionId => _productOptionId;
  String get imageUrl => _imageUrl;
  int get price => _price;
  int get quantity => _quantity;

  InputOrderItem({
 required    int productId,
 required    int productOptionId,
 required    String imageUrl,
 required    int price,
 required    int quantity}){
    _productId = productId;
    _productOptionId = productOptionId;
    _imageUrl = imageUrl;
    _price = price;
    _quantity = quantity;
}

  InputOrderItem.fromJson(dynamic json) {
    _productId = json["product_id"];
    _productOptionId = json["product_option_id"];
    _imageUrl = json["image_url"];
    _price = json["price"];
    _quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["product_id"] = _productId;
    map["product_option_id"] = _productOptionId;
    map["image_url"] = _imageUrl;
    map["price"] = _price;
    map["quantity"] = _quantity;
    return map;
  }

}