import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/profile_provider.dart';
import '../routes/routes.dart';
import '../utils/app_storage.dart';
import '../utils/config/constants.dart';


class AuthProvider extends ChangeNotifier {
  Client client = Client();
  late Account account;

  /// these variables are for creating profile database in login ///
  late String _name = '';
  late String _encryption = '';
  late String _language = '';
  late String _jira = '';
  late String _jiraUserName = '';
  late String _jiraUrl = '';

  AuthProvider() {
    _init();
  }

  _init() {
    client
        .setEndpoint(AppWriteConstant.endPoint)
        .setProject(AppWriteConstant.projectId);
    account = Account(client);
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      var result =
          await account.createEmailSession(email: email, password: password);

      await storage.write(key: 'sessionId', value: result.$id);
      await storage.write(key: 'userId', value: result.userId);

      if (result.userId.isNotEmpty) {
        final _profileState =
            Provider.of<ProfileProvider>(context, listen: false);
        _profileState.saveProfile(
            _name, _encryption, _jira, _jiraUserName, _jiraUrl);
      }

      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      print('error is $e');
    }
  }


  /// sign up ///


  late bool isAccountCreating = false;

  Future<bool> signUp(
      String email,
      String password,
      String name,
      String encryption,
      String language,
      String jira,
      String jiraUserName,
      String jiraUrl,
      BuildContext context) async {
    try {

      isAccountCreating = true;
      notifyListeners();

      var result = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      _name = name;
      notifyListeners();

      _encryption = encryption;
      notifyListeners();

      _jira = jira;
      notifyListeners();

      _language = language;
      notifyListeners();

      _jiraUserName = jiraUserName;
      notifyListeners();

      _jiraUrl = jiraUrl;
      notifyListeners();

      return true;
     // Navigator.pushReplacementNamed(context, Routes.login);
    } catch (e) {
      print('sign up error ${e.toString()}');
      return false;
     }finally{
      isAccountCreating = false;
      notifyListeners();
    }
  }

  logout(BuildContext context) async {
    try {

      final sessionId = await storage.read(key: 'sessionId');
      final res = await account.deleteSession(sessionId: sessionId!);
      await storage.delete(key: 'sessionId');

      Navigator.pushNamed(context, Routes.login);
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

}
