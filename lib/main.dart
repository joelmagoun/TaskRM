import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:TaskRM/app.dart';
import 'package:TaskRM/utils/app_storage.dart';
import 'package:TaskRM/utils/config/constants.dart';


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

