/// status : 200
/// message : "Ok"
/// data : [{"id":6,"date":"2023-01-18","clock_in":"08:00:00","clock_out":"18:00:00","status":"APPROVED"}]

class AttendanceRequestList {
  AttendanceRequestList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AttendanceRequestList.fromJson(dynamic json) {
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
AttendanceRequestList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => AttendanceRequestList(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  void setMessage(String message){
    _message = message;
  }

  void setStatus(num status){
    _status = status;
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

/// id : 6
/// date : "2023-01-18"
/// clock_in : "08:00:00"
/// clock_out : "18:00:00"
/// status : "APPROVED"

class Data {
  Data({
      num? id, 
      String? date, 
      String? clockIn, 
      String? clockOut, 
      String? status,}){
    _id = id;
    _date = date;
    _clockIn = clockIn;
    _clockOut = clockOut;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _clockIn = json['clock_in'];
    _clockOut = json['clock_out'];
    _status = json['status'];
  }
  num? _id;
  String? _date;
  String? _clockIn;
  String? _clockOut;
  String? _status;
Data copyWith({  num? id,
  String? date,
  String? clockIn,
  String? clockOut,
  String? status,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  clockIn: clockIn ?? _clockIn,
  clockOut: clockOut ?? _clockOut,
  status: status ?? _status,
);
  num? get id => _id;
  String? get date => _date;
  String? get clockIn => _clockIn;
  String? get clockOut => _clockOut;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['clock_in'] = _clockIn;
    map['clock_out'] = _clockOut;
    map['status'] = _status;
    return map;
  }

}