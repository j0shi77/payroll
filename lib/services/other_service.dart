import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payroll_app/models/AnnouncementResponse.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';
import '../models/CalendarResponse.dart';

class OtherService {
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

  Future<CalendarResponse> fetchCalendar(String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    CalendarResponse resp = CalendarResponse();
    String token = await getToken();
    try {
      Response response = await _dio.get('/other/calendar',
          queryParameters: { 'month' : month },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP announcement : ${response.data}');

      resp = CalendarResponse.fromJson(response.data);

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

  Future<UniversalResponse> fetchCheckPassword(String password) async {
    _dio.interceptors.add(LoggingInterceptors());

    UniversalResponse resp = UniversalResponse();
    String token = await getToken();
    try {
      Response response = await _dio.post('/other/check-password',
          data: { 'password' : password },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP check-password : ${response.data}');

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
