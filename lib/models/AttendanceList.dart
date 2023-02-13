/// status : 200
/// message : "Ok"
/// data : [{"date":"2022-12-23","detail":[{"id":43,"attendance_id":11,"employee_id":389,"attendance_code":"H","attendance_type":"clock in","clock_in":"11:44","clock_out":null,"latitude":"-6.129106","longitude":"106.730515","note":null,"image":"https://firebasestorage.googleapis.com/v0/b/payroll-ea38c.appspot.com/o/attendanceImages%2F064c7bcf-3bbe-4211-9a14-1c3f1fb4f5fb3320019090737904047.jpg?alt=media&token=ef33df78-98d7-4584-a4c9-30476461a03e","created_at":"2022-12-22T17:00:00.000000Z","updated_at":"2022-09-19T04:44:17.000000Z"}],"clock_in":"11:44","clock_out":""}]

class AttendanceList {
  AttendanceList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AttendanceList.fromJson(dynamic json) {
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
AttendanceList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => AttendanceList(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  set setStatus(num status) {
    _status = status;
  }

  set setMessage(String message) {
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

/// date : "2022-12-23"
/// detail : [{"id":43,"attendance_id":11,"employee_id":389,"attendance_code":"H","attendance_type":"clock in","clock_in":"11:44","clock_out":null,"latitude":"-6.129106","longitude":"106.730515","note":null,"image":"https://firebasestorage.googleapis.com/v0/b/payroll-ea38c.appspot.com/o/attendanceImages%2F064c7bcf-3bbe-4211-9a14-1c3f1fb4f5fb3320019090737904047.jpg?alt=media&token=ef33df78-98d7-4584-a4c9-30476461a03e","created_at":"2022-12-22T17:00:00.000000Z","updated_at":"2022-09-19T04:44:17.000000Z"}]
/// clock_in : "11:44"
/// clock_out : ""

class Data {
  Data({
      String? date, 
      List<Detail>? detail, 
      String? clockIn, 
      String? clockOut,}){
    _date = date;
    _detail = detail;
    _clockIn = clockIn;
    _clockOut = clockOut;
}

  Data.fromJson(dynamic json) {
    _date = json['date'];
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
    _clockIn = json['clock_in'];
    _clockOut = json['clock_out'];
  }
  String? _date;
  List<Detail>? _detail;
  String? _clockIn;
  String? _clockOut;
Data copyWith({  String? date,
  List<Detail>? detail,
  String? clockIn,
  String? clockOut,
}) => Data(  date: date ?? _date,
  detail: detail ?? _detail,
  clockIn: clockIn ?? _clockIn,
  clockOut: clockOut ?? _clockOut,
);
  String? get date => _date;
  List<Detail>? get detail => _detail;
  String? get clockIn => _clockIn;
  String? get clockOut => _clockOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    map['clock_in'] = _clockIn;
    map['clock_out'] = _clockOut;
    return map;
  }

}

/// id : 43
/// attendance_id : 11
/// employee_id : 389
/// attendance_code : "H"
/// attendance_type : "clock in"
/// clock_in : "11:44"
/// clock_out : null
/// latitude : "-6.129106"
/// longitude : "106.730515"
/// note : null
/// image : "https://firebasestorage.googleapis.com/v0/b/payroll-ea38c.appspot.com/o/attendanceImages%2F064c7bcf-3bbe-4211-9a14-1c3f1fb4f5fb3320019090737904047.jpg?alt=media&token=ef33df78-98d7-4584-a4c9-30476461a03e"
/// created_at : "2022-12-22T17:00:00.000000Z"
/// updated_at : "2022-09-19T04:44:17.000000Z"

class Detail {
  Detail({
      num? id, 
      num? attendanceId, 
      num? employeeId, 
      String? attendanceCode, 
      String? attendanceType, 
      String? clockIn, 
      dynamic clockOut, 
      String? latitude, 
      String? longitude, 
      dynamic note, 
      String? image, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _attendanceId = attendanceId;
    _employeeId = employeeId;
    _attendanceCode = attendanceCode;
    _attendanceType = attendanceType;
    _clockIn = clockIn;
    _clockOut = clockOut;
    _latitude = latitude;
    _longitude = longitude;
    _note = note;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Detail.fromJson(dynamic json) {
    _id = json['id'];
    _attendanceId = json['attendance_id'];
    _employeeId = json['employee_id'];
    _attendanceCode = json['attendance_code'];
    _attendanceType = json['attendance_type'];
    _clockIn = json['clock_in'];
    _clockOut = json['clock_out'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _note = json['note'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  num? _attendanceId;
  num? _employeeId;
  String? _attendanceCode;
  String? _attendanceType;
  String? _clockIn;
  dynamic _clockOut;
  String? _latitude;
  String? _longitude;
  dynamic _note;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
Detail copyWith({  num? id,
  num? attendanceId,
  num? employeeId,
  String? attendanceCode,
  String? attendanceType,
  String? clockIn,
  dynamic clockOut,
  String? latitude,
  String? longitude,
  dynamic note,
  String? image,
  String? createdAt,
  String? updatedAt,
}) => Detail(  id: id ?? _id,
  attendanceId: attendanceId ?? _attendanceId,
  employeeId: employeeId ?? _employeeId,
  attendanceCode: attendanceCode ?? _attendanceCode,
  attendanceType: attendanceType ?? _attendanceType,
  clockIn: clockIn ?? _clockIn,
  clockOut: clockOut ?? _clockOut,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  note: note ?? _note,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  num? get attendanceId => _attendanceId;
  num? get employeeId => _employeeId;
  String? get attendanceCode => _attendanceCode;
  String? get attendanceType => _attendanceType;
  String? get clockIn => _clockIn;
  dynamic get clockOut => _clockOut;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  dynamic get note => _note;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['attendance_id'] = _attendanceId;
    map['employee_id'] = _employeeId;
    map['attendance_code'] = _attendanceCode;
    map['attendance_type'] = _attendanceType;
    map['clock_in'] = _clockIn;
    map['clock_out'] = _clockOut;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['note'] = _note;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}