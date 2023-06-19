import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_firebase_app/screen/home/controller/home_controller.dart';
import 'package:user_firebase_app/screen/home/model/homemodel.dart';
import 'package:user_firebase_app/screen/home/view/home_screen.dart';
import 'package:user_firebase_app/utils/firebase_helper.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Homemodel? homemodel;

  void initState() {
    super.initState();
    homemodel = Get.arguments;
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              Container(
                height: 330,
                width: 450,
                child: Image.network(
                  "${homemodel!.image}",
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed('/home');
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.blue.shade50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18, left: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                "${homemodel!.name}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Spacer(),
                              Icon(Icons.favorite),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "\$ ${homemodel!.price}",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "3.5",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Text(
                            "Product Description",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Text(
                              "ndisfwaidposcdneijoudopwadjndwidhczjddfguiduxbn\niwusdbvwdeyuduyewgfiwaeuhriuehrtghyfywdguwd\ndhgwdbdhfgilahcfnueifheclnwienxgdawu"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Select weight",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 19),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.blue.shade900)),
                                child: Center(child: Text("100 g")),
                              ),
                              Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.blue.shade900)),
                                child: Center(child: Text("500 g")),
                              ),
                              Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.blue.shade900)),
                                child: Center(child: Text("1 Kg")),
                              ),
                              Container(
                                height: 40,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Colors.blue.shade900)),
                                child: Center(child: Text("2 Kg")),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  await FirebaseHelper.firehelper.insert(
                      Name: homemodel!.name,
                      Price: homemodel!.price,
                      Quantity: homemodel!.quan,
                      Desc: homemodel!.desc,
                      Rate: homemodel!.rate,
                      Image: homemodel!.image);
                  Get.toNamed('/home');
                },

                child: Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue.shade900,
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
