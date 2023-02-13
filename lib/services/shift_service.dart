import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:payroll_app/models/OvertimeDetail.dart';
import 'package:payroll_app/models/OvertimeList.dart';
import 'package:payroll_app/models/ShiftMaster.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';
import '../models/ShiftDetail.dart';
import '../models/ShiftList.dart';

class ShiftService {

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
      String effectiveDate,
      String newShiftId,
      String notes) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/shift/request',
          data: {
            "effective_date": effectiveDate,
            "new_shift_id" : newShiftId,
            "notes": notes,
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

  Future<ShiftList> fetchShiftList(String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    ShiftList resp = ShiftList();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/shift/list',
          data: {
            "month": month
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = ShiftList.fromJson(response.data);

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

  Future<ShiftDetail> fetchOvertimeDetail(
      num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    ShiftDetail resp = ShiftDetail();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/shift/detail',
          data: {
            "id": id
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = ShiftDetail.fromJson(response.data);

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
          '/shift/cancel-request',
          data: {
            "shift_id": id
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

  Future<ShiftMaster> fetchShiftMaster() async {
    _dio.interceptors.add(LoggingInterceptors());

    ShiftMaster resp = ShiftMaster();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/shift/master',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = ShiftMaster.fromJson(response.data);

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

}
