import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
  late bool _isLoading = false;

  late UserData _user = UserData('', '', '', '');

  UserData get user => _user;

  /// this portion is for user profile info ///

  late String _profileImage = '';
  late String _profileName = '';
  late String _profileEncryption = '';
  late String _profileJira = '';
  late String _profileJiraUserName = '';
  late String _profileJiraUrl = '';

  String get profileImage => _profileImage;

  String get profileName => _profileName;

  String get profileEncryption => _profileEncryption;

  String get profileJira => _profileJira;

  String get profileJiraUserName => _profileJiraUserName;

  String get profileJiraUrl => _profileJiraUrl;

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
        if (!_isLoading) {
          _isLoading = true;
          notifyListeners();

          final res = await _appWriteStorage
              .createFile(
                  bucketId: AppWriteConstant.userImageBucketId,
                  fileId: ID.unique(),
                  file: InputFile.fromPath(path: image.path))
              .then((value) {
            imageUrl =
                "${AppWriteConstant.endPoint}/storage/buckets/${AppWriteConstant.userImageBucketId}/files/${value.$id}/view?project=${AppWriteConstant.projectId}";
            notifyListeners();
            print(imageUrl);
            storage.write(key: 'imageUrl', value: imageUrl);
            Navigator.pop(context);
            CustomSnack.successSnack(
                'Image is saved, please hit confirm button to update', context);
          });

        }
      }
    } on PlatformException catch (e) {
      print(e.toString());
      CustomSnack.warningSnack('$e', context);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// save profile info ///

  late bool isProfileDataSaving = false;

  Future<void> saveProfile(String name, String encryption, String language,
      String jiraApi, String jiraUserName, String jiraUrl) async {
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
      print(e.toString());
    }finally{
      isProfileDataSaving = false;
      notifyListeners();
    }
  }

  Future<void> getProfileInfo() async {
    try {
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
          notifyListeners();
        });
      } else {
        print('There is no user data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProfile(String name, String encryption, String jiraApi,
      String jiraUserName, String jiraUrl) async {
    final String uid = await storage.read(key: 'userId') ?? '';
    final String image = await storage.read(key: 'imageUrl') ?? '';

    try {
      var res = await db.updateDocument(
          databaseId: AppWriteConstant.primaryDBId,
          collectionId: AppWriteConstant.profileCollectionId,
          documentId: uid,
          data: {
            'image_url': image,
            'name': name,
            'encryption_key': encryption,
            'jira_key': jiraApi,
            'jira_user_name': jiraUserName,
            'jira_url': jiraUrl
          });
    } catch (e) {
      print(e.toString());
    }
  }
}
