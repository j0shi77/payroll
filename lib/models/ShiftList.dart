/// status : 200
/// message : "Ok"
/// data : [{"id":12,"date":"2023-02-07","new_shift_name":"M","schedule_in":"08:00","schedule_out":"18:00","status":"CANCELED"}]

class ShiftList {
  ShiftList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ShiftList.fromJson(dynamic json) {
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
ShiftList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => ShiftList(  status: status ?? _status,
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

/// id : 12
/// date : "2023-02-07"
/// new_shift_name : "M"
/// schedule_in : "08:00"
/// schedule_out : "18:00"
/// status : "CANCELED"

class Data {
  Data({
      num? id, 
      String? date, 
      String? newShiftName, 
      String? scheduleIn, 
      String? scheduleOut, 
      String? status,}){
    _id = id;
    _date = date;
    _newShiftName = newShiftName;
    _scheduleIn = scheduleIn;
    _scheduleOut = scheduleOut;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _newShiftName = json['new_shift_name'];
    _scheduleIn = json['schedule_in'];
    _scheduleOut = json['schedule_out'];
    _status = json['status'];
  }
  num? _id;
  String? _date;
  String? _newShiftName;
  String? _scheduleIn;
  String? _scheduleOut;
  String? _status;
Data copyWith({  num? id,
  String? date,
  String? newShiftName,
  String? scheduleIn,
  String? scheduleOut,
  String? status,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  newShiftName: newShiftName ?? _newShiftName,
  scheduleIn: scheduleIn ?? _scheduleIn,
  scheduleOut: scheduleOut ?? _scheduleOut,
  status: status ?? _status,
);
  num? get id => _id;
  String? get date => _date;
  String? get newShiftName => _newShiftName;
  String? get scheduleIn => _scheduleIn;
  String? get scheduleOut => _scheduleOut;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['new_shift_name'] = _newShiftName;
    map['schedule_in'] = _scheduleIn;
    map['schedule_out'] = _scheduleOut;
    map['status'] = _status;
    return map;
  }

}