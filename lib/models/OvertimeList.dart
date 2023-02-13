/// status : 200
/// message : "Ok"
/// data : [{"id":18,"date":"2023-01-20","compensation_type":"paid_overtime","status":"REQUEST"}]

class OvertimeList {
  OvertimeList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OvertimeList.fromJson(dynamic json) {
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
OvertimeList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => OvertimeList(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;

  void setStatus(num? status){
    _status = status;
  }

  void setMessage(String? message){
    _message = message;
  }

  List<Data>? get data => _data;

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
/// compensation_type : "paid_overtime"
/// status : "REQUEST"

class Data {
  Data({
      num? id, 
      String? date, 
      String? compensationType, 
      String? status,}){
    _id = id;
    _date = date;
    _compensationType = compensationType;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _compensationType = json['compensation_type'];
    _status = json['status'];
  }
  num? _id;
  String? _date;
  String? _compensationType;
  String? _status;
Data copyWith({  num? id,
  String? date,
  String? compensationType,
  String? status,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  compensationType: compensationType ?? _compensationType,
  status: status ?? _status,
);
  num? get id => _id;
  String? get date => _date;
  String? get compensationType => _compensationType;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['compensation_type'] = _compensationType;
    map['status'] = _status;
    return map;
  }

}