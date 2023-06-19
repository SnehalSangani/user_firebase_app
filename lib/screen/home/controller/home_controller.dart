
import 'package:get/get.dart';
import 'package:user_firebase_app/screen/home/model/homemodel.dart';
import 'package:user_firebase_app/screen/home/view/home_screen.dart';

class Homecontroller extends GetxController
{
  RxInt index=0.obs;

  RxList<String> datalist=<String>[].obs;

  List<Homemodel> cartlist=<Homemodel>[].obs;
  List<Homemodel> buylist=<Homemodel>[].obs;



  void addcart(Homemodel h1)
  {
    cartlist.add(h1);
  }
   RxMap data={}.obs;

  RxInt qu=0.obs;
  RxInt qua=0.obs;


}