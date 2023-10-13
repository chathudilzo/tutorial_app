import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_app/components/my_button.dart';
import 'package:tutorial_app/components/my_textfield.dart';
import 'package:tutorial_app/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key,required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();

void errorPop(String text){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title:Text(text),
    );
  });
}

void signUserUp()async{
 

  try{
    if(emailController.text==''){
      errorPop('Invalid Email');
    }else if(passwordController.text!=confirmPasswordController.text){
      errorPop('Password Miss Match');
    }else{
       showDialog(context: context, builder: (context){
          return Center(child: CircularProgressIndicator(),);
        });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
         password: passwordController.text
         );

         Navigator.pop(context);
    }
      
    
  }on FirebaseAuthException catch(e){
    errorPop(e.code);
  } 
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: Icon(Icons.key,size: 100,),
              ),
              SizedBox(height: 30,),
              Text('Let\'s create an account',style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16
              ),),
              SizedBox(height: 50,),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              
              ),
              SizedBox(height: 20,),
              MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
              SizedBox(height: 20,),
              MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true)
              ,SizedBox(height: 10,),
              MyButton(onTap: signUserUp,text:'Sign Up'),
              SizedBox(height:50),
              Row(
                children: [
                  Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  )),Text(' Or Register With ',style: TextStyle(
                    color: Colors.grey[700]
                  ),),
                  Expanded(child: Divider(
                    thickness: 0.5,
                    color: Colors.grey[400],
                  ))
                ],
              ),
              SizedBox(height: 25,),
              Row(
        mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'assets/google.png'),
                       SizedBox(width: 10,),
                      SquareTile(imagePath: 'assets/apple.png'),
                ],
              ),
              SizedBox(height:25 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already Have an account?'),
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Log In',style: TextStyle(color: Colors.amberAccent,fontWeight: FontWeight.bold),),
                  )
                ],
              )
        
            ],
          ),
        ),
      ),
    );
  }
}