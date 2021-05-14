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