import 'package:flutter/material.dart';
import 'package:messenger/component/my_boutton.dart';
import 'package:messenger/component/my_text_field.dart';
import 'package:messenger/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context,listen: false);
    try{
      await authService.signInWithEmailandPassword(
        emailController.text, 
      passwordController.text);
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: SafeArea(
         child: Center(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 50),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    
                      const Icon(
                        Icons.message,
                        size: 80,
                      ),
                      const SizedBox(height: 50,),
                      //email textfield
                      MyTextField(
                        controller:emailController ,
                        hintText: "Email",
                        obscureText: false,
                      ),
                      const SizedBox(height: 20,),
                     //password text field
                     MyTextField(
                       controller: passwordController,
                       hintText: "Mot de passe",
                       obscureText: true),
                       const SizedBox(height: 20,),
                       //boutton
                    MyButton(
                      name: "Sign In",
                       onTap: signIn,
                    ),
                    const SizedBox(height: 35,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Mot de passe Oublié?"),
                        const SizedBox(width: 7,),
                        GestureDetector(
                          onTap:widget.onTap ,
                          child: const Text("S'inscrire",style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ),
                      ],
                    )
              ]
             ),
           ),
         ),
       ),
    );
  }
}