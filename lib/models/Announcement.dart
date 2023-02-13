class Announcement {
  Announcement({
      this.id, 
      this.announcementDate, 
      this.announcementTitle, 
      this.announcement, 
      this.month, 
      this.createdBy, 
      this.createdAt, 
      this.updatedAt,});

  Announcement.fromJson(dynamic json) {
    id = json['id'];
    announcementDate = json['announcement_date'];
    announcementTitle = json['announcement_title'];
    announcement = json['announcement'];
    month = json['month'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? announcementDate;
  String? announcementTitle;
  String? announcement;
  String? month;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['announcement_date'] = announcementDate;
    map['announcement_title'] = announcementTitle;
    map['announcement'] = announcement;
    map['month'] = month;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}