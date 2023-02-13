class CurrentUser {
  int? id;
  User? user;
  Shift? shift;
  String? name;
  String? dob;
  String? pob;
  String? gender;
  String? phone;
  String? idCard;
  String? employeeStatus;
  String? merriageStatus;
  String? familyCard;
  String? idCardAddress;
  String? numberChildren;
  String? address;
  String? email;
  String? password;
  String? contractStatus;
  String? employeeId;
  int? branchId;
  int? departmentId;
  String? designationId;
  String? companyId;
  String? startDate;
  String? endDate;
  String? documents;
  String? accountHolderName;
  String? accountNumber;
  String? bankNumber;
  String? bankName;
  String? bankIdentifierCode;
  String? branchLocation;
  String? taxPayerId;
  String? salaryType;
  String? salary;
  String? calculateWork;
  String? amountWork;
  String? calculateSalary;
  String? amountSalary;
  String? netSalary;
  String? keterangan;
  int? isActive;
  String? amountOfLeave;
  String? amountPaidLeave;
  String? reason;
  int? firstLoginPassword;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  String? branchName;
  String? jobPositionName;

  CurrentUser(
      {
        this.id,
        this.user,
        this.shift,
        this.name,
        this.dob,
        this.pob,
        this.gender,
        this.phone,
        this.idCard,
        this.employeeStatus,
        this.merriageStatus,
        this.familyCard,
        this.idCardAddress,
        this.numberChildren,
        this.address,
        this.email,
        this.password,
        this.contractStatus,
        this.employeeId,
        this.branchId,
        this.departmentId,
        this.designationId,
        this.companyId,
        this.startDate,
        this.endDate,
        this.documents,
        this.accountHolderName,
        this.accountNumber,
        this.bankNumber,
        this.bankName,
        this.bankIdentifierCode,
        this.branchLocation,
        this.taxPayerId,
        this.salaryType,
        this.salary,
        this.calculateWork,
        this.amountWork,
        this.calculateSalary,
        this.amountSalary,
        this.netSalary,
        this.keterangan,
        this.isActive,
        this.amountOfLeave,
        this.amountPaidLeave,
        this.reason,
        this.firstLoginPassword,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.branchName,
        this.jobPositionName
      });

  CurrentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    shift = json['shift'] != null ? new Shift.fromJson(json['shift']) : null;
    name = json['name'];
    dob = json['dob'];
    pob = json['pob'];
    gender = json['gender'];
    phone = json['phone'];
    idCard = json['id_card'];
    employeeStatus = json['employee_status'];
    merriageStatus = json['merriage_status'];
    familyCard = json['family_card'];
    idCardAddress = json['id_card_address'];
    numberChildren = json['number_children'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    contractStatus = json['contract_status'];
    employeeId = json['employee_id'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    companyId = json['company_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    documents = json['documents'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    bankNumber = json['bank_number'];
    bankName = json['bank_name'];
    bankIdentifierCode = json['bank_identifier_code'];
    branchLocation = json['branch_location'];
    taxPayerId = json['tax_payer_id'];
    salaryType = json['salary_type'];
    salary = json['salary'];
    calculateWork = json['calculate_work'];
    amountWork = json['amount_work'];
    calculateSalary = json['calculate_salary'];
    amountSalary = json['amount_salary'];
    netSalary = json['net_salary'];
    keterangan = json['keterangan'];
    isActive = json['is_active'];
    amountOfLeave = json['amount_of_leave'];
    amountPaidLeave = json['amount_paid_leave'];
    reason = json['reason'];
    firstLoginPassword = json['first_login_password'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    branchName = json['branch_name'];
    jobPositionName = json['job_position_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.shift != null) {
      data['shift'] = this.shift!.toJson();
    }
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['pob'] = this.pob;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['id_card'] = this.idCard;
    data['employee_status'] = this.employeeStatus;
    data['merriage_status'] = this.merriageStatus;
    data['family_card'] = this.familyCard;
    data['id_card_address'] = this.idCardAddress;
    data['number_children'] = this.numberChildren;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    data['contract_status'] = this.contractStatus;
    data['employee_id'] = this.employeeId;
    data['branch_id'] = this.branchId;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['company_id'] = this.companyId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['documents'] = this.documents;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['bank_number'] = this.bankNumber;
    data['bank_name'] = this.bankName;
    data['bank_identifier_code'] = this.bankIdentifierCode;
    data['branch_location'] = this.branchLocation;
    data['tax_payer_id'] = this.taxPayerId;
    data['salary_type'] = this.salaryType;
    data['salary'] = this.salary;
    data['calculate_work'] = this.calculateWork;
    data['amount_work'] = this.amountWork;
    data['calculate_salary'] = this.calculateSalary;
    data['amount_salary'] = this.amountSalary;
    data['net_salary'] = this.netSalary;
    data['keterangan'] = this.keterangan;
    data['is_active'] = this.isActive;
    data['amount_of_leave'] = this.amountOfLeave;
    data['amount_paid_leave'] = this.amountPaidLeave;
    data['reason'] = this.reason;
    data['first_login_password'] = this.firstLoginPassword;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['branch_name'] = this.branchName;
    data['job_position_name'] = this.jobPositionName;
    return data;
  }
}

class User {
  int? id;
  int? branchId;
  String? name;
  String? noTelp;
  String? email;
  String? emailVerifiedAt;
  String? roleId;
  String? avatar;
  String? signature;
  String? lang;
  int? isActive;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  User(
      {
        this.id,
        this.branchId,
        this.name,
        this.noTelp,
        this.email,
        this.emailVerifiedAt,
        this.roleId,
        this.avatar,
        this.signature,
        this.lang,
        this.isActive,
        this.createdBy,
        this.createdAt,
        this.updatedAt
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    noTelp = json['no_telp'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    avatar = json['avatar'];
    signature = json['signature'];
    lang = json['lang'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['no_telp'] = this.noTelp;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['avatar'] = this.avatar;
    data['signature'] = this.signature;
    data['lang'] = this.lang;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shift {
  String? id;
  String? name;
  List<Calendar>? calendar;
  String? workingHourStart;
  String? workingHourEnd;
  String? createdAt;
  String? updatedAt;

  Shift({
        this.id,
        this.name,
        this.calendar,
        this.workingHourStart,
        this.workingHourEnd,
        this.createdAt,
        this.updatedAt
      });

  Shift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['calendar'] != null) {
      calendar = <Calendar>[];
      json['calendar'].forEach((v) {
        calendar!.add(new Calendar.fromJson(v));
      });
    }
    workingHourStart = json['working_hour_start'];
    workingHourEnd = json['working_hour_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.map((v) => v.toJson()).toList();
    }
    data['working_hour_start'] = this.workingHourStart;
    data['working_hour_end'] = this.workingHourEnd;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Calendar {
  String? id;
  String? fullDate;
  String? year;
  String? month;
  String? day;
  String? quarter;
  String? week;
  String? weekDay;
  String? dayName;
  String? monthName;
  String? holidayFlag;
  String? weekendFlag;
  Null? event;
  Pivot? pivot;

  Calendar(
      {
        this.id,
        this.fullDate,
        this.year,
        this.month,
        this.day,
        this.quarter,
        this.week,
        this.weekDay,
        this.dayName,
        this.monthName,
        this.holidayFlag,
        this.weekendFlag,
        this.event,
        this.pivot
      });

  Calendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullDate = json['full_date'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
    quarter = json['quarter'];
    week = json['week'];
    weekDay = json['week_day'];
    dayName = json['day_name'];
    monthName = json['month_name'];
    holidayFlag = json['holiday_flag'];
    weekendFlag = json['weekend_flag'];
    event = json['event'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_date'] = this.fullDate;
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    data['quarter'] = this.quarter;
    data['week'] = this.week;
    data['week_day'] = this.weekDay;
    data['day_name'] = this.dayName;
    data['month_name'] = this.monthName;
    data['holiday_flag'] = this.holidayFlag;
    data['weekend_flag'] = this.weekendFlag;
    data['event'] = this.event;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? shiftId;
  String? calendarId;

  Pivot({this.shiftId, this.calendarId});

  Pivot.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
    calendarId = json['calendar_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_id'] = this.shiftId;
    data['calendar_id'] = this.calendarId;
    return data;
  }
}
