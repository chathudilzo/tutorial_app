import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key,required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width*0.8,
       
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)),
        child: 
        Center(child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}