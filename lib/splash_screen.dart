import 'package:flutter/material.dart';
import 'package:seproject/hive/hive.dart';
import 'other/routes.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final myBox = HiveManager.myBox;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (myBox.get('agreement') == null) {
        Navigator.pushReplacementNamed(context, Routes.agreement);
      } else {
        Navigator.pushReplacementNamed(context, Routes.signUp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffACDCFF),
        body: Center(
            child: Image.asset(
          "assets/images/bookmyevent.jpeg",
          height: MediaQuery.of(context).size.height * 0.4,
        )));
  }
}
