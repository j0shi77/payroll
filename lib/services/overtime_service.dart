import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:payroll_app/models/OvertimeDetail.dart';
import 'package:payroll_app/models/OvertimeList.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';

class OvertimeService {

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

  Future<UniversalResponse> fetchRequest(
      String date,
      String compensationType,
      String overtimeBefore,
      String breakBefore,
      String overtimeAfter,
      String breakAfter,
      String notes,
      List<String> images) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/overtime/request',
          data: {
            "date_request": date,
            "compensation_type": compensationType,
            "overtime_before": overtimeBefore,
            "break_before": breakBefore,
            "overtime_after": overtimeBefore,
            "break_after": breakBefore,
            "notes": notes,
            "images": images
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

  Future<OvertimeList> fetchOvertimeList(
      String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    OvertimeList resp = OvertimeList();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/overtime/list',
          data: {
            "month": month
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = OvertimeList.fromJson(response.data);

    } on DioError catch (e) {
      prints('ERROR : ${e.response.toString()}');
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

  Future<OvertimeDetail> fetchOvertimeDetail(
      num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    OvertimeDetail resp = OvertimeDetail();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/overtime/detail',
          data: {
            "id": id
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = OvertimeDetail.fromJson(response.data);

    } on DioError catch (e) {
      prints('ERROR : ${e.response.toString()}');
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
          '/overtime/cancel-request',
          data: {
            "overtime_id": id
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
