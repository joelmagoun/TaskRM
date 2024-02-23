import 'dart:io';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/profile_provider.dart';
import '../routes/routes.dart';
import '../utils/app_storage.dart';
import '../utils/config/constants.dart';
import '../utils/custom_snack.dart';

class AuthProvider extends ChangeNotifier {
  Client client = Client();
  late Databases db;
  late Account account;
  late Storage _appWriteStorage;
  File? image;
  late String imageUrl = '';
  late bool isImageUploading = false;

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
    db = Databases(client);
    _appWriteStorage = Storage(client);
  }

  /// uplaod image ///

  Future pickImage(ImageSource source, BuildContext context) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;
    final imageTemporary = File(image.path);

    this.image = imageTemporary;
    notifyListeners();

    Navigator.pop(context);
    print('selected image path is ${image.path}');
    // print('image url 1 $imageUrl');
    //
    // try {
    //   if (image != null) {
    //     if (!isImageUploading) {
    //
    //       print('image url 2 $imageUrl');
    //
    //       isImageUploading = true;
    //       notifyListeners();
    //
    //       final res = await _appWriteStorage
    //           .createFile(
    //           bucketId: AppWriteConstant.userImageBucketId,
    //           fileId: ID.unique(),
    //           file: InputFile.fromPath(path: image.path))
    //           .then((value) {
    //         imageUrl =
    //         "https://rest.is/v1/storage/buckets/${AppWriteConstant.userImageBucketId}/files/${value.$id}/view?project=${AppWriteConstant.projectId}";
    //         notifyListeners();
    //         print('image url $imageUrl');
    //       });
    //       await storage.write(key: 'imageUrl', value: imageUrl);
    //       CustomSnack.successSnack(
    //           'Image is Uploaded successfully!', context);
    //     }
    //   }
    // } on PlatformException catch (e) {
    //   print('image url ${e.toString()}');
    //   CustomSnack.warningSnack('$e', context);
    // } finally {
    //   isImageUploading = false;
    //   notifyListeners();
    // }
  }

  Future uploadImage(BuildContext context) async {
    final String hardImagePath =
        '/Users/macbookpro/Library/Developer/CoreSimulator/Devices/79A5C545-A2DE-421A-9212-BD5D060F8DDC/data/Containers/Data/Application/EE8CFFB9-8EC3-43E9-9337-AB3C9F9273DE/tmp/image_picker_4AAC3C8B-940A-4DB5-9A32-5FCE29512584-77706-0000008FD6E13DD0.jpg';

    print('image url 1 $imageUrl');

    try {
      if (image != null) {
        if (!isImageUploading) {
          print('image url 2 $imageUrl');

          isImageUploading = true;
          notifyListeners();

          final res = await _appWriteStorage
              .createFile(
                  bucketId: AppWriteConstant.userImageBucketId,
                  fileId: ID.unique(),
                  //file: InputFile.fromPath(path: image!.path))
                  file: InputFile.fromPath(path: hardImagePath))
              .then((value) {
            imageUrl =
                "https://rest.is/v1/storage/buckets/${AppWriteConstant.userImageBucketId}/files/${value.$id}/view?project=${AppWriteConstant.projectId}";
            notifyListeners();
            print('image url $imageUrl');
          });
          await storage.write(key: 'imageUrl', value: imageUrl);
          CustomSnack.successSnack('Image is Uploaded successfully!', context);
        }
      }
    } on PlatformException catch (e) {
      print('image url ${e.toString()}');
      CustomSnack.warningSnack('$e', context);
    } finally {
      isImageUploading = false;
      notifyListeners();
    }
  }

  /// login ///

  late bool isLogin = false;

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      isLogin = true;
      notifyListeners();

      var result =
          await account.createEmailSession(email: email, password: password);

      await storage.write(key: 'sessionId', value: result.$id);
      await storage.write(key: 'userId', value: result.userId);

      if (result.userId.isNotEmpty) {
        final _profileState =
            Provider.of<ProfileProvider>(context, listen: false);
        _profileState.saveProfile(
            _name, _encryption, _language, _jira, _jiraUserName, _jiraUrl);
      }

      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      print('error is $e');
    } finally {
      isLogin = false;
      notifyListeners();
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
    } finally {
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
