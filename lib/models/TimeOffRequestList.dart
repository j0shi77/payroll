/// status : 200
/// message : "Ok"
/// data : [{"id":18,"date":"2023-01-20","time_off_name":"Cuti","status":"REQUEST"}]

class TimeOffRequestList {
  TimeOffRequestList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TimeOffRequestList.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<Data>? _data;
TimeOffRequestList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => TimeOffRequestList(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  setStatus(num status){
    _status = status;
  }

  setMessage(String message){
    _message = message;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 18
/// date : "2023-01-20"
/// time_off_name : "Cuti"
/// status : "REQUEST"

class Data {
  Data({
      num? id, 
      String? date, 
      String? timeOffName, 
      String? status,}){
    _id = id;
    _date = date;
    _timeOffName = timeOffName;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _timeOffName = json['time_off_name'];
    _status = json['status'];
  }
  num? _id;
  String? _date;
  String? _timeOffName;
  String? _status;
Data copyWith({  num? id,
  String? date,
  String? timeOffName,
  String? status,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  timeOffName: timeOffName ?? _timeOffName,
  status: status ?? _status,
);
  num? get id => _id;
  String? get date => _date;
  String? get timeOffName => _timeOffName;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['time_off_name'] = _timeOffName;
    map['status'] = _status;
    return map;
  }

}