import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:TaskRM/models/jira_connection_model.dart';
import 'package:TaskRM/utils/assets_path.dart';
import 'package:TaskRM/utils/constant/constant.dart';
import '../models/user_data.dart';
import '../utils/app_storage.dart';
import '../utils/config/constants.dart';
import '../utils/custom_snack.dart';

class ProfileProvider extends ChangeNotifier {
  Client client = Client();
  late Databases db;
  late Storage _appWriteStorage;
  File? image;
  late String imageUrl = '';
  late UserData _user = UserData('', '', '', '');

  UserData get user => _user;

  /// this portion is for user profile info ///

  late String _profileImage = '';
  late String _profileName = '';
  late String _profileEncryption = '';
  late String _profileJira = '';
  late String _profileJiraUserName = '';
  late String _profileJiraUrl = '';
  late String _language = 'en';

  String get profileImage => _profileImage;

  String get profileName => _profileName;

  String get profileEncryption => _profileEncryption;

  String get profileJira => _profileJira;

  String get profileJiraUserName => _profileJiraUserName;

  String get profileJiraUrl => _profileJiraUrl;

  String get language => _language;

  ProfileProvider() {
    _init();
  }

  _init() {
    client
        .setEndpoint(AppWriteConstant.endPoint)
        .setProject(AppWriteConstant.projectId);
    db = Databases(client);
    _appWriteStorage = Storage(client);
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;
    final imageTemporary = File(image.path);

    this.image = imageTemporary;
    notifyListeners();

    try {
      if (image != null) {
        final res = await _appWriteStorage
            .createFile(
                bucketId: AppWriteConstant.userImageBucketId,
                fileId: ID.unique(),
                file: InputFile.fromPath(path: image.path))
            .then((value) {
          final String newImageUrl =
              "${AppWriteConstant.endPoint}/storage/buckets/${AppWriteConstant.userImageBucketId}/files/${value.$id}/view?project=${AppWriteConstant.projectId}";
          updateProfile(
              newImageUrl,
              _profileName,
              _profileEncryption,
              _profileJira,
              _profileJiraUserName,
              _profileJiraUrl,
              _language,
              context);
          storage.write(key: 'image_file_id', value: value.$id);
          CustomSnack.successSnack(
              'Image is saved, please hit confirm button to update', context);
        });
      }
    } on PlatformException catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    }
  }

  /// save profile info ///

  late bool isProfileDataSaving = false;

  Future<void> saveProfile(
      String name,
      String encryption,
      String language,
      String jiraApi,
      String jiraUserName,
      String jiraUrl,
      BuildContext context) async {
    final String? uid = await AppStorage.getUserId();
    final String? image = await AppStorage.getImageUrl();

    try {
      isProfileDataSaving = true;
      notifyListeners();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.profileCollectionId,
          documentId: uid!,
          data: {
            'image_url': image,
            'name': name,
            'encryption_key': encryption,
            'language': language,
            'jira_key': jiraApi,
            'jira_user_name': jiraUserName,
            'jira_url': jiraUrl,
            'userId': uid
          });

      if (res.data.isNotEmpty) {
        await storage.write(key: 'seriesEncryptedPassword', value: encryption);
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isProfileDataSaving = false;
      notifyListeners();
    }
  }

  late bool isProfileDataLoading = false;

  Future<void> getProfileInfo(BuildContext context) async {
    try {
      isProfileDataLoading = true;
      notifyListeners();

      final uid = await storage.read(key: 'userId');

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.profileCollectionId,
          queries: [
            Query.equal("userId", uid),
          ]);

      if (res.documents.isNotEmpty) {
        res.documents.forEach((e) {
          _profileImage = e.data['image_url'];
          _profileName = e.data['name'];
          _profileEncryption = e.data['encryption_key'];
          _profileJira = e.data['jira_key'];
          _profileJiraUserName = e.data['jira_user_name'];
          _profileJiraUrl = e.data['jira_url'];
          _language = e.data['language'] ?? '';
          notifyListeners();
        });
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isProfileDataLoading = false;
      notifyListeners();
    }
  }

  late bool isProfileUpdating = false;

  Future<void> updateProfile(
      String imageUrl,
      String name,
      String encryption,
      String jiraApi,
      String jiraUserName,
      String jiraUrl,
      String language,
      BuildContext context) async {
    final String uid = await storage.read(key: 'userId') ?? '';

    try {
      isProfileUpdating = true;
      notifyListeners();

      var res = await db.updateDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.profileCollectionId,
          documentId: uid,
          data: {
            'image_url': imageUrl,
            'name': name,
            'encryption_key': encryption,
            'jira_key': jiraApi,
            'jira_user_name': jiraUserName,
            'jira_url': jiraUrl,
            'language': language,
          }).then((value) {
        Navigator.pop(context);
        getProfileInfo(context);
        CustomSnack.successSnack('Profile is updated successfully', context);
      });
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isProfileUpdating = false;
      notifyListeners();
    }
  }

  /// image deleting ///

  late bool isImageDeleting = false;

  Future<void> deleteImage(BuildContext context) async {
    final String uid = await storage.read(key: 'userId') ?? '';
    final String imageFileId = await storage.read(key: 'image_file_id') ?? '';

    try {
      isImageDeleting = true;
      notifyListeners();

      var res = _appWriteStorage
          .deleteFile(
              bucketId: AppWriteConstant.userImageBucketId, fileId: imageFileId)
          .then((value) {
        updateProfile('', _profileName, _profileEncryption, _profileJira,
            _profileJiraUserName, _profileJiraUrl, _language, context);
        storage.delete(key: 'image_file_id');
        CustomSnack.successSnack('Image is deleted successfully!', context);
      });
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isImageDeleting = true;
      notifyListeners();
    }
  }

  /// get jira connection ///

  late bool isJiraLoading = false;
  late JiraConnectionModel workModel = JiraConnectionModel();
  late JiraConnectionModel personalModel = JiraConnectionModel();
  late JiraConnectionModel selfModel = JiraConnectionModel();

  Future<void> getJiraConnections(BuildContext context) async {
    try {
      isJiraLoading = true;
      notifyListeners();

      final uid = await storage.read(key: 'userId');

      final res = await db.listDocuments(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.jiraConnectionCollectionId,
          queries: [
            Query.equal("userId", uid),
          ]);

      if (res.documents.isNotEmpty) {
        res.documents.forEach((e) {
          if (e.data['taskType'] == '1') {
            workModel = JiraConnectionModel(
                docId: e.$id ?? '',
                userId: e.data['userId'] ?? '',
                taskType: e.data['taskType'] ?? '',
                userName: e.data['userName'] ?? '',
                apiKey: e.data['apiKey'] ?? '',
                url: e.data['url'] ?? '');
            notifyListeners();
          } else if (e.data['taskType'] == '2') {
            personalModel = JiraConnectionModel(
                docId: e.$id ?? '',
                userId: e.data['userId'] ?? '',
                taskType: e.data['taskType'] ?? '',
                userName: e.data['userName'] ?? '',
                apiKey: e.data['apiKey'] ?? '',
                url: e.data['url'] ?? '');
            notifyListeners();
          } else if (e.data['taskType'] == '3') {
            selfModel = JiraConnectionModel(
                docId: e.$id ?? '',
                userId: e.data['userId'] ?? '',
                taskType: e.data['taskType'] ?? '',
                userName: e.data['userName'] ?? '',
                apiKey: e.data['apiKey'] ?? '',
                url: e.data['url'] ?? '');
            notifyListeners();
          }
        });
        //notifyListeners();
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isJiraLoading = false;
      notifyListeners();
    }
  }

  /// add jira connection ///

  late bool isJiraAdding = false;

  Future<void> addJiraConnection(String taskType, String userName,
      String apiKey, String url, BuildContext context) async {
    final String? uid = await AppStorage.getUserId();

    try {
      isJiraAdding = true;
      notifyListeners();

      var res = await db.createDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.jiraConnectionCollectionId,
          documentId: ID.unique(),
          data: {
            'userId': uid,
            'taskType': taskType,
            'userName': userName,
            'apiKey': apiKey,
            'url': url,
          });

      if (res.data.isNotEmpty) {
        Navigator.pop(context);
        getJiraConnections(context);
        CustomSnack.successSnack(
            'Jira connection is added successfully!', context);
      }
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isJiraAdding = false;
      notifyListeners();
    }
  }

  /// jira connection updating ///

  late bool isJiraUpdating = false;

  Future<void> jiraConnectionUpdating(
      String docId,
      String taskType,
      String userName,
      String apiKey,
      String jiraUrl,
      BuildContext context) async {
    final String uid = await storage.read(key: 'userId') ?? '';

    try {
      isJiraUpdating = true;
      notifyListeners();

      var res = await db.updateDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.jiraConnectionCollectionId,
          documentId: docId,
          data: {
            'userId': uid,
            'taskType': taskType,
            'userName': userName,
            'apiKey': apiKey,
            'url': jiraUrl,
          }).then((value) {
        Navigator.pop(context);
        getJiraConnections(context);
        CustomSnack.successSnack(
            'Jira connection is updated successfully', context);
      });
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    } finally {
      isJiraUpdating = false;
      notifyListeners();
    }
  }

  /// delete jira connection ///

  Future<void> deleteJiraConnection(String docId, BuildContext context) async {
    try {
      var res = db
          .deleteDocument(
        databaseId: AppWriteConstant.primaryDBId,
        collectionId: AppWriteConstant.jiraConnectionCollectionId,
        documentId: docId,
      )
          .then((value) {
        Navigator.pop(context);
        getJiraConnections(context);
        CustomSnack.successSnack(
            'Jira connection is deleted successfully', context);
      });
    } catch (e) {
      CustomSnack.warningSnack(e.toString(), context);
    }
  }

  /// change language ///

changeLanguage(String languageCode){
_language = languageCode;
notifyListeners();
}


}
