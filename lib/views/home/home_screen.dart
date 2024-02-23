import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_rm/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, _authState, child){
      return  Scaffold(
        appBar: AppBar(actions: [IconButton(onPressed: (){
          _authState.logout(context);
        }, icon: Icon(Icons.logout))],),
        body: Center(child: Text('home screen')),);
    });
  }
}
