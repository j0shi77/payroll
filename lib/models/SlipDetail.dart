/// status : 200
/// message : "Ok"
/// data : {"id":7644,"employee_id":389,"net_payble":7407000,"salary_month":"2023-02","status":0,"is_bpjs_active":1,"basic_salary":9500000,"allowance":[{"component_id":1,"component":"Tunjangan Jabatan","type":"Allowance","amount":57000},{"component_id":4,"component":"Komis Bulanan","type":"Allowance","amount":0},{"component_id":9,"component":"Komisi Tahunan","type":"Allowance","amount":0},{"component_id":10,"component":"Basic Salary","type":"Allowance","amount":7500000}],"deduction":[{"component_id":3,"component":"Keterlambatan","type":"Deduction","amount":100000},{"component_id":11,"component":"Potongan Absen","type":"Deduction","amount":50000}],"slipbyemail":1,"created_by":"Akbar","created_at":"2022-09-16T08:58:04.000000Z","updated_at":"2022-09-27T03:55:43.000000Z","attendance_summary":[{"component":"actual_working_day","amount":"33"},{"component":"schedule_working_day","amount":33},{"component":"day_off","amount":"0"},{"component":"national_holyday","amount":"0"},{"component":"company_holyday","amount":"0"},{"component":"attendance","amount":"H:3"},{"component":"time_off","amount":""}],"benefits":[{"component":"JHT","amount":2775000},{"component":"JKK","amount":180000},{"component":"JKM","amount":225000},{"component":"BPJS Kesehatan","amount":185674.16}]}

class SlipDetail {
  SlipDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  SlipDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
SlipDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => SlipDetail(  status: status ?? _status,
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

/// id : 7644
/// employee_id : 389
/// net_payble : 7407000
/// salary_month : "2023-02"
/// status : 0
/// is_bpjs_active : 1
/// basic_salary : 9500000
/// allowance : [{"component_id":1,"component":"Tunjangan Jabatan","type":"Allowance","amount":57000},{"component_id":4,"component":"Komis Bulanan","type":"Allowance","amount":0},{"component_id":9,"component":"Komisi Tahunan","type":"Allowance","amount":0},{"component_id":10,"component":"Basic Salary","type":"Allowance","amount":7500000}]
/// deduction : [{"component_id":3,"component":"Keterlambatan","type":"Deduction","amount":100000},{"component_id":11,"component":"Potongan Absen","type":"Deduction","amount":50000}]
/// slipbyemail : 1
/// created_by : "Akbar"
/// created_at : "2022-09-16T08:58:04.000000Z"
/// updated_at : "2022-09-27T03:55:43.000000Z"
/// attendance_summary : [{"component":"actual_working_day","amount":"33"},{"component":"schedule_working_day","amount":33},{"component":"day_off","amount":"0"},{"component":"national_holyday","amount":"0"},{"component":"company_holyday","amount":"0"},{"component":"attendance","amount":"H:3"},{"component":"time_off","amount":""}]
/// benefits : [{"component":"JHT","amount":2775000},{"component":"JKK","amount":180000},{"component":"JKM","amount":225000},{"component":"BPJS Kesehatan","amount":185674.16}]

class Data {
  Data({
      num? id, 
      num? employeeId, 
      num? netPayble, 
      String? salaryMonth, 
      num? status, 
      num? isBpjsActive, 
      num? basicSalary, 
      List<Allowance>? allowance, 
      List<Deduction>? deduction, 
      num? slipbyemail, 
      String? createdBy, 
      String? createdAt, 
      String? updatedAt, 
      List<AttendanceSummary>? attendanceSummary, 
      List<Benefits>? benefits,}){
    _id = id;
    _employeeId = employeeId;
    _netPayble = netPayble;
    _salaryMonth = salaryMonth;
    _status = status;
    _isBpjsActive = isBpjsActive;
    _basicSalary = basicSalary;
    _allowance = allowance;
    _deduction = deduction;
    _slipbyemail = slipbyemail;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _attendanceSummary = attendanceSummary;
    _benefits = benefits;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _employeeId = json['employee_id'];
    _netPayble = json['net_payble'];
    _salaryMonth = json['salary_month'];
    _status = json['status'];
    _isBpjsActive = json['is_bpjs_active'];
    _basicSalary = json['basic_salary'];
    if (json['allowance'] != null) {
      _allowance = [];
      json['allowance'].forEach((v) {
        _allowance?.add(Allowance.fromJson(v));
      });
    }
    if (json['deduction'] != null) {
      _deduction = [];
      json['deduction'].forEach((v) {
        _deduction?.add(Deduction.fromJson(v));
      });
    }
    _slipbyemail = json['slipbyemail'];
    _createdBy = json['created_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['attendance_summary'] != null) {
      _attendanceSummary = [];
      json['attendance_summary'].forEach((v) {
        _attendanceSummary?.add(AttendanceSummary.fromJson(v));
      });
    }
    if (json['benefits'] != null) {
      _benefits = [];
      json['benefits'].forEach((v) {
        _benefits?.add(Benefits.fromJson(v));
      });
    }
  }
  num? _id;
  num? _employeeId;
  num? _netPayble;
  String? _salaryMonth;
  num? _status;
  num? _isBpjsActive;
  num? _basicSalary;
  List<Allowance>? _allowance;
  List<Deduction>? _deduction;
  num? _slipbyemail;
  String? _createdBy;
  String? _createdAt;
  String? _updatedAt;
  List<AttendanceSummary>? _attendanceSummary;
  List<Benefits>? _benefits;
Data copyWith({  num? id,
  num? employeeId,
  num? netPayble,
  String? salaryMonth,
  num? status,
  num? isBpjsActive,
  num? basicSalary,
  List<Allowance>? allowance,
  List<Deduction>? deduction,
  num? slipbyemail,
  String? createdBy,
  String? createdAt,
  String? updatedAt,
  List<AttendanceSummary>? attendanceSummary,
  List<Benefits>? benefits,
}) => Data(  id: id ?? _id,
  employeeId: employeeId ?? _employeeId,
  netPayble: netPayble ?? _netPayble,
  salaryMonth: salaryMonth ?? _salaryMonth,
  status: status ?? _status,
  isBpjsActive: isBpjsActive ?? _isBpjsActive,
  basicSalary: basicSalary ?? _basicSalary,
  allowance: allowance ?? _allowance,
  deduction: deduction ?? _deduction,
  slipbyemail: slipbyemail ?? _slipbyemail,
  createdBy: createdBy ?? _createdBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  attendanceSummary: attendanceSummary ?? _attendanceSummary,
  benefits: benefits ?? _benefits,
);
  num? get id => _id;
  num? get employeeId => _employeeId;
  num? get netPayble => _netPayble;
  String? get salaryMonth => _salaryMonth;
  num? get status => _status;
  num? get isBpjsActive => _isBpjsActive;
  num? get basicSalary => _basicSalary;
  List<Allowance>? get allowance => _allowance;
  List<Deduction>? get deduction => _deduction;
  num? get slipbyemail => _slipbyemail;
  String? get createdBy => _createdBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<AttendanceSummary>? get attendanceSummary => _attendanceSummary;
  List<Benefits>? get benefits => _benefits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['employee_id'] = _employeeId;
    map['net_payble'] = _netPayble;
    map['salary_month'] = _salaryMonth;
    map['status'] = _status;
    map['is_bpjs_active'] = _isBpjsActive;
    map['basic_salary'] = _basicSalary;
    if (_allowance != null) {
      map['allowance'] = _allowance?.map((v) => v.toJson()).toList();
    }
    if (_deduction != null) {
      map['deduction'] = _deduction?.map((v) => v.toJson()).toList();
    }
    map['slipbyemail'] = _slipbyemail;
    map['created_by'] = _createdBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_attendanceSummary != null) {
      map['attendance_summary'] = _attendanceSummary?.map((v) => v.toJson()).toList();
    }
    if (_benefits != null) {
      map['benefits'] = _benefits?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// component : "JHT"
/// amount : 2775000

class Benefits {
  Benefits({
      String? component, 
      num? amount,}){
    _component = component;
    _amount = amount;
}

  Benefits.fromJson(dynamic json) {
    _component = json['component'];
    _amount = json['amount'];
  }
  String? _component;
  num? _amount;
Benefits copyWith({  String? component,
  num? amount,
}) => Benefits(  component: component ?? _component,
  amount: amount ?? _amount,
);
  String? get component => _component;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['component'] = _component;
    map['amount'] = _amount;
    return map;
  }

}

/// component : "actual_working_day"
/// amount : "33"

class AttendanceSummary {
  AttendanceSummary({
      String? component, 
      String? amount,}){
    _component = component;
    _amount = amount;
}

  AttendanceSummary.fromJson(dynamic json) {
    _component = json['component'];
    _amount = json['amount'];
  }
  String? _component;
  String? _amount;
AttendanceSummary copyWith({  String? component,
  String? amount,
}) => AttendanceSummary(  component: component ?? _component,
  amount: amount ?? _amount,
);
  String? get component => _component;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['component'] = _component;
    map['amount'] = _amount;
    return map;
  }

}

/// component_id : 3
/// component : "Keterlambatan"
/// type : "Deduction"
/// amount : 100000

class Deduction {
  Deduction({
      num? componentId, 
      String? component, 
      String? type, 
      num? amount,}){
    _componentId = componentId;
    _component = component;
    _type = type;
    _amount = amount;
}

