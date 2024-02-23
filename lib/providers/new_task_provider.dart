import 'package:flutter/material.dart';


class NewTaskProvider extends ChangeNotifier {

  late bool _isJiraIssueAdded = false;
  bool get isJiraIssueAdded => _isJiraIssueAdded;

  late String _jiraId = '';
  String get jiraId => _jiraId;

  NewTaskProvider() {
    _init();
  }

  _init() {}

  setJiraId (String jiraID, bool value){

    _jiraId = jiraID;
    notifyListeners();
    _isJiraIssueAdded = value;
    notifyListeners();

  }

}
