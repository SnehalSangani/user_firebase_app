import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:user_firebase_app/screen/authntication/signin_screen.dart';
import 'package:user_firebase_app/screen/authntication/signup_screen.dart';
import 'package:user_firebase_app/screen/authntication/splash_screen.dart';
import 'package:user_firebase_app/screen/home/view/buy_screen.dart';
import 'package:user_firebase_app/screen/home/view/cart_screen.dart';
import 'package:user_firebase_app/screen/home/view/detail_screen.dart';
import 'package:user_firebase_app/screen/home/view/home_screen.dart';
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(builder: (context, orientation, deviceType) => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Splash(),),
        GetPage(name: '/signin', page: () => Signin(),),
        GetPage(name: '/signup', page: () => Signup(),),
        GetPage(name: '/home', page: () => home(),),
        GetPage(name: '/detail', page: () => Detail(),),
        GetPage(name: '/cart', page: () => Cart_Screen(),),
        GetPage(name: '/buy', page: () => buy_screen(),),
      ],
    ))
  );
}