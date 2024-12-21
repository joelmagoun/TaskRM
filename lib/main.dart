//import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:TaskRM/app.dart';
import 'package:TaskRM/powersync.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/config/app_config.dart';
import 'package:TaskRM/utils/config/constants.dart';

import 'attachments/queue.dart';

void main() async {
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
          '[${record.loggerName}] ${record.level.name}: ${record.time}: ${record.message}');

      if (record.error != null) {
        print(record.error);
      }
      if (record.stackTrace != null) {
        print(record.stackTrace);
      }
    }
  });
  WidgetsFlutterBinding
      .ensureInitialized(); //required to get sqlite filepath from path_provider before UI has initialized
  await openDatabase();
  if (AppConfig.supabaseStorageBucket.isNotEmpty) {
    //  initializeAttachmentQueue(db);
  }

  final loggedIn = isLoggedIn();

  // final String sessionId = await AppStorage.getSessionId()  ?? '';
  runApp(MyApp(isLoggedId: loggedIn));
}
