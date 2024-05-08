import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';
import 'package:task_rm/utils/color.dart';
import 'package:task_rm/utils/spacer.dart';
import 'package:task_rm/utils/typograpgy.dart';
import '../../routes/routes.dart';
import '../../utils/assets_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, _authState, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Home',
                  style: tTextStyle500.copyWith(fontSize: 20),
                ),
                Image.asset(logo),
                IconButton(onPressed: (){
                  _authState.logout(context);
                }, icon: const Icon(Icons.logout, color: secondaryColor,))
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _optionTile(task, taskIcon, 'Tasks', (){
                  Navigator.pushNamed(context, Routes.todayTask);
                }),
                sixteenVerticalSpace,
                _optionTile(goal, goalIcon, 'Goals', (){
                  Navigator.pushNamed(context, Routes.goals);
                }),
                sixteenVerticalSpace,
                _optionTile(moment, momentIcon, 'Moments', (){}),
                sixteenVerticalSpace,
                _optionTile(journal, journalIcon, 'Journal', (){}),
                sixteenVerticalSpace,
                _optionTile(review, reviewIcon, 'Review', (){}),
                sixteenVerticalSpace,
                _optionTile(feed, feedIcon, 'Feed', (){}),
                sixteenVerticalSpace,
                _optionTile(feed, profileIcon , 'Profile', (){
                  Navigator.pushNamed(context, Routes.profile);
                }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _optionTile(String image, String icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image:
            DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: black.withOpacity(0.3)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: white,
                  child: SvgPicture.asset(icon, color: primaryColor, height: 20, width: 20,),
                ),
                sixteenHorizontalSpace,
                Text(
                  title,
                  style: tTextStyle500.copyWith(fontSize: 20, color: white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
