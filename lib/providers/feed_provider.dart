// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:TaskRM/src/utils/custom_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:TaskRM/src/models/feed.dart';
// import 'package:TaskRM/src/config/constants.dart';
//
// import '../utils/custom_dialog.dart';
//
// class FeedProvider extends ChangeNotifier {
//
//   Client client = Client();
//   late Databases db;
//
//   late bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   late List<Feed> _allFeedList = [];
//   List<Feed> get allFeedList => _allFeedList;
//
//
//   late List<Feed> _publicFeedList = [];
//   List<Feed> get publicFeedList => _publicFeedList;
//
//   late bool _isFeedOnlyPublic = true;
//   bool get isFeedOnlyPublic => _isFeedOnlyPublic;
//
//
//   // late List<int> _correctPasswordSeries = [0, 1, 2, 4, 7];
//   // List<int> get correctPasswordSeries => _correctPasswordSeries;
//
//   late String _result = '';
//   String get result => _result;
//
//
//   FeedProvider() {
//     _init();
//   }
//
//   _init() {
//     client
//         .setEndpoint(AppWriteConstant.endPoint)
//         .setProject(AppWriteConstant.projectId);
//     db = Databases(client);
//     getFeedList();
//   }
//
//   Future<void> addDataToFeed(
//       String source, String description, DateTime timeStamp, bool isEncrypted, String imageUrl) async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//
//       var res = await db.createDocument(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.feedCollectionId,
//           documentId: ID.unique(),
//           data: {
//             'source': source,
//             'description': description,
//             'timestamp': '',
//             'userId': uid,
//             'encrypted': isEncrypted,
//             'imageUrl': imageUrl
//           });
//       notifyListeners();
//
//       if (res.data.isNotEmpty) {
//         _allFeedList.clear();
//         notifyListeners();
//         getFeedList();
//         // Navigator.pushNamed(context, Routes.moments);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> getFeedList() async {
//
//     try {
//       final uid = await storage.read(key: 'userId');
//
//       final res = await db.listDocuments(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.feedCollectionId,
//           queries: [Query.equal("userId", uid)]);
//
//       if (res.documents.isNotEmpty) {
//         res.documents.forEach((e) {
//
//           _allFeedList.add(Feed(
//               e.data['source'] ?? '',
//               e.data['description'] ?? '',
//               e.data['timestamp'].toString() ?? '',
//               e.data['encrypted'],
//               e.data['imageUrl'] ?? ''
//           ));
//           notifyListeners();
//
//           if(e.data['encrypted'] == false){
//             _publicFeedList.add(Feed(
//                 e.data['source'] ?? '',
//                 e.data['description'] ?? '',
//                 e.data['timestamp'].toString() ?? '',
//                 e.data['encrypted'],
//                 e.data['imageUrl'] ?? ''
//             ));
//             notifyListeners();
//             }
//
//         });
//       } else {
//         print('There is no user data');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> showAllFeed(var data, BuildContext context) async {
//
//      try{
//
//        final hiddenPassword = await storage.read(key: 'seriesEncryptedPassword');
//
//        _result = data.join('');
//        notifyListeners();
//
//        if (result == hiddenPassword) {
//
//          _isFeedOnlyPublic = false;
//          notifyListeners();
//
//          Navigator.pop(context);
//
//          CustomDialog.autoDialog(context,
//              'Password is matching, now you are able to see private feed as well.');
//
//          _isLoading = true;
//          notifyListeners();
//
//        }
//
//      }catch(e){
//        CustomSnack.warningSnack(e.toString(), context);
//      }finally{
//        _isLoading = false;
//        notifyListeners();
//      }
//
//   }
//
//   Future<void> hidePrivateFeed( BuildContext context) async {
//
//     _isFeedOnlyPublic = true;
//     notifyListeners();
//     CustomSnack.successSnack('All private feed is unavailable', context);
//
//   }
//
//   Future<void> clearFeedList () async {
//     _allFeedList.clear();
//     _publicFeedList.clear();
//     notifyListeners();
//   }
//
// }
