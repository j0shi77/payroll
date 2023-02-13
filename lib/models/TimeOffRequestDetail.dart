/// status : 200
/// message : "Ok"
/// data : {"request_type":"FULL_DAY","schedule_in_half_day":"15:55","schedule_out_half_day":"15:55","time_off_code":"CT","time_off_name":"Cuti","time_off_dsc":"Cuti Tahunan","id":18,"full_name":"sakti tua petrus davici banjarnahor","position_name":"Marketing","start_date":"2023-01-10","end_date":"2023-01-10","balance_start":3,"balance_end":2,"date":"2023-01-20","note":"test","images":["https://firebasestorage.googleapis.com/v0/b/payroll-f5ba7.appspot.com/o/time_off%2FTO_MOBILE_20230201_20230202_ID139_0.jpg?alt=media&token=c78702f0-b210-49c4-8921-a12bd3d5d676"],"taken":1,"shift_name":"P","schedule_in":"12:00","schedule_out":"22:00","status":"CANCELED","approved_at":"2023-01-30","logs_status":[{"status":"CANCELED","created_at":"2023-01-30T09:41:34.000000Z","approved_by":null,"position_name":null,"description":"Request has been canceled"},{"status":"REQUEST","created_at":"2023-01-20T07:17:23.000000Z","approved_by":null,"position_name":null,"description":"Waiting for approval"}]}

