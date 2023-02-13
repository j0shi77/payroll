/// status : 200
/// message : "Ok"
/// data : [{"id":385,"full_name":"rido panca sakti","employee_id":"TADS385","job_position_name":null}]

class TimeOffEmployeeList {
  TimeOffEmployeeList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TimeOffEmployeeList.fromJson(dynamic json) {
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
TimeOffEmployeeList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => TimeOffEmployeeList(  status: status ?? _status,
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

/// id : 385
/// full_name : "rido panca sakti"
/// employee_id : "TADS385"
/// job_position_name : null

class Data {
  Data({
      num? id, 
      String? fullName, 
      String? employeeId, 
      dynamic jobPositionName,}){
    _id = id;
    _fullName = fullName;
    _employeeId = employeeId;
    _jobPositionName = jobPositionName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _employeeId = json['employee_id'];
    _jobPositionName = json['job_position_name'];
  }
  num? _id;
  String? _fullName;
  String? _employeeId;
  dynamic _jobPositionName;
Data copyWith({  num? id,
  String? fullName,
  String? employeeId,
  dynamic jobPositionName,
}) => Data(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  employeeId: employeeId ?? _employeeId,
  jobPositionName: jobPositionName ?? _jobPositionName,
);
  num? get id => _id;
  String? get fullName => _fullName;
  String? get employeeId => _employeeId;
  dynamic get jobPositionName => _jobPositionName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['employee_id'] = _employeeId;
    map['job_position_name'] = _jobPositionName;
    return map;
  }

}