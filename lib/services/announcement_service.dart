import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:payroll_app/models/AnnouncementResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';

class AnnouncementService {
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

  Future<AnnouncementResponse> fetchAnnouncement() async {
    _dio.interceptors.add(LoggingInterceptors());

    AnnouncementResponse announcement = AnnouncementResponse();
    String token = await getToken();
    try {
      Response response = await _dio.get('/announcements',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP announcement : ${response.data}');

      announcement = AnnouncementResponse.fromJson(response.data);

    } on DioError catch (e) {
      debugPrint('ERROR : ${e.response.toString()}');
      announcement.message = e.message;
      announcement.status = false;
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      announcement.message = e.toString();
      announcement.status = false;
    }

    return announcement;
  }
}
