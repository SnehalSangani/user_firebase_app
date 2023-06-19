import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_firebase_app/screen/home/view/home_screen.dart';
import 'package:user_firebase_app/utils/firebase_helper.dart';

import '../model/homemodel.dart';

class buy_screen extends StatefulWidget {
  const buy_screen({Key? key}) : super(key: key);

  @override
  State<buy_screen> createState() => _buy_screenState();
}

class _buy_screenState extends State<buy_screen> {
  @override
  Homemodel? homemodel;
  void initState() {
    super.initState();
    homemodel = Get.arguments;


  }
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Buy"),
      ),
      backgroundColor: Colors.blue.shade50,
      body: StreamBuilder(stream: FirebaseHelper.firehelper.readdata(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
          else if(snapshot.hasData)
          {
            List<Homemodel> cartlist=[];
            QuerySnapshot? snapdata=snapshot.data;
            for(var x in snapdata!.docs)
            {
              Map data =x.data() as Map;
              String name = "${data['Name']}";
              String price = "${data['Price']}";
              String desc = "${data['Desc']}";
              String rate = "${data['Rate']}";
              String quan = "${data['Quan']}";
              String image = "${data['Image']}";
              Homemodel h1 = Homemodel(
                  name: name,
                  price: price,
                  desc: desc,
                  rate: rate,
                  quan: quan,
                  image: image,
                  qu: 1
              );
              cartlist.add(h1);

            }
            return Stack(
              children: [
                Expanded(
                  child: ListView.builder(itemCount: cartlist.length,itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1,color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 70,
                                  width: 70,
                                  child: Image.network("${cartlist[index].image}",fit: BoxFit.cover,)),
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15,),
                                Text("${cartlist[index].name}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                SizedBox(height: 17,),
                                Text("\$ ${cartlist[index].price}",style: TextStyle(fontSize: 17,color: Colors.red),)
                              ],
                            ),
                            Spacer(),

                          ],
                        ),
                      ),
                    );
                  },),
                ),

              ],
            );

          }
          return CircularProgressIndicator();
        },),

    ));
  }
}