  Deduction.fromJson(dynamic json) {
    _componentId = json['component_id'];
    _component = json['component'];
    _type = json['type'];
    _amount = json['amount'];
  }
  num? _componentId;
  String? _component;
  String? _type;
  num? _amount;
Deduction copyWith({  num? componentId,
  String? component,
  String? type,
  num? amount,
}) => Deduction(  componentId: componentId ?? _componentId,
  component: component ?? _component,
  type: type ?? _type,
  amount: amount ?? _amount,
);
  num? get componentId => _componentId;
  String? get component => _component;
  String? get type => _type;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['component_id'] = _componentId;
    map['component'] = _component;
    map['type'] = _type;
    map['amount'] = _amount;
    return map;
  }

}

/// component_id : 1
/// component : "Tunjangan Jabatan"
/// type : "Allowance"
/// amount : 57000

class Allowance {
  Allowance({
      num? componentId, 
      String? component, 
      String? type, 
      num? amount,}){
    _componentId = componentId;
    _component = component;
    _type = type;
    _amount = amount;
}

  Allowance.fromJson(dynamic json) {
    _componentId = json['component_id'];
    _component = json['component'];
    _type = json['type'];
    _amount = json['amount'];
  }
  num? _componentId;
  String? _component;
  String? _type;
  num? _amount;
Allowance copyWith({  num? componentId,
  String? component,
  String? type,
  num? amount,
}) => Allowance(  componentId: componentId ?? _componentId,
  component: component ?? _component,
  type: type ?? _type,
  amount: amount ?? _amount,
);
  num? get componentId => _componentId;
  String? get component => _component;
  String? get type => _type;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['component_id'] = _componentId;
    map['component'] = _component;
    map['type'] = _type;
    map['amount'] = _amount;
    return map;
  }

}