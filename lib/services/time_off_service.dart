import 'package:dio/dio.dart';
import 'package:payroll_app/models/TimeOffRequestDetail.dart';
import 'package:payroll_app/models/TimeOffRequestList.dart';
import 'package:payroll_app/models/TimeOffTypeList.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';
import '../models/TimeOffBalanceDetail.dart';
import '../models/TimeOffEmployeeList.dart';

class TimeOffService {

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

  Future<TimeOffTypeList> fetchTimeOffList() async {
    _dio.interceptors.add(LoggingInterceptors());

    TimeOffTypeList resp = TimeOffTypeList();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/time_off/type_list',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/type_list : ${response.data}');

      resp = TimeOffTypeList.fromJson(response.data);

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

  Future<TimeOffEmployeeList> fetchEmployeeList(String q) async {
    _dio.interceptors.add(LoggingInterceptors());

    TimeOffEmployeeList resp = TimeOffEmployeeList();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/time_off/employee_list',
          queryParameters: {
            'q' : q
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = TimeOffEmployeeList.fromJson(response.data);

    } on DioError catch (e) {
      prints('ERROR : ${e.response.toString()}');
      resp.setMessage(e.message);
      resp.setStatus(200);
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.setMessage(e.toString());
      resp.setStatus(200);
    }

    return resp;
  }

  Future<UniversalResponse> fetchRequest(
      String timeOffId,
      startDate,
      endDate,
      List<String> images,
      String employeeId,
      requestType,
      scheduleIn, scheduleOut) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/time_off/request',
          data: {
            "timeoff_id": timeOffId,
            "start_date": startDate,
            "end_date": endDate,
            "images": images,
            "delegate" : employeeId,
            "requestType" : requestType,
            "scheduleIn" : scheduleIn,
            "scheduleOut" : scheduleOut
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
      resp.status = 200;
    }

    return resp;
  }

  Future<UniversalResponse> fetchCancelRequest(num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/time_off/cancel-request',
          data: {
            "time_off_balance_id": id
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

  Future<TimeOffRequestList> fetchTimeOffRequestList(
      String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    TimeOffRequestList resp = TimeOffRequestList();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/time_off/request-list',
          queryParameters: {
            "month": month
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = TimeOffRequestList.fromJson(response.data);

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

  Future<TimeOffBalanceDetail> fetchBalanceDetail(
      String year) async {
    _dio.interceptors.add(LoggingInterceptors());

    TimeOffBalanceDetail resp = TimeOffBalanceDetail();
    String token = await getToken();
    try {

      Response response = await _dio.post(
          '/time_off/balance-detail',
          data: {
            "year": year
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = TimeOffBalanceDetail.fromJson(response.data);

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

  Future<TimeOffRequestDetail> fetchRequestDetail(num id) async {
    _dio.interceptors.add(LoggingInterceptors());

    TimeOffRequestDetail resp = TimeOffRequestDetail();
    String token = await getToken();
    try {

      Response response = await _dio.get(
          '/time_off/request-detail',
          queryParameters: {
            'id' : id
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      // prints('RESP /time_off/employee_list : ${response.data}');

      resp = TimeOffRequestDetail.fromJson(response.data);

    } on DioError catch (e) {
      prints('ERROR : ${e.response.toString()}');
      resp.setMessage(e.message);
      resp.setStatus(200);
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      resp.setMessage(e.toString());
      resp.setStatus(200);
    }

    return resp;
  }
}
