/// status : 200
/// message : "Ok"
/// data : {"id":6,"full_name":"sakti tua petrus davici banjarnahor","position_name":"Marketing","request_date":"2022-01-11","date":"2023-01-18","clock_in":"08:00:00","clock_out":"18:00:00","note":null,"shift_name":"P","schedule_in":"12:00:00","schedule_out":"22:00:00","status":null,"approved_at":"2023-01-18","logs_status":[{"status":"REQUEST","created_at":"2023-01-18T05:51:14.000000Z","approved_by":null,"position_name":null,"description":"Waiting for approval"}]}

class AttendanceRequestDetail {
  AttendanceRequestDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AttendanceRequestDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
  AttendanceRequestDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => AttendanceRequestDetail(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  void setStatus( status ){
    _status = status;
  }

  void setMessage( message ){
    _message = message;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 6
/// full_name : "sakti tua petrus davici banjarnahor"
/// position_name : "Marketing"
/// request_date : "2022-01-11"
/// date : "2023-01-18"
/// clock_in : "08:00:00"
/// clock_out : "18:00:00"
/// note : null
/// shift_name : "P"
/// schedule_in : "12:00:00"
/// schedule_out : "22:00:00"
/// status : null
/// approved_at : "2023-01-18"
/// logs_status : [{"status":"REQUEST","created_at":"2023-01-18T05:51:14.000000Z","approved_by":null,"position_name":null,"description":"Waiting for approval"}]

class Data {
  Data({
      num? id, 
      String? fullName, 
      String? positionName, 
      String? requestDate, 
      String? date, 
      String? clockIn, 
      String? clockOut, 
      dynamic note, 
      String? shiftName, 
      String? scheduleIn, 
      String? scheduleOut, 
      dynamic status, 
      String? approvedAt, 
      List<LogsStatus>? logsStatus,}){
    _id = id;
    _fullName = fullName;
    _positionName = positionName;
    _requestDate = requestDate;
    _date = date;
    _clockIn = clockIn;
    _clockOut = clockOut;
    _note = note;
    _shiftName = shiftName;
    _scheduleIn = scheduleIn;
    _scheduleOut = scheduleOut;
    _status = status;
    _approvedAt = approvedAt;
    _logsStatus = logsStatus;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _positionName = json['position_name'];
    _requestDate = json['request_date'];
    _date = json['date'];
    _clockIn = json['clock_in'];
    _clockOut = json['clock_out'];
    _note = json['note'];
    _shiftName = json['shift_name'];
    _scheduleIn = json['schedule_in'];
    _scheduleOut = json['schedule_out'];
    _status = json['status'];
    _approvedAt = json['approved_at'];
    if (json['logs_status'] != null) {
      _logsStatus = [];
      json['logs_status'].forEach((v) {
        _logsStatus?.add(LogsStatus.fromJson(v));
      });
    }
  }
  num? _id;
  String? _fullName;
  String? _positionName;
  String? _requestDate;
  String? _date;
  String? _clockIn;
  String? _clockOut;
  dynamic _note;
  String? _shiftName;
  String? _scheduleIn;
  String? _scheduleOut;
  dynamic _status;
  String? _approvedAt;
  List<LogsStatus>? _logsStatus;
Data copyWith({  num? id,
  String? fullName,
  String? positionName,
  String? requestDate,
  String? date,
  String? clockIn,
  String? clockOut,
  dynamic note,
  String? shiftName,
  String? scheduleIn,
  String? scheduleOut,
  dynamic status,
  String? approvedAt,
  List<LogsStatus>? logsStatus,
}) => Data(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  positionName: positionName ?? _positionName,
  requestDate: requestDate ?? _requestDate,
  date: date ?? _date,
  clockIn: clockIn ?? _clockIn,
  clockOut: clockOut ?? _clockOut,
  note: note ?? _note,
  shiftName: shiftName ?? _shiftName,
  scheduleIn: scheduleIn ?? _scheduleIn,
  scheduleOut: scheduleOut ?? _scheduleOut,
  status: status ?? _status,
  approvedAt: approvedAt ?? _approvedAt,
  logsStatus: logsStatus ?? _logsStatus,
);
  num? get id => _id;
  String? get fullName => _fullName;
  String? get positionName => _positionName;
  String? get requestDate => _requestDate;
  String? get date => _date;
  String? get clockIn => _clockIn;
  String? get clockOut => _clockOut;
  dynamic get note => _note;
  String? get shiftName => _shiftName;
  String? get scheduleIn => _scheduleIn;
  String? get scheduleOut => _scheduleOut;
  dynamic get status => _status;
  String? get approvedAt => _approvedAt;
  List<LogsStatus>? get logsStatus => _logsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['position_name'] = _positionName;
    map['request_date'] = _requestDate;
    map['date'] = _date;
    map['clock_in'] = _clockIn;
    map['clock_out'] = _clockOut;
    map['note'] = _note;
    map['shift_name'] = _shiftName;
    map['schedule_in'] = _scheduleIn;
    map['schedule_out'] = _scheduleOut;
    map['status'] = _status;
    map['approved_at'] = _approvedAt;
    if (_logsStatus != null) {
      map['logs_status'] = _logsStatus?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// status : "REQUEST"
/// created_at : "2023-01-18T05:51:14.000000Z"
/// approved_by : null
/// position_name : null
/// description : "Waiting for approval"

class LogsStatus {
  LogsStatus({
      String? status, 
      String? createdAt, 
      dynamic approvedBy, 
      dynamic positionName, 
      String? description,}){
    _status = status;
    _createdAt = createdAt;
    _approvedBy = approvedBy;
    _positionName = positionName;
    _description = description;
}

  LogsStatus.fromJson(dynamic json) {
    _status = json['status'];
    _createdAt = json['created_at'];
    _approvedBy = json['approved_by'];
    _positionName = json['position_name'];
    _description = json['description'];
  }
  String? _status;
  String? _createdAt;
  dynamic _approvedBy;
  dynamic _positionName;
  String? _description;
LogsStatus copyWith({  String? status,
  String? createdAt,
  dynamic approvedBy,
  dynamic positionName,
  String? description,
}) => LogsStatus(  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  approvedBy: approvedBy ?? _approvedBy,
  positionName: positionName ?? _positionName,
  description: description ?? _description,
);
  String? get status => _status;
  String? get createdAt => _createdAt;
  dynamic get approvedBy => _approvedBy;
  dynamic get positionName => _positionName;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['approved_by'] = _approvedBy;
    map['position_name'] = _positionName;
    map['description'] = _description;
    return map;
  }

}