import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static String FULL_NAME = 'full_name';

  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future writeSecureData({required String key, String? value}) async {
    var writeData = await _storage.write(
        key: key, value: value, aOptions: _getAndroidOptions());
    return writeData;
  }

  Future readSecureData({required String key}) async {
    var readData =
        await _storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future deleteSecureData({required String key}) async {
    var deleteData =
        await _storage.delete(key: key, aOptions: _getAndroidOptions());
    return deleteData;
  }
}
