import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyToken = "token";

  static Future setJWT(String token) async =>
      await _storage.write(key: _keyToken, value: token);

  static Future<String> getJWT() async => await _storage.read(key: _keyToken);

  static Future deleteJWT() async => await _storage.delete(key: _keyToken);

  static bool isConnected = false;

  static int userId;
}
