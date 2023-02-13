/// status : 200
/// message : "Ok"
/// data : {"id":18,"date":"2023-01-20","compensation_type":"paid_overtime","notes":"tEST","date_request":"2023-01-20","overtime_before":"00:00","break_before":"00:00","overtime_after":"00:00","break_after":"00:00","request_by":"sakti tua petrus davici banjarnahor","job_position_name":"Marketing","status":"REQUEST","approved_at":"2023-01-20","shift_name":"P","schedule_in":"12:00","schedule_out":"22:00","logs_status":[{"status":"REQUEST","created_at":"2023-01-20T11:52:27.000000Z","approved_by":null}]}

class OvertimeDetail {
  OvertimeDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OvertimeDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
OvertimeDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => OvertimeDetail(  status: status ?? _status,
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

/// id : 18
/// date : "2023-01-20"
/// compensation_type : "paid_overtime"
/// notes : "tEST"
/// date_request : "2023-01-20"
/// overtime_before : "00:00"
/// break_before : "00:00"
/// overtime_after : "00:00"
/// break_after : "00:00"
/// request_by : "sakti tua petrus davici banjarnahor"
/// job_position_name : "Marketing"
/// status : "REQUEST"
/// approved_at : "2023-01-20"
/// shift_name : "P"
/// schedule_in : "12:00"
/// schedule_out : "22:00"
/// logs_status : [{"status":"REQUEST","created_at":"2023-01-20T11:52:27.000000Z","approved_by":null}]

class Data {
  Data({
      num? id, 
      String? date, 
      String? compensationType, 
      String? notes, 
      String? dateRequest, 
      String? overtimeBefore, 
      String? breakBefore, 
      String? overtimeAfter, 
      String? breakAfter, 
      String? requestedBy,
      String? jobPositionName, 
      String? status, 
      String? approvedAt, 
      String? shiftName, 
      String? scheduleIn, 
      String? scheduleOut, 
      List<LogsStatus>? logsStatus,}){
    _id = id;
    _date = date;
    _compensationType = compensationType;
    _notes = notes;
    _dateRequest = dateRequest;
    _overtimeBefore = overtimeBefore;
    _breakBefore = breakBefore;
    _overtimeAfter = overtimeAfter;
    _breakAfter = breakAfter;
    _requestedBy = requestedBy;
    _jobPositionName = jobPositionName;
    _status = status;
    _approvedAt = approvedAt;
    _shiftName = shiftName;
    _scheduleIn = scheduleIn;
    _scheduleOut = scheduleOut;
    _logsStatus = logsStatus;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _compensationType = json['compensation_type'];
    _notes = json['notes'];
    _dateRequest = json['date_request'];
    _overtimeBefore = json['overtime_before'];
    _breakBefore = json['break_before'];
    _overtimeAfter = json['overtime_after'];
    _breakAfter = json['break_after'];
    _requestedBy = json['requested_by'];
    _jobPositionName = json['job_position_name'];
    _status = json['status'];
    _approvedAt = json['approved_at'];
    _shiftName = json['shift_name'];
    _scheduleIn = json['schedule_in'];
    _scheduleOut = json['schedule_out'];
    if (json['logs_status'] != null) {
      _logsStatus = [];
      json['logs_status'].forEach((v) {
        _logsStatus?.add(LogsStatus.fromJson(v));
      });
    }
  }
  num? _id;
  String? _date;
  String? _compensationType;
  String? _notes;
  String? _dateRequest;
  String? _overtimeBefore;
  String? _breakBefore;
  String? _overtimeAfter;
  String? _breakAfter;
  String? _requestedBy;
  String? _jobPositionName;
  String? _status;
  String? _approvedAt;
  String? _shiftName;
  String? _scheduleIn;
  String? _scheduleOut;
  List<LogsStatus>? _logsStatus;
Data copyWith({  num? id,
  String? date,
  String? compensationType,
  String? notes,
  String? dateRequest,
  String? overtimeBefore,
  String? breakBefore,
  String? overtimeAfter,
  String? breakAfter,
  String? requestedBy,
  String? jobPositionName,
  String? status,
  String? approvedAt,
  String? shiftName,
  String? scheduleIn,
  String? scheduleOut,
  List<LogsStatus>? logsStatus,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  compensationType: compensationType ?? _compensationType,
  notes: notes ?? _notes,
  dateRequest: dateRequest ?? _dateRequest,
  overtimeBefore: overtimeBefore ?? _overtimeBefore,
  breakBefore: breakBefore ?? _breakBefore,
  overtimeAfter: overtimeAfter ?? _overtimeAfter,
  breakAfter: breakAfter ?? _breakAfter,
  requestedBy: requestedBy ?? _requestedBy,
  jobPositionName: jobPositionName ?? _jobPositionName,
  status: status ?? _status,
  approvedAt: approvedAt ?? _approvedAt,
  shiftName: shiftName ?? _shiftName,
  scheduleIn: scheduleIn ?? _scheduleIn,
  scheduleOut: scheduleOut ?? _scheduleOut,
  logsStatus: logsStatus ?? _logsStatus,
);
  num? get id => _id;
  String? get date => _date;
  String? get compensationType => _compensationType;
  String? get notes => _notes;
  String? get dateRequest => _dateRequest;
  String? get overtimeBefore => _overtimeBefore;
  String? get breakBefore => _breakBefore;
  String? get overtimeAfter => _overtimeAfter;
  String? get breakAfter => _breakAfter;
  String? get requestedBy => _requestedBy;
  String? get jobPositionName => _jobPositionName;
  String? get status => _status;
  String? get approvedAt => _approvedAt;
  String? get shiftName => _shiftName;
  String? get scheduleIn => _scheduleIn;
  String? get scheduleOut => _scheduleOut;
  List<LogsStatus>? get logsStatus => _logsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['compensation_type'] = _compensationType;
    map['notes'] = _notes;
    map['date_request'] = _dateRequest;
    map['overtime_before'] = _overtimeBefore;
    map['break_before'] = _breakBefore;
    map['overtime_after'] = _overtimeAfter;
    map['break_after'] = _breakAfter;
    map['requested_by'] = _requestedBy;
    map['job_position_name'] = _jobPositionName;
    map['status'] = _status;
    map['approved_at'] = _approvedAt;
    map['shift_name'] = _shiftName;
    map['schedule_in'] = _scheduleIn;
    map['schedule_out'] = _scheduleOut;
    if (_logsStatus != null) {
      map['logs_status'] = _logsStatus?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// status : "REQUEST"
/// created_at : "2023-01-20T11:52:27.000000Z"
/// approved_by : null

class LogsStatus {
  LogsStatus({
      String? status, 
      String? createdAt,
      String? description,
      dynamic approvedBy,}){
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
  String? _description;
  String? _createdAt;
  dynamic _approvedBy;
LogsStatus copyWith({  String? status,
  String? createdAt,
  dynamic approvedBy,
}) => LogsStatus(  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  approvedBy: approvedBy ?? _approvedBy,
);
  String? get status => _status;
  String? get description => _description;
  String? get createdAt => _createdAt;
  dynamic get approvedBy => _approvedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['approved_by'] = _approvedBy;
    return map;
  }

}