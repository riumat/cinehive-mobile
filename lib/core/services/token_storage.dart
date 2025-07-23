import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenExpiryKey = 'token_expiry';

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    DateTime? expiresAt,
  }) async {
    final expiry = expiresAt ?? _extractExpiryFromJWT(accessToken);
    
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      if (expiry != null)
        _storage.write(key: _tokenExpiryKey, value: expiry.millisecondsSinceEpoch.toString()),
    ]);
  }

  static Future<String?> getAccessToken() async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null) return null;
    
    if (await isTokenExpired()) {
      return null;
    }
    
    return token;
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  static Future<bool> isTokenExpired() async {
    final expiryString = await _storage.read(key: _tokenExpiryKey);
    if (expiryString == null) return false;
    
    final expiry = DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
    final now = DateTime.now();
    
    return now.isAfter(expiry.subtract(const Duration(minutes: 5)));
  }

  static Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _tokenExpiryKey),
    ]);
  }

  static Future<bool> hasValidToken() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    if (accessToken == null || accessToken.isEmpty) return false;
    return !(await isTokenExpired());
  }

  static DateTime? _extractExpiryFromJWT(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      
      final payload = parts[1];
      final normalized = base64.normalize(payload);
      final decoded = utf8.decode(base64.decode(normalized));
      final Map<String, dynamic> payloadMap = json.decode(decoded);
      
      final exp = payloadMap['exp'];
      if (exp != null) {
        return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      }
    } catch (e) {
      print('Error extracting expiry from JWT: $e');
    }
    return null;
  }
}