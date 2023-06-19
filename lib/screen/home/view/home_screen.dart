import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_firebase_app/screen/home/controller/home_controller.dart';
import 'package:user_firebase_app/screen/home/model/homemodel.dart';

import '../../../utils/firebase_helper.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

Homecontroller homecontroller = Get.put(Homecontroller());

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    List<Homemodel> datalist = [];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Grocery"),
        actions: [
          IconButton(onPressed: () {
            Get.toNamed('/cart');

          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 210,
              width: double.infinity,
              color: Colors.blue.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://tse4.mm.bing.net/th?id=OIP.0in7KfWlBPuzPuvEWXgO4QHaH_&pid=Api&P=0&h=180"),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Snehal Sangani",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "snehal@gmail.com",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Cart"),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Order"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
            ),
            ListTile(
              leading: IconButton(
                onPressed: () async {
                  bool? msg = await FirebaseHelper.firehelper.logout();
                  if (msg = true) {
                    Get.offNamed("signin");
                    Get.snackbar("Login", "$msg");
                  }
                },
                icon: Icon(Icons.logout),
              ),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? snapdata = snapshot.data;
            datalist.clear();
            for (var x in snapdata!.docs) {
              Map data = x.data() as Map;
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
              );
              datalist.add(h1);
            }
            // return Text("${datalist.length}");
            return ListView.builder(
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/detail',arguments: datalist[index]);

                  },
                  child: Container(
                    height: 100,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue.shade900,width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(height: 80,
                          width: 80,
                          child: Image.network("${datalist[index].image}",fit: BoxFit.cover,)),
                          SizedBox(width: 15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${datalist[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                              SizedBox(height: 10,),
                              Text("${datalist[index].desc}",style: TextStyle(fontSize: 15,color: Colors.red),),
                              SizedBox(height: 10,),
                              Text("\$ ${datalist[index].price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            ],
                          ),
                          Spacer(),
                          Container(
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.shade900
                            ),
                            child: Icon(Icons.add,size: 15,color: Colors.white,)
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              );

            },itemCount: datalist.length,);
          }
          return CircularProgressIndicator();
        },
        stream: FirebaseHelper.firehelper.read(),
      ),
      backgroundColor: Colors.blue.shade50,

    ));
  }
}
