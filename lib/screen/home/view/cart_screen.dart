import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_firebase_app/screen/home/view/home_screen.dart';
import 'package:user_firebase_app/utils/firebase_helper.dart';

import '../model/homemodel.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  @override
  Homemodel? homemodel;
  void initState() {
    super.initState();
    homemodel = Get.arguments;


  }
  Widget build(BuildContext context) {
    List<Homemodel> datalist = [];
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title:Text("Cart screen"),
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
                    String docid=x.id;
                    Homemodel h1 = Homemodel(
                      name: name,
                      price: price,
                      desc: desc,
                      rate: rate,
                      quan: quan,
                      image: image,
                      docid: docid,

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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [

                                      Row(
                                        children: [
                                          InkWell(
                                    onTap: () {

                                            cartlist[index].qu=cartlist[index].qu!+1;

                                    },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.blue.shade900,
                                              ),
                                              child: Icon(Icons.add,color: Colors.white,size: 20,),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text("${cartlist[index].qu}"),
                                          SizedBox(width: 5,),
                                          InkWell(
                                            onTap: () {
                                              if(homecontroller.qu.value>1)
                                              {
                                                homecontroller.qu.value-=1;
                                              }

                                            },

                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.blue.shade900,
                                              ),
                                              child: Icon(Icons.minimize,color: Colors.white,size: 20,),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 17,),
                                      InkWell(
                                        onTap: () async {
                                          await FirebaseHelper.firehelper.delete("${cartlist[index].docid}");
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1,color: Colors.red),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.red.shade50,
                                          ),
                                          child: Center(child: Text("Delete",style: TextStyle(fontSize: 13),)),

                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/buy');

                          },
                          child: Container(
                            height: 45,
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue.shade900,width: 3),
                              color: Colors.blue.shade100
                            ),
                            child: Center(child: Text("Buy Now",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ),
                    ),

                  ],
                );

              }
            return CircularProgressIndicator();
          },),


    ));
  }
}
