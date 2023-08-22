import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods{
  Future addUser(String userId, Map<String, dynamic> userInfoMap){

    return FirebaseFirestore. instance.collection("User").doc(userId).set(userInfoMap);
  }
}