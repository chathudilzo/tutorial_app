import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton({super.key,required this.onTap,required this.text});

  final Function()? onTap;
final String text;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding:const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width*0.8,
       
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)),
        child: 
        Center(child: Text(widget.text,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}