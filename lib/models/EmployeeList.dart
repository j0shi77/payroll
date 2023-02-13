/// status : 200
/// message : "Ok"
/// data : [{"id":728,"full_name":"Ade Candra","employee_id":"CLICK GROUP728","job_position_name":"Customer Service","email":"ciaino007@gmail.com","mobile_phone":"08819762725","avatar":null}]

class EmployeeList {
  EmployeeList({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  EmployeeList.fromJson(dynamic json) {
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
EmployeeList copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => EmployeeList(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 728
/// full_name : "Ade Candra"
/// employee_id : "CLICK GROUP728"
/// job_position_name : "Customer Service"
/// email : "ciaino007@gmail.com"
/// mobile_phone : "08819762725"
/// avatar : null

class Data {
  Data({
      num? id, 
      String? fullName, 
      String? employeeId, 
      String? jobPositionName, 
      String? email, 
      String? mobilePhone, 
      dynamic avatar,}){
    _id = id;
    _fullName = fullName;
    _employeeId = employeeId;
    _jobPositionName = jobPositionName;
    _email = email;
    _mobilePhone = mobilePhone;
    _avatar = avatar;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _employeeId = json['employee_id'];
    _jobPositionName = json['job_position_name'];
    _email = json['email'];
    _mobilePhone = json['mobile_phone'];
    _avatar = json['avatar'];
  }
  num? _id;
  String? _fullName;
  String? _employeeId;
  String? _jobPositionName;
  String? _email;
  String? _mobilePhone;
  dynamic _avatar;
Data copyWith({  num? id,
  String? fullName,
  String? employeeId,
  String? jobPositionName,
  String? email,
  String? mobilePhone,
  dynamic avatar,
}) => Data(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  employeeId: employeeId ?? _employeeId,
  jobPositionName: jobPositionName ?? _jobPositionName,
  email: email ?? _email,
  mobilePhone: mobilePhone ?? _mobilePhone,
  avatar: avatar ?? _avatar,
);
  num? get id => _id;
  String? get fullName => _fullName;
  String? get employeeId => _employeeId;
  String? get jobPositionName => _jobPositionName;
  String? get email => _email;
  String? get mobilePhone => _mobilePhone;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['employee_id'] = _employeeId;
    map['job_position_name'] = _jobPositionName;
    map['email'] = _email;
    map['mobile_phone'] = _mobilePhone;
    map['avatar'] = _avatar;
    return map;
  }

}