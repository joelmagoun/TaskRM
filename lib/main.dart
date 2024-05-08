import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:task_rm/app.dart';
import 'package:task_rm/utils/app_storage.dart';
import 'package:task_rm/utils/config/constants.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Client client = Client();
  client
      .setEndpoint(AppWriteConstant.endPoint)
      .setProject(AppWriteConstant.projectId)
      .setSelfSigned(status: true);

  final String sessionId = await AppStorage.getSessionId()  ?? '';

  runApp(MyApp(client: client, sessionId: sessionId));

}

