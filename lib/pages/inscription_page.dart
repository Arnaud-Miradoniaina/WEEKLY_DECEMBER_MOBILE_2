import 'package:flutter/material.dart';
import 'package:messenger/component/my_boutton.dart';
import 'package:messenger/component/my_text_field.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class InscriptionPage extends StatefulWidget {
  final void Function()? onTap;
  const InscriptionPage({required this.onTap});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final emailController=TextEditingController();
  final passwordController = TextEditingController();
  final confirmeCotroller =TextEditingController();
  void signUp() async{
    if(passwordController.text!=confirmeCotroller.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mot de passe different")));
      return;
    }
    final authService=Provider.of<AuthService>(context,listen: false);
    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString())
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: 
          Center(
            child: 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.message,
                        size: 80,
                      ),
                     const SizedBox(height: 40,),
                     //mail
                      MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false
                      ),
                       const SizedBox(height: 20,),
                       ///mot de passe
                      MyTextField(
                        controller: passwordController,
                        hintText: "Mot de passe",
                        obscureText: true),
                       const SizedBox(height: 20,),
                      MyTextField(controller: confirmeCotroller,
                       hintText: "Confirmation mot de passe", 
                       obscureText: true
                      ),
                      const SizedBox(height: 20,),
                      //Sig up
                      MyButton(name: "Sign Up", onTap: signUp),
                       const SizedBox(height: 20,),
                      Center(child: 
                         GestureDetector(
                          onTap: widget.onTap,
                           child: Text("Se connecter",
                           style: TextStyle(
                            fontWeight: FontWeight.bold
                           ),),
                         )
                      ,),
                  
                    ],
                  ),
                )
            ,
          ),
      ),
    );
  }
}