import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/views/auth/login/login_screen.dart';
import 'package:task_rm/views/home/home_screen.dart';
import '../utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  final String sessionId;

  const SplashScreen({Key? key, required this.sessionId}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getIsFirst();
  }

  _getIsFirst() async {
    // bool isIntro = await PrefData.getIsIntro();
    // bool docCompleted = PrefData.getDocumentCompleted();
    // const bool isAccessToken = false;

    Timer(const Duration(seconds: 2), () {
      if (widget.sessionId != '') {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 400), () {
      lightStatusBar();
    });
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: Image.asset(
          taskRMLogo,
        ),
      ),
    );
  }

  void lightStatusBar() async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        // statusBarBrightness: Brightness.dark,
        // statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
