
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/firebase_helper.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController txtemail=TextEditingController();
  TextEditingController txtpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [ 
          Center(child: Image.network("https://static.vecteezy.com/system/resources/previews/000/251/695/original/grocery-shopping-bag-vector-illustration.jpg")),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade50.withOpacity(0.75)
            ),
          ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: txtemail,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      hintText: 'Enter Email',
                      label: Text("Email")
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: txtpassword,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    label: Text("Password"),
                  ),
                ),
                SizedBox(height: 30,),
                TextButton(onPressed: () {
                  Get.toNamed('/signup');

                },child: Text("Don't have account? Sign Up",style: TextStyle(fontSize: 15),),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () async {
                      String email=txtemail.text;
                      String password=txtpassword.text;
                      String? isLogin=await FirebaseHelper.firehelper.SignIn(email: email, password: password);
                      if(isLogin=="success")
                      {
                        Get.snackbar("firebase", "successful");
                        Get.offAndToNamed('/home');
                      }
                      else{
                        Get.snackbar("$isLogin","");
                      }



                    }, child: Text("Log in"))

                  ],
                )

              ],
            ),
          ),
        ),
      ],
      ),

    ));
  }
}