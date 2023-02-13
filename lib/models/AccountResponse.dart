/// status : 200
/// message : "Ok"
/// data : {"id":389,"full_name":"sakti tua petrus davici banjarnahor","first_name":"sakti tua petrus davici","last_name":"banjarnahor","employee_id":"TADS389","job_position_name":"Marketing","job_level_name":"Supervisor","department_name":null,"branch_name":"Pusat","organization_name":"TADS","email":"saktitua14@gmail.com","mobile_phone":"0813098340328","avatar":"tads1633929577_32210364725b186f39be2cf95b3d57f7.png","ktp_number":"","passport_number":null,"place_of_birth":"binjai","date_of_birth":"1900-01-01","gender":"Male","marital_status":"Not married yet","blood_type":"O","religion":"Islam","expired_identity":"Permanent","postal_code":"1208343","residential_address":"Jl Pemalang lagi","barcode":"0120901903","employee_status":"Active","join_date":"2022-09-06","end_date":"1900-01-01","bpjs_kerja_number":"10012902132327","bpjs_kesehatan_number":"93039034934","is_bpjs_active":"Active","npwp":"12900000124","bank_name":"BCA","account_number":"109309300434","account_holder_name":"Rido Panca Sakti sukma","years_of_service":"122 Years 9 Months 8 Days"}

