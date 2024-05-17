import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class AppStorage {
  /// for acessToken  ///
  // static Future<void> setAccessToken(String value) async {
  //   await storage?.write(key: 'token', value: value);
  // }

  static Future<String?> getSessionId() async {
    String? sessionId = await storage.read(key: 'sessionId');
    return sessionId;
  }

  static Future<String?> getUserId() async {
    String? userId = await storage.read(key: 'userId');
    return userId;
  }

  static Future<String?> getImageUrl() async {
    String? imageUrl = await storage.read(key: 'imageUrl');
    return imageUrl;
  }

  static Future<String?> getImageFileId() async {
    String? imageFileId = await storage.read(key: 'image_file_id');
    return imageFileId;
  }

  static Future<void> deleteStorageData() async {
    await storage.deleteAll();
  }
}
