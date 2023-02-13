import 'package:dio/dio.dart';
import 'package:payroll_app/models/SlipDetail.dart';
import 'package:payroll_app/models/TimeOffRequestDetail.dart';
import 'package:payroll_app/models/TimeOffRequestList.dart';
import 'package:payroll_app/models/TimeOffTypeList.dart';
import 'package:payroll_app/models/UniversalResponse.dart';
import 'package:payroll_app/services/secure_storage.dart';
import 'package:payroll_app/helpers/Constant.dart' as constants;

import '../helpers/LoggingInterceptors.dart';
import '../models/TimeOffBalanceDetail.dart';
import '../models/TimeOffEmployeeList.dart';

class SlipService {

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

  Future<SlipDetail> fetchSlipDetail(String month) async {
    _dio.interceptors.add(LoggingInterceptors());

    SlipDetail resp = SlipDetail();
    String token = await getToken();
    try {

      Response response = await _dio.get(
        queryParameters: {'month':month},
        '/slip/detail',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

      resp = SlipDetail.fromJson(response.data);

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
