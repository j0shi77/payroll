import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:payroll_app/models/auth/current_user.dart';
import 'package:payroll_app/models/auth/user_login.dart';
import 'package:payroll_app/helpers/Constant.dart' as _constants;
import 'package:payroll_app/services/secure_storage.dart';

import '../helpers/LoggingInterceptors.dart';

class AuthService {
  static final options = BaseOptions(
      baseUrl: _constants.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      followRedirects: false);

  final Dio _dio = Dio(options);

  final SecureStorage secureStorage = SecureStorage();

  Future<Userlogin?> login({required String email, required String password}) async {
    _dio.interceptors.add(LoggingInterceptors());

    Userlogin? userlogin;

    Map<String, dynamic> formData = {"email": email, "password": password};

    try {
      Response userData = await _dio.post('/login', data: json.encode(formData));
      debugPrint('userData : ${userData.toString()}');

      userlogin = Userlogin.fromJson(userData.data);

      if(userlogin.token != null) {
        userlogin.errorMessage = '';
      }

      secureStorage.writeSecureData(key: 'token', value: userlogin.token);
      secureStorage.writeSecureData(key: 'id', value: userlogin.user?.id.toString());
      secureStorage.writeSecureData(key: 'name', value: userlogin.user?.name);
      secureStorage.writeSecureData(key: 'avatar', value: userlogin.user?.avatar);
      secureStorage.writeSecureData(key: 'email', value: userlogin.user?.email);
      secureStorage.writeSecureData(key: 'name', value: userlogin.user?.name);

      return userlogin;
    } on DioError catch (e) {
      debugPrint('Error: ${e.error.toString()}');
      // debugPrint(e.response.toString());
      final userlogin = Userlogin();
      userlogin.errorMessage = e.message;
      return userlogin;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
      userlogin?.errorMessage = e.toString();
      return userlogin;
    }

  }

  Future getToken() async {
    String token = await secureStorage.readSecureData(key: 'token');
    return token;
  }

  void prints(var s1) {
    String s = s1.toString();
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(s).forEach((match) => kDebugMode ? print(match.group(0)) : '');
  }

  Future<CurrentUser?> fetchCurrentUser() async {
    _dio.interceptors.add(LoggingInterceptors());

    CurrentUser? currentUser;
    String token = await getToken();
    try {
      Response response = await _dio.get('/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      currentUser = CurrentUser.fromJson(response.data['data']);
    } on DioError catch (e) {
      debugPrint('Error : ${e.response.toString()}');
      e.stackTrace;
    } catch (e, stacktrace) {
      prints('ERROR : ${e.toString()} - $stacktrace');
    }

    return currentUser;
  }
}
