import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_knee_23/models/doctor_list_provider.dart';
import 'package:save_knee_23/screens/starting_screen_1.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  Future<Widget> futureCall(context) async {
    Provider.of<DrListProvider>(context).loadDrList();
    await Future.delayed(Duration(seconds: 5));
    return Future.value(StartingScreen1());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png'),
      title: Text(
        "Save Knee",
        style: TextStyle(
          fontFamily: 'Benson',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading doctors list ..."),
      futureNavigator: futureCall(context),
    );
  }
}