class TimeOffRequestDetail {
  TimeOffRequestDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TimeOffRequestDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
TimeOffRequestDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => TimeOffRequestDetail(  status: status ?? _status,
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

/// request_type : "FULL_DAY"
/// schedule_in_half_day : "15:55"
/// schedule_out_half_day : "15:55"
/// time_off_code : "CT"
/// time_off_name : "Cuti"
/// time_off_dsc : "Cuti Tahunan"
/// id : 18
/// full_name : "sakti tua petrus davici banjarnahor"
/// position_name : "Marketing"
/// start_date : "2023-01-10"
/// end_date : "2023-01-10"
/// balance_start : 3
/// balance_end : 2
/// date : "2023-01-20"
/// note : "test"
/// images : ["https://firebasestorage.googleapis.com/v0/b/payroll-f5ba7.appspot.com/o/time_off%2FTO_MOBILE_20230201_20230202_ID139_0.jpg?alt=media&token=c78702f0-b210-49c4-8921-a12bd3d5d676"]
/// taken : 1
/// shift_name : "P"
/// schedule_in : "12:00"
/// schedule_out : "22:00"
/// status : "CANCELED"
/// approved_at : "2023-01-30"
/// logs_status : [{"status":"CANCELED","created_at":"2023-01-30T09:41:34.000000Z","approved_by":null,"position_name":null,"description":"Request has been canceled"},{"status":"REQUEST","created_at":"2023-01-20T07:17:23.000000Z","approved_by":null,"position_name":null,"description":"Waiting for approval"}]

class Data {
  Data({
      String? requestType, 
      String? scheduleInHalfDay, 
      String? scheduleOutHalfDay, 
      String? timeOffCode, 
      String? timeOffName, 
      String? timeOffDsc, 
      num? id, 
      String? fullName, 
      String? positionName, 
      String? startDate, 
      String? endDate, 
      num? balanceStart, 
      num? balanceEnd, 
      String? date, 
      String? note, 
      List<String>? images, 
      num? taken, 
      String? shiftName, 
      String? scheduleIn, 
      String? scheduleOut, 
      String? status, 
      String? approvedAt, 
      List<LogsStatus>? logsStatus,}){
    _requestType = requestType;
    _scheduleInHalfDay = scheduleInHalfDay;
    _scheduleOutHalfDay = scheduleOutHalfDay;
    _timeOffCode = timeOffCode;
    _timeOffName = timeOffName;
    _timeOffDsc = timeOffDsc;
    _id = id;
    _fullName = fullName;
    _positionName = positionName;
    _startDate = startDate;
    _endDate = endDate;
    _balanceStart = balanceStart;
    _balanceEnd = balanceEnd;
    _date = date;
    _note = note;
    _images = images;
    _taken = taken;
    _shiftName = shiftName;
    _scheduleIn = scheduleIn;
    _scheduleOut = scheduleOut;
    _status = status;
    _approvedAt = approvedAt;
    _logsStatus = logsStatus;
}

  Data.fromJson(dynamic json) {
    _requestType = json['request_type'];
    _scheduleInHalfDay = json['schedule_in_half_day'];
    _scheduleOutHalfDay = json['schedule_out_half_day'];
    _timeOffCode = json['time_off_code'];
    _timeOffName = json['time_off_name'];
    _timeOffDsc = json['time_off_dsc'];
    _id = json['id'];
    _fullName = json['full_name'];
    _positionName = json['position_name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _balanceStart = json['balance_start'];
    _balanceEnd = json['balance_end'];
    _date = json['date'];
    _note = json['note'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _taken = json['taken'];
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
  String? _requestType;
  String? _scheduleInHalfDay;
  String? _scheduleOutHalfDay;
  String? _timeOffCode;
  String? _timeOffName;
  String? _timeOffDsc;
  num? _id;
  String? _fullName;
  String? _positionName;
  String? _startDate;
  String? _endDate;
  num? _balanceStart;
  num? _balanceEnd;
  String? _date;
  String? _note;
  List<String>? _images;
  num? _taken;
  String? _shiftName;
  String? _scheduleIn;
  String? _scheduleOut;
  String? _status;
  String? _approvedAt;
  List<LogsStatus>? _logsStatus;
Data copyWith({  String? requestType,
  String? scheduleInHalfDay,
  String? scheduleOutHalfDay,
  String? timeOffCode,
  String? timeOffName,
  String? timeOffDsc,
  num? id,
  String? fullName,
  String? positionName,
  String? startDate,
  String? endDate,
  num? balanceStart,
  num? balanceEnd,
  String? date,
  String? note,
  List<String>? images,
  num? taken,
  String? shiftName,
  String? scheduleIn,
  String? scheduleOut,
  String? status,
  String? approvedAt,
  List<LogsStatus>? logsStatus,
}) => Data(  requestType: requestType ?? _requestType,
  scheduleInHalfDay: scheduleInHalfDay ?? _scheduleInHalfDay,
  scheduleOutHalfDay: scheduleOutHalfDay ?? _scheduleOutHalfDay,
  timeOffCode: timeOffCode ?? _timeOffCode,
  timeOffName: timeOffName ?? _timeOffName,
  timeOffDsc: timeOffDsc ?? _timeOffDsc,
  id: id ?? _id,
  fullName: fullName ?? _fullName,
  positionName: positionName ?? _positionName,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  balanceStart: balanceStart ?? _balanceStart,
  balanceEnd: balanceEnd ?? _balanceEnd,
  date: date ?? _date,
  note: note ?? _note,
  images: images ?? _images,
  taken: taken ?? _taken,
  shiftName: shiftName ?? _shiftName,
  scheduleIn: scheduleIn ?? _scheduleIn,
  scheduleOut: scheduleOut ?? _scheduleOut,
  status: status ?? _status,
  approvedAt: approvedAt ?? _approvedAt,
  logsStatus: logsStatus ?? _logsStatus,
);
  String? get requestType => _requestType;
  String? get scheduleInHalfDay => _scheduleInHalfDay;
  String? get scheduleOutHalfDay => _scheduleOutHalfDay;
  String? get timeOffCode => _timeOffCode;
  String? get timeOffName => _timeOffName;
  String? get timeOffDsc => _timeOffDsc;
  num? get id => _id;
  String? get fullName => _fullName;
  String? get positionName => _positionName;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get balanceStart => _balanceStart;
  num? get balanceEnd => _balanceEnd;
  String? get date => _date;
  String? get note => _note;
  List<String>? get images => _images;
  num? get taken => _taken;
  String? get shiftName => _shiftName;
  String? get scheduleIn => _scheduleIn;
  String? get scheduleOut => _scheduleOut;
  String? get status => _status;
  String? get approvedAt => _approvedAt;
  List<LogsStatus>? get logsStatus => _logsStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['request_type'] = _requestType;
    map['schedule_in_half_day'] = _scheduleInHalfDay;
    map['schedule_out_half_day'] = _scheduleOutHalfDay;
    map['time_off_code'] = _timeOffCode;
    map['time_off_name'] = _timeOffName;
    map['time_off_dsc'] = _timeOffDsc;
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['position_name'] = _positionName;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['balance_start'] = _balanceStart;
    map['balance_end'] = _balanceEnd;
    map['date'] = _date;
    map['note'] = _note;
    map['images'] = _images;
    map['taken'] = _taken;
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

/// status : "CANCELED"
/// created_at : "2023-01-30T09:41:34.000000Z"
/// approved_by : null
/// position_name : null
/// description : "Request has been canceled"

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