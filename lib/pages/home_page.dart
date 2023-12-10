import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/pages/chat_page.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    //instance auth
    final FirebaseAuth _auth = FirebaseAuth.instance;
    void signOut(){
    final authService=Provider.of<AuthService>(context as BuildContext,listen:false);
    authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
        actions: [
          IconButton(onPressed: signOut, icon:const Icon(Icons.logout)),
        ],
      ),
      body: _buildUserList(),
    );
  }
  // maka ny list user
  Widget  _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(), 
      builder:(context,snapshot){
         if(snapshot.hasError){
            return const Text('erreur');
         }
         if(snapshot.connectionState==ConnectionState.waiting){

         }
         return ListView(
          children: 
            snapshot.data!.docs.map<Widget>((doc)=>_buildUserListItem(doc))
            .toList(),
         );
      },
      );
  }


  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String ,dynamic>data = document.data()!as Map<String,dynamic>;

    if(_auth.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          //chatpage
          Navigator.push(
            context as BuildContext ,
             MaterialPageRoute(
              builder: (context)=>ChatPage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
            );
        },
      );
    }else{
      return Container();
    }


  }
}