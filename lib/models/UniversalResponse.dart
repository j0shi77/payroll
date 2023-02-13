class UniversalResponse {
  UniversalResponse({
      this.status, 
      this.message,});

  UniversalResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  int ?status;
  String ?message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}