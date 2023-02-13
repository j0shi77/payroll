class AttendanceHistory {
  AttendanceHistory({
      this.id, 
      this.attendanceId, 
      this.employeeId, 
      this.attendanceCode, 
      this.attendanceType, 
      this.clockIn, 
      this.clockOut, 
      this.latitude, 
      this.longitude, 
      this.note, 
      this.image, 
      this.createdAt, 
      this.updatedAt,});

  AttendanceHistory.fromJson(dynamic json) {
    id = json['id'];
    attendanceId = json['attendance_id'];
    employeeId = json['employee_id'];
    attendanceCode = json['attendance_code'];
    attendanceType = json['attendance_type'];
    clockIn = json['clock_in'];
    clockOut = json['clock_out'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    note = json['note'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int ?id;
  int ?attendanceId;
  int ?employeeId;
  String ?attendanceCode;
  String ?attendanceType;
  String ?clockIn;
  String ?clockOut;
  String ?latitude;
  String ?longitude;
  String ?note;
  String ?image;
  String ?createdAt;
  String ?updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['attendance_id'] = attendanceId;
    map['employee_id'] = employeeId;
    map['attendance_code'] = attendanceCode;
    map['attendance_type'] = attendanceType;
    map['clock_in'] = clockIn;
    map['clock_out'] = clockOut;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['note'] = note;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}