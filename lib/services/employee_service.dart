import 'package:dio/dio.dart';
import 'package:payroll_app/models/EmployeeList.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';

class EmployeeService {
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

  Future<EmployeeList> fetchEmployeeList(String q) async {
    _dio.interceptors.add(LoggingInterceptors());

    EmployeeList resp = EmployeeList();
    String token = await getToken();
    try {
      Response response = await _dio.get('/employee/list',
          queryParameters: { 'q' : q },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      prints('RESP /employee/list : ${response.data}');

      resp = EmployeeList.fromJson(response.data);

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
