import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class AppStorage{

  /// for acessToken  ///
  // static Future<void> setAccessToken(String value) async {
  //   await storage?.write(key: 'token', value: value);
  // }

static Future<String?> getSessionId() async {
  String? token = await storage.read(key: 'sessionId');
  return token;
}
//
// static Future<void> deleteAccessToken() async {
//   await storage?.delete(key: 'token');
// }
//
// /// user id ///
// static Future<String?> getUserId() async {
//   String? userId = await storage?.read(key: 'userId');
//   return userId;
// }
//
//
// static Future<void> deleteLocalStorage() async {
//   await storage?.deleteAll();
// }

}