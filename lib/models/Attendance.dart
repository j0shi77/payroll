class Attendance {
  Attendance({
      this.id,
      this.shiftId,
      this.employeeId,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.shiftName,
      this.workingHourStart,
      this.workingHourEnd,
      this.showInRequest});

  Attendance.fromJson(dynamic json) {
    id = json['id'];
    shiftId = json['shift_id'];
    employeeId = json['employee_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    shiftName = json['shift_name'];
    workingHourStart = json['working_hour_start'];
    workingHourEnd = json['working_hour_end'];
    showInRequest = json['show_in_request'];
  }
  int? id;
  int? shiftId;
  int? employeeId;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  String? shiftName;
  String? workingHourStart;
  String? workingHourEnd;
  int? showInRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['shift_id'] = shiftId;
    map['employee_id'] = employeeId;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['shift_name'] = shiftName;
    map['working_hour_start'] = workingHourStart;
    map['working_hour_end'] = workingHourEnd;
    map['show_in_request'] = showInRequest;
    return map;
  }

}