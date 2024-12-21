// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:atlassian_apis/jira_platform.dart';
// import 'package:flutter/widgets.dart';
// import 'package:TaskRM/src/models/comment.dart';
//
// class JiraProvider extends ChangeNotifier {
//   Client client = Client();
//   late Databases db;
//   late Storage _appWriteStorage;
//
//   var _jira;
//
//   late bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   late String _summary = '';
//   String get summary => _summary;
//
//   late String _status = '';
//   String get status => _status;
//
//   late String _priority = '';
//   String get priority => _priority;
//
//   late String _type = '';
//   String get type => _type;
//
//   late String _description = '';
//   String get description => _description;
//
//   late String _created = '';
//   String get created => _created;
//
//   late String _updated = '';
//   String get updated => _updated;
//
//   late List<CommentModel> _commentList = [];
//   List<CommentModel> get commentList => _commentList;
//
//   JiraProvider() {
//     //init();
//   }
//
//   init(String issueId) async {
//     client
//         .setEndpoint(AppWriteConstant.endPoint)
//         .setProject(AppWriteConstant.projectId);
//     db = Databases(client);
//     _appWriteStorage = Storage(client);
//
//     await getProfileInfo(issueId);
//   }
//
//   Future<void> getProfileInfo(String issueId) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       final String? userId = await storage.read(key: 'userId');
//       final res = await db.getDocument(
//         databaseId: AppWriteConstant.primaryDBId,
//         collectionId: AppWriteConstant.profileCollectionId,
//         documentId: userId!,
//       );
//
//       if (res.data.isNotEmpty) {
//         await connectToJira(
//             res.data['jira_url'] ?? '',
//             res.data['jira_user_name'] ?? '',
//             res.data['jira_key'] ?? '',
//             issueId);
//       } else {
//         print('There is no user data');
//       }
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> connectToJira(String jiraUrl, String jiraUserName,
//       String jiraApi, String issueId) async {
//     try {
//       var client = ApiClient.basicAuthentication(Uri.https(jiraUrl, ''),
//           user: jiraUserName, apiToken: jiraApi);
//
//       _jira = JiraPlatformApi(client);
//       notifyListeners();
//
//       await getJiraIssueInfo(issueId);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> getJiraIssueInfo(String issueId) async {
//     try {
//       var result = await _jira.issues.getIssue(issueIdOrKey: issueId);
//       var comment =
//           await _jira.issueComments.getComments(issueIdOrKey: issueId);
//
//       var priorityId = result.fields?['priority']['id'];
//       var priorityInstance =
//           await _jira.issuePriorities.getPriority(priorityId);
//
//       if (result.id != null) {
//         _summary = result.fields?['summary'];
//         notifyListeners();
//         _status = result.fields?['status']['name'];
//         notifyListeners();
//         _priority = priorityInstance.name;
//         notifyListeners();
//         _type = result.fields['issuetype']['name'];
//         notifyListeners();
//         _description = result.fields?['issuetype']['description'];
//         notifyListeners();
//         _created = result.fields?['created'];
//         notifyListeners();
//         _updated = result.fields?['updated'];
//         notifyListeners();
//
//         comment.comments.forEach((element) {
//           _commentList.add(CommentModel(
//               imageUrl: element.author!.avatarUrls!.$16X16!,
//               name: element.author!.displayName!,
//               date: element.created.toString(),
//               comment: element.body['content'][0]['content'][0]['text']));
//           notifyListeners();
//         });
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> addCommentToJira(String issueId, String comment) async {
//     try {
//       _isLoading = true;
//       notifyListeners();
//
//       var response = await _jira.issueComments.addComment(
//           issueIdOrKey: issueId,
//           body: Comment(
//             body: {
//               "version": 1,
//               "type": "doc",
//               "content": [
//                 {
//                   "type": "paragraph",
//                   "content": [
//                     {"type": "text", "text": comment}
//                   ]
//                 }
//               ]
//             },
//           ));
//
//       _commentList.clear();
//       getJiraIssueInfo(issueId);
//       notifyListeners();
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   removeAllComment() {
//     _commentList.clear();
//     notifyListeners();
//   }
// }
