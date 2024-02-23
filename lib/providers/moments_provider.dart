// import 'dart:io';
// import 'package:TaskRM/src/utils/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:TaskRM/src/models/moment_type_data.dart';
// import 'package:TaskRM/src/routes/routes.dart';
// import 'package:TaskRM/src/config/constants.dart';
// import 'package:TaskRM/src/utils/custom_snackbar.dart';
//
// class MomentsProvider extends ChangeNotifier {
//
//   Client client = Client();
//   late Databases db;
//   File? image;
//   late bool _isLoading = false;
//
//   late String _imageLocalPath = '';
//
//   String get imageLocalPath => _imageLocalPath;
//
//   late List<MomentTypeData> _workList = [];
//   List<MomentTypeData> get workList => _workList;
//
//   late List<MomentTypeData> _personalList = [];
//   List<MomentTypeData> get personalList => _personalList;
//
//   MomentsProvider() {
//     _init();
//     getAllMomentsType();
//   }
//
//   _init() {
//     client
//         .setEndpoint(AppWriteConstant.endPoint)
//         .setProject(AppWriteConstant.projectId);
//     db = Databases(client);
//   }
//
//   Future<void> getAllMomentsType() async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//
//       final res = await db.listDocuments(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.momentTypeCollectionId,
//           queries: [
//             Query.equal("userId", uid),
//           ]
//       );
//
//     //&& e.data['userId'] == uid
//     //&& e.data['userId'] == uid
//
//       if (res.documents.isNotEmpty) {
//         res.documents.forEach((e) {
//           if (e.data['type'] == 'work') {
//
//             _workList.add(MomentTypeData(
//                 e.$id ?? '',
//                 e.data['name'] ?? '',
//                 e.data['icon'] ?? '',
//                 e.data['type'] ?? '',
//                 e.data['format'] ?? '',
//                 e.data['userId'] ?? ''
//             ));
//             notifyListeners();
//
//           } else if(e.data['type'] == 'personal'){
//
//             _personalList.add(MomentTypeData(
//                 e.$id ?? '',
//                 e.data['name'] ?? '',
//                 e.data['icon'] ?? '',
//                 e.data['type'] ?? '',
//                 e.data['format'] ?? '',
//                 e.data['userId'] ?? ''
//             ));
//             notifyListeners();
//
//           }
//
//           notifyListeners();
//         });
//       } else {
//         print('There is no user data');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> addMomentType(String name, String icon, String type,
//       String format, BuildContext context) async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//
//       var res = await db.createDocument(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.momentTypeCollectionId,
//           documentId: ID.unique(),
//           data: {
//             'name': name,
//             'icon': icon,
//             'type': type,
//             'format': format,
//             'userId': uid
//           });
//
//       notifyListeners();
//
//       if (res.data.isNotEmpty) {
//         _workList.clear();
//         _personalList.clear();
//         getAllMomentsType();
//         Navigator.pushNamed(context, Routes.moments);
//         CustomSnack.successSnack(
//             'Your moment type is added successfully.', context);
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future<void> addMomentEvent(
//       String moment, double amount, DateTime timeStamp) async {
//     try {
//
//       final uid = await storage.read(key: 'userId');
//
//       var res = await db.createDocument(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.momentEventCollectionId,
//           documentId: ID.unique(),
//           data: {
//             'moment': moment,
//             'amount': amount,
//             'createdAt': '',
//             'userId': uid
//           });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   Future pickImage(ImageSource source, BuildContext context) async {
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
//         if (!_isLoading) {
//           _isLoading = true;
//           _imageLocalPath = imageTemporary.path;
//           notifyListeners();
//           Navigator.pop(context);
//
//           // final res = await _appWriteStorage
//           //     .createFile(
//           //     bucketId: AppWriteConstant.userImageBucketId,
//           //     fileId: ID.unique(),
//           //     file: InputFile.fromPath(path: image.path))
//           //     .then((value) {
//           //   imageUrl =
//           //   "https://rest.is/v1/storage/buckets/${AppWriteConstant.userImageBucketId}/files/${value.$id}/view?project=pleaserm-dev2";
//           //   notifyListeners();
//           // });
//           // await storage.write(key: 'imageUrl', value: imageUrl);
//           //  CustomSnack.successSnack(
//           //      'Image is saved, please hit confirm button to update',
//           //      context);
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
//   Future<void> deleteMomentType(String documentId, BuildContext context) async {
//     try {
//       var res = await db.deleteDocument(
//           databaseId: AppWriteConstant.primaryDBId,
//           collectionId: AppWriteConstant.momentTypeCollectionId,
//           documentId: documentId);
//
//       notifyListeners();
//
//       _workList.clear();
//       _personalList.clear();
//       getAllMomentsType();
//       Navigator.pushNamed(context, Routes.moments);
//       CustomSnack.successSnack(
//           'Your moment type is deleted successfully.', context);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
// }
