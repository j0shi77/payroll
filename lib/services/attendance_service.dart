import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payroll_app/models/AnnouncementResponse.dart';
import 'package:payroll_app/models/AttendanceHistoryResponse.dart';
import 'package:payroll_app/models/AttendanceList.dart';
import 'package:payroll_app/models/AttendanceResponse.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';
import '../models/AttendanceRequestDetail.dart';
import '../models/AttendanceRequestList.dart';

class AttendanceService {
  static final options = BaseOptions(
      baseUrl: constants.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      followRedirects: false);

  final Dio _dio = Dio(options);

  final SecureStorage secureStorage = SecureStorage();

  Future getToken() async {
    String token = await secureStorage.readSecureData(key: 'token');
    return token;
  }

  void prints(var s1) {
    String s = s1.toString();
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(s).forEach((match) => print(match.group(0)));
  }

  Future<AttendanceResponse> fetchGetScheduleByDate(String date) async {
    _dio.interceptors.add(LoggingInterceptors());

    AttendanceResponse resp = AttendanceResponse();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/attendances/schedule-by-date',
          queryParameters: {
            "date": date
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP announcement : ${response.data}');

      resp = AttendanceResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

  Future<AttendanceHistoryResponse> fetchGetAttendanceHistory (String startDate, String endDate) async {
    _dio.interceptors.add(LoggingInterceptors());

    AttendanceHistoryResponse resp = AttendanceHistoryResponse();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/attendances/attendance-history',
          queryParameters: {
            "start_date": startDate,
            "end_date": endDate
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP announcement : ${response.data}');

      resp = AttendanceHistoryResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

  Future<UniversalResponse> fetchClockIn (String date, String clockIn, String latitude, String longitude, String note, String imageUrl) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/attendances/clock-in',
          data: {
            "date": date,
            "clock_in": clockIn,
            "latitude": latitude,
            "longitude": longitude,
            "note": note,
            "image": imageUrl
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = UniversalResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

  Future<UniversalResponse> fetchClockOut (String date, String clockOut, String latitude, String longitude, String note, String imageUrl) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/attendances/clock-out',
          data: {
            "date": date,
            "clock_out": clockOut,
            "latitude": latitude,
            "longitude": longitude,
            "note": note,
            "image": imageUrl
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = UniversalResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

  Future<AttendanceList> fetchAttendanceHistoryByMonth (String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    AttendanceList resp = AttendanceList();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/attendances/attendance-history-by-month',
          queryParameters: {
            "month": month
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = AttendanceList.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.setMessage = e.message;
      resp.setStatus = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.setMessage = e.toString();
      resp.setStatus = 400;
    }

    return resp;
  }

  Future<UniversalResponse> fetchAttendanceRequest (
      String date,
      String clockIn,
      String clockOut,
      String note) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/attendances/request',
          data: {
            "date": date,
            "clock_in" : clockIn,
            "clock_out" : clockOut,
            "note" : note
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = UniversalResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

  Future<AttendanceRequestList> fetchAttendanceRequestList (String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    AttendanceRequestList resp = AttendanceRequestList();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/attendances/request-list',
          queryParameters : {
            "month": month
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = AttendanceRequestList.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.setMessage(e.message);
      resp.setStatus(200);
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.setMessage(e.toString());
      resp.setStatus(400);
    }

    return resp;
  }

  Future<AttendanceRequestDetail> fetchAttendanceRequestDetail (num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    AttendanceRequestDetail resp = AttendanceRequestDetail();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/attendances/request-detail',
          queryParameters : {
            "id": id
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = AttendanceRequestDetail.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      resp.setMessage(e.message);
      resp.setStatus(200);
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.setMessage(e.toString());
      resp.setStatus(400);
    }

    return resp;
  }

  Future<UniversalResponse> fetchCancelRequest(
      num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/attendances/cancel-request',
          data: {
            "employee_request_attendance_id": id
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = UniversalResponse.fromJson(response.data);

    } on DioError catch (e) {
      prints('ERROR : ${e.response.toString()}');
      resp.message = e.message;
      resp.status = 200;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');

      resp.message = e.toString();
      resp.status = 400;
    }

    return resp;
  }

}
