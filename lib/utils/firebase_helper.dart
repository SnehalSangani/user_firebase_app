import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_firebase_app/screen/home/model/homemodel.dart';

class FirebaseHelper
{
  static FirebaseHelper firehelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  SignUp({required email, required password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("success"))
        .catchError((e) => print("$e"));
  }

  SignIn({required email, required password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return "success";
    }).catchError((e) {
      return "$e";
    });
  }
  bool Checkuser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }
  Future<bool?> logout()
  async {
    bool? check;
    FirebaseAuth.instance.signOut().then((value) => check=true).catchError((e)=>check=false);
    return check;
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> read()
  {
    return firestore.collection("product").snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> readuser()
  {
    return firestore.collection("userdata").snapshots();
  }
   String getuid()
   {
     User? user=firebaseAuth.currentUser;
     var uid=user!.uid;
     return uid;
   }

  Future<void> insert(
      {
        required Name,
        required Price,
        required Quantity,
        required Desc,
        required Rate,
        required Image,}

      )
  async {
    String uid=getuid();
    await firestore.collection('userdata').doc("$uid").collection('cart').add({
      "Name": Name,
      "Price": Price,
      "Quantity": Quantity,
      "Desc": Desc,
      "Rate": Rate,
      "Image":Image,

    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> readdata()
  {
    String uid=getuid();
    return firestore.collection("userdata").doc("$uid").collection('cart').snapshots();
  }
  Future<void> insertbuy(
      {
        required Name,
        required Price,
        required Quantity,
        required Desc,
        required Rate,
        required Image,}

      )
  async {
    String uid=getuid();
    await firestore.collection('userdata').doc("$uid").collection('buy').add({
      "Name": Name,
      "Price": Price,
      "Quantity": Quantity,
      "Desc": Desc,
      "Rate": Rate,
      "Image":Image,

    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> readdatabuy()
  {
    String uid=getuid();
    return firestore.collection("userdata").doc("$uid").collection('buy').snapshots();
  }
  Future<void> delete(String docid)
  async {
    String uid=getuid();
    await firestore.collection('userdata').doc("$uid").collection('cart').doc(docid).delete();
  }

  void total()
  {

  }

}