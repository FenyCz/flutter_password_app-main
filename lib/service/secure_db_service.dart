import 'package:first_app/model/secure_password_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDbService {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(
      FlutterSecureStorage storage, SecurePasswordItem item) async {
    await storage.write(
        key: item.key, value: item.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(
      FlutterSecureStorage storage, String key) async {
    var readData = await storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }
}