class AccountResponse {
  AccountResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AccountResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
AccountResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => AccountResponse(  status: status ?? _status,
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


/// id : 389
/// full_name : "sakti tua petrus davici banjarnahor"
/// first_name : "sakti tua petrus davici"
/// last_name : "banjarnahor"
/// employee_id : "TADS389"
/// job_position_name : "Marketing"
/// job_level_name : "Supervisor"
/// department_name : null
/// branch_name : "Pusat"
/// organization_name : "TADS"
/// email : "saktitua14@gmail.com"
/// mobile_phone : "0813098340328"
/// avatar : "tads1633929577_32210364725b186f39be2cf95b3d57f7.png"
/// ktp_number : ""
/// passport_number : null
/// place_of_birth : "binjai"
/// date_of_birth : "1900-01-01"
/// gender : "Male"
/// marital_status : "Not married yet"
/// blood_type : "O"
/// religion : "Islam"
/// expired_identity : "Permanent"
/// postal_code : "1208343"
/// residential_address : "Jl Pemalang lagi"
/// barcode : "0120901903"
/// employee_status : "Active"
/// join_date : "2022-09-06"
/// end_date : "1900-01-01"
/// bpjs_kerja_number : "10012902132327"
/// bpjs_kesehatan_number : "93039034934"
/// is_bpjs_active : "Active"
/// npwp : "12900000124"
/// bank_name : "BCA"
/// account_number : "109309300434"
/// account_holder_name : "Rido Panca Sakti sukma"
/// years_of_service : "122 Years 9 Months 8 Days"

class Data {
  Data({
      num? id, 
      String? fullName, 
      String? firstName, 
      String? lastName, 
      String? employeeId, 
      String? jobPositionName, 
      String? jobLevelName, 
      dynamic departmentName, 
      String? branchName, 
      String? organizationName, 
      String? email, 
      String? mobilePhone, 
      String? avatar, 
      String? ktpNumber, 
      dynamic passportNumber, 
      String? placeOfBirth, 
      String? dateOfBirth, 
      String? gender, 
      String? maritalStatus, 
      String? bloodType, 
      String? religion, 
      String? expiredIdentity, 
      String? postalCode, 
      String? residentialAddress, 
      String? barcode, 
      String? employeeStatus, 
      String? joinDate, 
      String? endDate, 
      String? bpjsKerjaNumber, 
      String? bpjsKesehatanNumber, 
      String? isBpjsActive, 
      String? npwp, 
      String? bankName, 
      String? accountNumber, 
      String? accountHolderName, 
      String? yearsOfService,}){
    _id = id;
    _fullName = fullName;
    _firstName = firstName;
    _lastName = lastName;
    _employeeId = employeeId;
    _jobPositionName = jobPositionName;
    _jobLevelName = jobLevelName;
    _departmentName = departmentName;
    _branchName = branchName;
    _organizationName = organizationName;
    _email = email;
    _mobilePhone = mobilePhone;
    _avatar = avatar;
    _ktpNumber = ktpNumber;
    _passportNumber = passportNumber;
    _placeOfBirth = placeOfBirth;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _maritalStatus = maritalStatus;
    _bloodType = bloodType;
    _religion = religion;
    _expiredIdentity = expiredIdentity;
    _postalCode = postalCode;
    _residentialAddress = residentialAddress;
    _barcode = barcode;
    _employeeStatus = employeeStatus;
    _joinDate = joinDate;
    _endDate = endDate;
    _bpjsKerjaNumber = bpjsKerjaNumber;
    _bpjsKesehatanNumber = bpjsKesehatanNumber;
    _isBpjsActive = isBpjsActive;
    _npwp = npwp;
    _bankName = bankName;
    _accountNumber = accountNumber;
    _accountHolderName = accountHolderName;
    _yearsOfService = yearsOfService;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _employeeId = json['employee_id'];
    _jobPositionName = json['job_position_name'];
    _jobLevelName = json['job_level_name'];
    _departmentName = json['department_name'];
    _branchName = json['branch_name'];
    _organizationName = json['organization_name'];
    _email = json['email'];
    _mobilePhone = json['mobile_phone'];
    _avatar = json['avatar'];
    _ktpNumber = json['ktp_number'];
    _passportNumber = json['passport_number'];
    _placeOfBirth = json['place_of_birth'];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _maritalStatus = json['marital_status'];
    _bloodType = json['blood_type'];
    _religion = json['religion'];
    _expiredIdentity = json['expired_identity'];
    _postalCode = json['postal_code'];
    _residentialAddress = json['residential_address'];
    _barcode = json['barcode'];
    _employeeStatus = json['employee_status'];
    _joinDate = json['join_date'];
    _endDate = json['end_date'];
    _bpjsKerjaNumber = json['bpjs_kerja_number'];
    _bpjsKesehatanNumber = json['bpjs_kesehatan_number'];
    _isBpjsActive = json['is_bpjs_active'];
    _npwp = json['npwp'];
    _bankName = json['bank_name'];
    _accountNumber = json['account_number'];
    _accountHolderName = json['account_holder_name'];
    _yearsOfService = json['years_of_service'];
  }
  num? _id;
  String? _fullName;
  String? _firstName;
  String? _lastName;
  String? _employeeId;
  String? _jobPositionName;
  String? _jobLevelName;
  dynamic _departmentName;
  String? _branchName;
  String? _organizationName;
  String? _email;
  String? _mobilePhone;
  String? _avatar;
  String? _ktpNumber;
  dynamic _passportNumber;
  String? _placeOfBirth;
  String? _dateOfBirth;
  String? _gender;
  String? _maritalStatus;
  String? _bloodType;
  String? _religion;
  String? _expiredIdentity;
  String? _postalCode;
  String? _residentialAddress;
  String? _barcode;
  String? _employeeStatus;
  String? _joinDate;
  String? _endDate;
  String? _bpjsKerjaNumber;
  String? _bpjsKesehatanNumber;
  String? _isBpjsActive;
  String? _npwp;
  String? _bankName;
  String? _accountNumber;
  String? _accountHolderName;
  String? _yearsOfService;
Data copyWith({  num? id,
  String? fullName,
  String? firstName,
  String? lastName,
  String? employeeId,
  String? jobPositionName,
  String? jobLevelName,
  dynamic departmentName,
  String? branchName,
  String? organizationName,
  String? email,
  String? mobilePhone,
  String? avatar,
  String? ktpNumber,
  dynamic passportNumber,
  String? placeOfBirth,
  String? dateOfBirth,
  String? gender,
  String? maritalStatus,
  String? bloodType,
  String? religion,
  String? expiredIdentity,
  String? postalCode,
  String? residentialAddress,
  String? barcode,
  String? employeeStatus,
  String? joinDate,
  String? endDate,
  String? bpjsKerjaNumber,
  String? bpjsKesehatanNumber,
  String? isBpjsActive,
  String? npwp,
  String? bankName,
  String? accountNumber,
  String? accountHolderName,
  String? yearsOfService,
}) => Data(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  employeeId: employeeId ?? _employeeId,
  jobPositionName: jobPositionName ?? _jobPositionName,
  jobLevelName: jobLevelName ?? _jobLevelName,
  departmentName: departmentName ?? _departmentName,
  branchName: branchName ?? _branchName,
  organizationName: organizationName ?? _organizationName,
  email: email ?? _email,
  mobilePhone: mobilePhone ?? _mobilePhone,
  avatar: avatar ?? _avatar,
  ktpNumber: ktpNumber ?? _ktpNumber,
  passportNumber: passportNumber ?? _passportNumber,
  placeOfBirth: placeOfBirth ?? _placeOfBirth,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  gender: gender ?? _gender,
  maritalStatus: maritalStatus ?? _maritalStatus,
  bloodType: bloodType ?? _bloodType,
  religion: religion ?? _religion,
  expiredIdentity: expiredIdentity ?? _expiredIdentity,
  postalCode: postalCode ?? _postalCode,
  residentialAddress: residentialAddress ?? _residentialAddress,
  barcode: barcode ?? _barcode,
  employeeStatus: employeeStatus ?? _employeeStatus,
  joinDate: joinDate ?? _joinDate,
  endDate: endDate ?? _endDate,
  bpjsKerjaNumber: bpjsKerjaNumber ?? _bpjsKerjaNumber,
  bpjsKesehatanNumber: bpjsKesehatanNumber ?? _bpjsKesehatanNumber,
  isBpjsActive: isBpjsActive ?? _isBpjsActive,
  npwp: npwp ?? _npwp,
  bankName: bankName ?? _bankName,
  accountNumber: accountNumber ?? _accountNumber,
  accountHolderName: accountHolderName ?? _accountHolderName,
  yearsOfService: yearsOfService ?? _yearsOfService,
);
  num? get id => _id;
  String? get fullName => _fullName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get employeeId => _employeeId;
  String? get jobPositionName => _jobPositionName;
  String? get jobLevelName => _jobLevelName;
  dynamic get departmentName => _departmentName;
  String? get branchName => _branchName;
  String? get organizationName => _organizationName;
  String? get email => _email;
  String? get mobilePhone => _mobilePhone;
  String? get avatar => _avatar;
  String? get ktpNumber => _ktpNumber;
  dynamic get passportNumber => _passportNumber;
  String? get placeOfBirth => _placeOfBirth;
  String? get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get maritalStatus => _maritalStatus;
  String? get bloodType => _bloodType;
  String? get religion => _religion;
  String? get expiredIdentity => _expiredIdentity;
  String? get postalCode => _postalCode;
  String? get residentialAddress => _residentialAddress;
  String? get barcode => _barcode;
  String? get employeeStatus => _employeeStatus;
  String? get joinDate => _joinDate;
  String? get endDate => _endDate;
  String? get bpjsKerjaNumber => _bpjsKerjaNumber;
  String? get bpjsKesehatanNumber => _bpjsKesehatanNumber;
  String? get isBpjsActive => _isBpjsActive;
  String? get npwp => _npwp;
  String? get bankName => _bankName;
  String? get accountNumber => _accountNumber;
  String? get accountHolderName => _accountHolderName;
  String? get yearsOfService => _yearsOfService;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['employee_id'] = _employeeId;
    map['job_position_name'] = _jobPositionName;
    map['job_level_name'] = _jobLevelName;
    map['department_name'] = _departmentName;
    map['branch_name'] = _branchName;
    map['organization_name'] = _organizationName;
    map['email'] = _email;
    map['mobile_phone'] = _mobilePhone;
    map['avatar'] = _avatar;
    map['ktp_number'] = _ktpNumber;
    map['passport_number'] = _passportNumber;
    map['place_of_birth'] = _placeOfBirth;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['marital_status'] = _maritalStatus;
    map['blood_type'] = _bloodType;
    map['religion'] = _religion;
    map['expired_identity'] = _expiredIdentity;
    map['postal_code'] = _postalCode;
    map['residential_address'] = _residentialAddress;
    map['barcode'] = _barcode;
    map['employee_status'] = _employeeStatus;
    map['join_date'] = _joinDate;
    map['end_date'] = _endDate;
    map['bpjs_kerja_number'] = _bpjsKerjaNumber;
    map['bpjs_kesehatan_number'] = _bpjsKesehatanNumber;
    map['is_bpjs_active'] = _isBpjsActive;
    map['npwp'] = _npwp;
    map['bank_name'] = _bankName;
    map['account_number'] = _accountNumber;
    map['account_holder_name'] = _accountHolderName;
    map['years_of_service'] = _yearsOfService;
    return map;
  }

}