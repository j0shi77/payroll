import 'Announcement.dart';

class AnnouncementResponse {
  AnnouncementResponse({
      this.status, 
      this.message, 
      this.data,});

  AnnouncementResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Announcement.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<Announcement>? data = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}