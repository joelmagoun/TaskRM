// import 'dart:io';
// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:TaskRM/src/utils/encryption.dart';
// import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:TaskRM/src/routes/routes.dart';
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../utils/custom_snackbar.dart';
// import 'feed_provider.dart';
//
// class JournalProvider extends ChangeNotifier {
//   Client client = Client();
//   late Databases db;
//   late Storage _appWriteStorage;
//
//
//   File? image;
//   late String _imageUrl = '';
//   late bool _isLoading = false;
//
//   String get imageUrl => _imageUrl;
//   bool get isLoading => _isLoading;
//
//   JournalProvider() {
//     _init();
//   }
//
//   _init() {
//     client
//         .setEndpoint(AppWriteConstant.endPoint)
//         .setProject(AppWriteConstant.projectId);
//     db = Databases(client);
//     _appWriteStorage = Storage(client);
//   }
//
//   Future pickImage(ImageSource source, BuildContext context) async {
//
//     final image = await ImagePicker().pickImage(source: source);
//
//     if (image == null) return;
//     final imageTemporary = File(image.path);
//
//     this.image = imageTemporary;
//     notifyListeners();
//
//     try {
//       if (image != null) {
//
//         if (!_isLoading) {
//
//           _isLoading = true;
//           notifyListeners();
//
//           final res = await _appWriteStorage
//               .createFile(
//               bucketId: AppWriteConstant.journalImageBucketId,
//               fileId: ID.unique(),
//               file: InputFile.fromPath(path: image.path))
//               .then((value) {
//             _imageUrl =
//             "https://rest.is/v1/storage/buckets/${AppWriteConstant.journalImageBucketId}/files/${value.$id}/view?project=${AppWriteConstant.projectId}";
//             notifyListeners();
//           });
//           Navigator.pop(context);
//            CustomSnack.successSnack(
//               'Image is uploaded successfully', context);
//         }
//       }
//     } on PlatformException catch (e) {
//       print(e.toString());
//       CustomSnack.warningSnack('$e', context);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<bool> addJournal(String journalText, int selectedIndex,
//       bool isEncrypted, BuildContext context) async {
//     try {
//
//       _isLoading = true;
//       notifyListeners();
//
//       final uid = await storage.read(key: 'userId');
//       final _feedState = Provider.of<FeedProvider>(context, listen: false);
//       final DateTime currentDateTime = DateTime.now();
//
//       final String journalFilteredText;
//      // final String journalType;
//
//        if(isEncrypted == true){
//            journalFilteredText = executeEncrypt(journalText);
//        }else{
//          journalFilteredText = journalText;
//        }
//
//        // if(selectedIndex == 0){
//        //   journalType = 'Public';
//        // }else if( selectedIndex == 1){
//        //   journalType = 'Private';
//        // }else if(selectedIndex == 2){
//        //   journalType = 'Hidden';
//        // }
//
//       var res = await db.createDocument(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.journalCollectionId,
//           documentId: ID.unique(),
//           data: {
//             'journal_text': journalFilteredText,
//             'userId': uid,
//             'encrypted': isEncrypted,
//             'imageUrl': _imageUrl,
//             'journalType': selectedIndex
//           });
//
//       if (res.$id.isNotEmpty) {
//         if (selectedIndex == 0 || selectedIndex == 1) {
//           await _feedState.addDataToFeed(
//               'Journal',
//               isEncrypted == true ? executeEncrypt(journalText) : journalText,
//               currentDateTime, isEncrypted, _imageUrl);
//           notifyListeners();
//           await _feedState.clearFeedList();
//           notifyListeners();
//
//           Navigator.pushNamed(context, Routes.feed);
//         }else{
//           Navigator.pushNamed(context, Routes.home);
//         }
//       }
//
//       return true;
//
//     } catch (e) {
//       return false;
//       print(e.toString());
//     }finally{
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> clearJournalLastImage() async {
//     _imageUrl = '';
//     notifyListeners();
//   }
//
// }
