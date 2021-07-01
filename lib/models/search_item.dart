class SearchItem {
late  String _keyword;
late  String _linkImage;

  String get keyword => _keyword;
  String get linkImage => _linkImage;

  SearchItem({
    required String keyword,
    required String linkImage}){
    _keyword = keyword;
    _linkImage = linkImage;
}

  SearchItem.fromJson(dynamic json) {
    _keyword = json["keyword"];
    _linkImage = json["linkImage"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["keyword"] = _keyword;
    map["linkImage"] = _linkImage;
    return map;
  }

}