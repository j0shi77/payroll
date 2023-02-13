import 'Attendance.dart';

class AttendanceResponse {
  AttendanceResponse({
      this.status,
      this.message,
      this.data,});

  AttendanceResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Attendance.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  Attendance? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}