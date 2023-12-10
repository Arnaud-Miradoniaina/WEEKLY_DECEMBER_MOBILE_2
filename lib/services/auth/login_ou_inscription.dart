import 'package:flutter/material.dart';
import 'package:messenger/pages/inscription_page.dart';
import 'package:messenger/pages/login_page.dart';

class LoginOuInscription extends StatefulWidget {
  const LoginOuInscription({super.key});

  @override
  State<LoginOuInscription> createState() => _LoginOuInscriptionState();
}

class _LoginOuInscriptionState extends State<LoginOuInscription> {
  bool showLoginPage= true;
  void toogglepage(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: toogglepage,);
    }
    else{
      return InscriptionPage(onTap: toogglepage,);
    }
  }
}