import 'package:flutter/material.dart';
import '../../../utils/color.dart';

class SocialLoginButton extends StatelessWidget {
  final String buttonIconPath;
  final bool isLoading;
  final VoidCallback onTap;

  const SocialLoginButton(
      {Key? key,
      required this.buttonIconPath,
      this.isLoading = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: white,
            border: Border.all(color: borderColor)),
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        //   child: isLoading
        //       ? const Center(child: CircularProgressIndicator())
        //       : SvgPicture.asset(buttonIconPath),
        // ),
      ),
    );
  }
}
