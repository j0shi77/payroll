/// status : 200
/// message : "Ok"
/// data : {"id":12,"date":"2023-02-07","effective_date":"2023-02-07","current_shift_id":"40","current_shift_name":"P","current_shift_schedule_in":"12:00","current_shift_schedule_out":"22:00","new_shift_id":80,"new_shift_name":"P","new_shift_schedule_in":"12:00","new_shift_schedule_out":"22:00","notes":"test","requested_by":"sakti tua petrus davici banjarnahor","job_position_name":"Marketing","status":"CANCELED","approved_at":"2023-02-07","logs_status":[{"status":"CANCELED","created_at":"2023-02-07T11:25:50.000000Z","approved_by":null,"description":"Request has been canceled"},{"status":"REQUEST","created_at":"2023-02-07T11:13:01.000000Z","approved_by":null,"description":"Waiting for approved"}]}

class ShiftDetail {
  ShiftDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ShiftDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
ShiftDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => ShiftDetail(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

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
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 12
/// date : "2023-02-07"
/// effective_date : "2023-02-07"
/// current_shift_id : "40"
/// current_shift_name : "P"
/// current_shift_schedule_in : "12:00"
/// current_shift_schedule_out : "22:00"
/// new_shift_id : 80
/// new_shift_name : "P"
/// new_shift_schedule_in : "12:00"
/// new_shift_schedule_out : "22:00"
/// notes : "test"
/// requested_by : "sakti tua petrus davici banjarnahor"
/// job_position_name : "Marketing"
/// status : "CANCELED"
/// approved_at : "2023-02-07"
/// logs_status : [{"status":"CANCELED","created_at":"2023-02-07T11:25:50.000000Z","approved_by":null,"description":"Request has been canceled"},{"status":"REQUEST","created_at":"2023-02-07T11:13:01.000000Z","approved_by":null,"description":"Waiting for approved"}]

class Data {
  Data({
      num? id, 
      String? date, 
      String? effectiveDate, 
      String? currentShiftId, 
      String? currentShiftName, 
      String? currentShiftScheduleIn, 
      String? currentShiftScheduleOut, 
      num? newShiftId, 
      String? newShiftName, 
      String? newShiftScheduleIn, 
      String? newShiftScheduleOut, 
      String? notes, 
      String? requestedBy, 
      String? jobPositionName, 
      String? status, 
      String? approvedAt, 
      List<LogsStatus>? logsStatus,}){
    _id = id;
    _date = date;
    _effectiveDate = effectiveDate;
    _currentShiftId = currentShiftId;
    _currentShiftName = currentShiftName;
    _currentShiftScheduleIn = currentShiftScheduleIn;
    _currentShiftScheduleOut = currentShiftScheduleOut;
    _newShiftId = newShiftId;
    _newShiftName = newShiftName;
    _newShiftScheduleIn = newShiftScheduleIn;
    _newShiftScheduleOut = newShiftScheduleOut;
    _notes = notes;
    _requestedBy = requestedBy;
    _jobPositionName = jobPositionName;
    _status = status;
    _approvedAt = approvedAt;
    _logsStatus = logsStatus;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _effectiveDate = json['effective_date'];
    _currentShiftId = json['current_shift_id'];
    _currentShiftName = json['current_shift_name'];
    _currentShiftScheduleIn = json['current_shift_schedule_in'];
    _currentShiftScheduleOut = json['current_shift_schedule_out'];
    _newShiftId = json['new_shift_id'];
    _newShiftName = json['new_shift_name'];
    _newShiftScheduleIn = json['new_shift_schedule_in'];
    _newShiftScheduleOut = json['new_shift_schedule_out'];
    _notes = json['notes'];
    _requestedBy = json['requested_by'];
    _jobPositionName = json['job_position_name'];
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
  String? _date;
  String? _effectiveDate;
  String? _currentShiftId;
  String? _currentShiftName;
  String? _currentShiftScheduleIn;
  String? _currentShiftScheduleOut;
  num? _newShiftId;
  String? _newShiftName;
  String? _newShiftScheduleIn;
  String? _newShiftScheduleOut;
  String? _notes;
  String? _requestedBy;
  String? _jobPositionName;
  String? _status;
  String? _approvedAt;
  List<LogsStatus>? _logsStatus;
Data copyWith({  num? id,
  String? date,
  String? effectiveDate,
  String? currentShiftId,
  String? currentShiftName,
  String? currentShiftScheduleIn,
  String? currentShiftScheduleOut,
  num? newShiftId,
  String? newShiftName,
  String? newShiftScheduleIn,
  String? newShiftScheduleOut,
  String? notes,
  String? requestedBy,
  String? jobPositionName,
  String? status,
  String? approvedAt,
  List<LogsStatus>? logsStatus,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  effectiveDate: effectiveDate ?? _effectiveDate,
  currentShiftId: currentShiftId ?? _currentShiftId,
  currentShiftName: currentShiftName ?? _currentShiftName,
  currentShiftScheduleIn: currentShiftScheduleIn ?? _currentShiftScheduleIn,
  currentShiftScheduleOut: currentShiftScheduleOut ?? _currentShiftScheduleOut,
  newShiftId: newShiftId ?? _newShiftId,
  newShiftName: newShiftName ?? _newShiftName,
  newShiftScheduleIn: newShiftScheduleIn ?? _newShiftScheduleIn,
  newShiftScheduleOut: newShiftScheduleOut ?? _newShiftScheduleOut,
  notes: notes ?? _notes,
  requestedBy: requestedBy ?? _requestedBy,
  jobPositionName: jobPositionName ?? _jobPositionName,
  status: status ?? _status,
  approvedAt: approvedAt ?? _approvedAt,
  logsStatus: logsStatus ?? _logsStatus,
);
  num? get id => _id;
  String? get date => _date;
  String? get effectiveDate => _effectiveDate;
  String? get currentShiftId => _currentShiftId;
  String? get currentShiftName => _currentShiftName;
  String? get currentShiftScheduleIn => _currentShiftScheduleIn;
  String? get currentShiftScheduleOut => _currentShiftScheduleOut;
  num? get newShiftId => _newShiftId;
  String? get newShiftName => _newShiftName;
  String? get newShiftScheduleIn => _newShiftScheduleIn;
  String? get newShiftScheduleOut => _newShiftScheduleOut;
  String? get notes => _notes;
  String? get requestedBy => _requestedBy;
  String? get jobPositionName => _jobPositionName;
  String? get status => _status;
  String? get approvedAt => _approvedAt;
  List<LogsStatus>? get logsStatus => _logsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['effective_date'] = _effectiveDate;
    map['current_shift_id'] = _currentShiftId;
    map['current_shift_name'] = _currentShiftName;
    map['current_shift_schedule_in'] = _currentShiftScheduleIn;
    map['current_shift_schedule_out'] = _currentShiftScheduleOut;
    map['new_shift_id'] = _newShiftId;
    map['new_shift_name'] = _newShiftName;
    map['new_shift_schedule_in'] = _newShiftScheduleIn;
    map['new_shift_schedule_out'] = _newShiftScheduleOut;
    map['notes'] = _notes;
    map['requested_by'] = _requestedBy;
    map['job_position_name'] = _jobPositionName;
    map['status'] = _status;
    map['approved_at'] = _approvedAt;
    if (_logsStatus != null) {
      map['logs_status'] = _logsStatus?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// status : "CANCELED"
/// created_at : "2023-02-07T11:25:50.000000Z"
/// approved_by : null
/// description : "Request has been canceled"

class LogsStatus {
  LogsStatus({
      String? status, 
      String? createdAt, 
      dynamic approvedBy, 
      String? description,}){
    _status = status;
    _createdAt = createdAt;
    _approvedBy = approvedBy;
    _description = description;
}

  LogsStatus.fromJson(dynamic json) {
    _status = json['status'];
    _createdAt = json['created_at'];
    _approvedBy = json['approved_by'];
    _description = json['description'];
  }
  String? _status;
  String? _createdAt;
  dynamic _approvedBy;
  String? _description;
LogsStatus copyWith({  String? status,
  String? createdAt,
  dynamic approvedBy,
  String? description,
}) => LogsStatus(  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  approvedBy: approvedBy ?? _approvedBy,
  description: description ?? _description,
);
  String? get status => _status;
  String? get createdAt => _createdAt;
  dynamic get approvedBy => _approvedBy;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['approved_by'] = _approvedBy;
    map['description'] = _description;
    return map;
  }

}