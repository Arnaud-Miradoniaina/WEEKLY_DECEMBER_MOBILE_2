import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()?  onTap;
  final String name;
  const MyButton({required this.name,required this.onTap});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
         onTap: onTap,
         child: Container(
          padding: EdgeInsets.all(25),
           decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
         ),
          child:Center(
              child: Text(
                name,
                style: TextStyle(color: Colors.white),
                ),
          ) 
          ),
        );
  }
}