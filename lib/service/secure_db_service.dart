import 'package:first_app/model/secure_password_item.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureDbService {
  final _storage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(SecurePasswordItem item) async {
    await _storage.write(
        key: item.key, value: item.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData(String key) async {
    var readData =
        await _storage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }
}
