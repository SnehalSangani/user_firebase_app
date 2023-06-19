import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/firebase_helper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool islogin = false;

  @override
  void initState() {
    super.initState();
    islogin = FirebaseHelper.firehelper.Checkuser();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),() => Get.offAndToNamed(islogin==false?'/signin':'/home'),);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          body: Center(
            child: Container(
              height: 170,
                width: 170,
                child: Image.network(
              "https://webstockreview.net/images/grocery-clipart-vector-14.png",
              fit: BoxFit.cover,
            )),
          ),
      ),
    );
  }
}
