class FlashSalePeriod {
  int? _id;
  String? _startTime;
  String? _endTime;
  String? _date;
  String? _status;

  int? get id => _id;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get date => _date;
  String? get status => _status;

  FlashSalePeriod({
      int? id, 
      String? startTime, 
      String? endTime, 
      String? date, 
      String? status}){
    _id = id;
    _startTime = startTime;
    _endTime = endTime;
    _date = date;
    _status = status;
}

  FlashSalePeriod.fromJson(dynamic json) {
    _id = json["id"];
    _startTime = json["startTime"];
    _endTime = json["endTime"];
    _date = json["date"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    map["date"] = _date;
    map["status"] = _status;
    return map;
  }

}