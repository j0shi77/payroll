/// status : 200
/// message : "Failed, shift_id invalid"
/// data : [{"id":79,"name":"dayoff","schedule_in":"00:00","schedule_out":"00:00"},{"id":80,"name":"M","schedule_in":"08:00","schedule_out":"18:00"},{"id":40,"name":"P","schedule_in":"12:00","schedule_out":"22:00"}]

class ShiftMaster {
  ShiftMaster({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ShiftMaster.fromJson(dynamic json) {
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
ShiftMaster copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => ShiftMaster(  status: status ?? _status,
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

/// id : 79
/// name : "dayoff"
/// schedule_in : "00:00"
/// schedule_out : "00:00"

class Data {
  Data({
      num? id, 
      String? name, 
      String? scheduleIn, 
      String? scheduleOut,}){
    _id = id;
    _name = name;
    _scheduleIn = scheduleIn;
    _scheduleOut = scheduleOut;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _scheduleIn = json['schedule_in'];
    _scheduleOut = json['schedule_out'];
  }
  num? _id;
  String? _name;
  String? _scheduleIn;
  String? _scheduleOut;
Data copyWith({  num? id,
  String? name,
  String? scheduleIn,
  String? scheduleOut,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  scheduleIn: scheduleIn ?? _scheduleIn,
  scheduleOut: scheduleOut ?? _scheduleOut,
);
  num? get id => _id;
  String? get name => _name;
  String? get scheduleIn => _scheduleIn;
  String? get scheduleOut => _scheduleOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['schedule_in'] = _scheduleIn;
    map['schedule_out'] = _scheduleOut;
    return map;
  }

}