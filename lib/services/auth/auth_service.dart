import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  //instance authantification
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  

  //instance firestore
  final FirebaseFirestore _fireStore=FirebaseFirestore.instance;

  //sign user 
  Future<UserCredential> signInWithEmailandPassword(String email, String password) async{
    try{
      UserCredential userCredential= 
      await _firebaseAuth.signInWithEmailAndPassword(
        email:email,
        password:password,
      );

      //ajout nouveau documentation
      _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
           'uid':userCredential.user!.uid,
           'email':email,
        },SetOptions(merge: true));
      return userCredential;
    } on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }
  //create new user
  Future<UserCredential>signUpWithEmailandPassword(
    String email,password,
  ) async{
    try{
      UserCredential userCredential=
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      //apres cresation user creation document
      _fireStore.collection('users').doc(userCredential.user!.uid).set(
        {
           'uid':userCredential.user!.uid,
           'email':email,
        }
      );
      return userCredential;
    }on FirebaseException catch (e){
      throw Exception(e.code);
    }
  }
  //deconnexion
  Future <void> signOut()async{
    return await FirebaseAuth.instance.signOut();
  }
}