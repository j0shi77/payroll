/// status : 200
/// message : "Ok"
/// data : {"beginning":{"start_date":"2023-01-27","value":12},"remaining":{"remaining":11,"value_taken":1,"taken_value":-1},"adjustment":[{"generate_by":"Akbar","start_date":"2023-01-31","end_date":"2023-02-02","value":2}],"time_off_taken":[{"start_date":"2023-01-31","end_date":"2023-02-02","value":-1,"note":"test"}],"carry_forward":[{"start_date":"2023-01-31","end_date":"2023-02-02","value":1}],"expired":[{"expired_at":"2023-01-27","time_off_dsc":"Cuti Tahunan","value":1}]}

class TimeOffBalanceDetail {
  TimeOffBalanceDetail({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TimeOffBalanceDetail.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
TimeOffBalanceDetail copyWith({  num? status,
  String? message,
  Data? data,
}) => TimeOffBalanceDetail(  status: status ?? _status,
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

/// beginning : {"start_date":"2023-01-27","value":12}
/// remaining : {"remaining":11,"value_taken":1,"taken_value":-1}
/// adjustment : [{"generate_by":"Akbar","start_date":"2023-01-31","end_date":"2023-02-02","value":2}]
/// time_off_taken : [{"start_date":"2023-01-31","end_date":"2023-02-02","value":-1,"note":"test"}]
/// carry_forward : [{"start_date":"2023-01-31","end_date":"2023-02-02","value":1}]
/// expired : [{"expired_at":"2023-01-27","time_off_dsc":"Cuti Tahunan","value":1}]

class Data {
  Data({
      Beginning? beginning, 
      Remaining? remaining, 
      List<Adjustment>? adjustment, 
      List<TimeOffTaken>? timeOffTaken, 
      List<CarryForward>? carryForward, 
      List<Expired>? expired,}){
    _beginning = beginning;
    _remaining = remaining;
    _adjustment = adjustment;
    _timeOffTaken = timeOffTaken;
    _carryForward = carryForward;
    _expired = expired;
}

  Data.fromJson(dynamic json) {
    _beginning = json['beginning'] != null ? Beginning.fromJson(json['beginning']) : null;
    _remaining = json['remaining'] != null ? Remaining.fromJson(json['remaining']) : null;
    if (json['adjustment'] != null) {
      _adjustment = [];
      json['adjustment'].forEach((v) {
        _adjustment?.add(Adjustment.fromJson(v));
      });
    }
    if (json['time_off_taken'] != null) {
      _timeOffTaken = [];
      json['time_off_taken'].forEach((v) {
        _timeOffTaken?.add(TimeOffTaken.fromJson(v));
      });
    }
    if (json['carry_forward'] != null) {
      _carryForward = [];
      json['carry_forward'].forEach((v) {
        _carryForward?.add(CarryForward.fromJson(v));
      });
    }
    if (json['expired'] != null) {
      _expired = [];
      json['expired'].forEach((v) {
        _expired?.add(Expired.fromJson(v));
      });
    }
  }
  Beginning? _beginning;
  Remaining? _remaining;
  List<Adjustment>? _adjustment;
  List<TimeOffTaken>? _timeOffTaken;
  List<CarryForward>? _carryForward;
  List<Expired>? _expired;
Data copyWith({  Beginning? beginning,
  Remaining? remaining,
  List<Adjustment>? adjustment,
  List<TimeOffTaken>? timeOffTaken,
  List<CarryForward>? carryForward,
  List<Expired>? expired,
}) => Data(  beginning: beginning ?? _beginning,
  remaining: remaining ?? _remaining,
  adjustment: adjustment ?? _adjustment,
  timeOffTaken: timeOffTaken ?? _timeOffTaken,
  carryForward: carryForward ?? _carryForward,
  expired: expired ?? _expired,
);
  Beginning? get beginning => _beginning;
  Remaining? get remaining => _remaining;
  List<Adjustment>? get adjustment => _adjustment;
  List<TimeOffTaken>? get timeOffTaken => _timeOffTaken;
  List<CarryForward>? get carryForward => _carryForward;
  List<Expired>? get expired => _expired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_beginning != null) {
      map['beginning'] = _beginning?.toJson();
    }
    if (_remaining != null) {
      map['remaining'] = _remaining?.toJson();
    }
    if (_adjustment != null) {
      map['adjustment'] = _adjustment?.map((v) => v.toJson()).toList();
    }
    if (_timeOffTaken != null) {
      map['time_off_taken'] = _timeOffTaken?.map((v) => v.toJson()).toList();
    }
    if (_carryForward != null) {
      map['carry_forward'] = _carryForward?.map((v) => v.toJson()).toList();
    }
    if (_expired != null) {
      map['expired'] = _expired?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// expired_at : "2023-01-27"
/// time_off_dsc : "Cuti Tahunan"
/// value : 1

class Expired {
  Expired({
      String? expiredAt, 
      String? timeOffDsc, 
      num? value,}){
    _expiredAt = expiredAt;
    _timeOffDsc = timeOffDsc;
    _value = value;
}

  Expired.fromJson(dynamic json) {
    _expiredAt = json['expired_at'];
    _timeOffDsc = json['time_off_dsc'];
    _value = json['value'];
  }
  String? _expiredAt;
  String? _timeOffDsc;
  num? _value;
Expired copyWith({  String? expiredAt,
  String? timeOffDsc,
  num? value,
}) => Expired(  expiredAt: expiredAt ?? _expiredAt,
  timeOffDsc: timeOffDsc ?? _timeOffDsc,
  value: value ?? _value,
);
  String? get expiredAt => _expiredAt;
  String? get timeOffDsc => _timeOffDsc;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expired_at'] = _expiredAt;
    map['time_off_dsc'] = _timeOffDsc;
    map['value'] = _value;
    return map;
  }

}

/// start_date : "2023-01-31"
/// end_date : "2023-02-02"
/// value : 1

class CarryForward {
  CarryForward({
      String? startDate, 
      String? endDate, 
      num? value,}){
    _startDate = startDate;
    _endDate = endDate;
    _value = value;
}

  CarryForward.fromJson(dynamic json) {
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _value = json['value'];
  }
  String? _startDate;
  String? _endDate;
  num? _value;
CarryForward copyWith({  String? startDate,
  String? endDate,
  num? value,
}) => CarryForward(  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  value: value ?? _value,
);
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['value'] = _value;
    return map;
  }

}

/// start_date : "2023-01-31"
/// end_date : "2023-02-02"
/// value : -1
/// note : "test"

class TimeOffTaken {
  TimeOffTaken({
      String? startDate, 
      String? endDate, 
      num? value, 
      String? note,}){
    _startDate = startDate;
    _endDate = endDate;
    _value = value;
    _note = note;
}

  TimeOffTaken.fromJson(dynamic json) {
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _value = json['value'];
    _note = json['note'];
  }
  String? _startDate;
  String? _endDate;
  num? _value;
  String? _note;
TimeOffTaken copyWith({  String? startDate,
  String? endDate,
  num? value,
  String? note,
}) => TimeOffTaken(  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  value: value ?? _value,
  note: note ?? _note,
);
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get value => _value;
  String? get note => _note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['value'] = _value;
    map['note'] = _note;
    return map;
  }

}

/// generate_by : "Akbar"
/// start_date : "2023-01-31"
/// end_date : "2023-02-02"
/// value : 2

class Adjustment {
  Adjustment({
      String? generateBy, 
      String? startDate, 
      String? endDate, 
      num? value,}){
    _generateBy = generateBy;
    _startDate = startDate;
    _endDate = endDate;
    _value = value;
}

  Adjustment.fromJson(dynamic json) {
    _generateBy = json['generate_by'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _value = json['value'];
  }
  String? _generateBy;
  String? _startDate;
  String? _endDate;
  num? _value;
Adjustment copyWith({  String? generateBy,
  String? startDate,
  String? endDate,
  num? value,
}) => Adjustment(  generateBy: generateBy ?? _generateBy,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  value: value ?? _value,
);
  String? get generateBy => _generateBy;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generate_by'] = _generateBy;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['value'] = _value;
    return map;
  }

}

/// remaining : 11
/// value_taken : 1
/// taken_value : -1

class Remaining {
  Remaining({
      num? remaining, 
      num? valueTaken, 
      num? takenValue,}){
    _remaining = remaining;
    _valueTaken = valueTaken;
    _takenValue = takenValue;
}

  Remaining.fromJson(dynamic json) {
    _remaining = json['remaining'];
    _valueTaken = json['value_taken'];
    _takenValue = json['taken_value'];
  }
  num? _remaining;
  num? _valueTaken;
  num? _takenValue;
Remaining copyWith({  num? remaining,
  num? valueTaken,
  num? takenValue,
}) => Remaining(  remaining: remaining ?? _remaining,
  valueTaken: valueTaken ?? _valueTaken,
  takenValue: takenValue ?? _takenValue,
);
  num? get remaining => _remaining;
  num? get valueTaken => _valueTaken;
  num? get takenValue => _takenValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remaining'] = _remaining;
    map['value_taken'] = _valueTaken;
    map['taken_value'] = _takenValue;
    return map;
  }

}

/// start_date : "2023-01-27"
/// value : 12

class Beginning {
  Beginning({
      String? startDate, 
      num? value,}){
    _startDate = startDate;
    _value = value;
}

  Beginning.fromJson(dynamic json) {
    _startDate = json['start_date'];
    _value = json['value'];
  }
  String? _startDate;
  num? _value;
Beginning copyWith({  String? startDate,
  num? value,
}) => Beginning(  startDate: startDate ?? _startDate,
  value: value ?? _value,
);
  String? get startDate => _startDate;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_date'] = _startDate;
    map['value'] = _value;
    return map;
  }

}