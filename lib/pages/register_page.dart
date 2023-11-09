import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/components/my_button.dart';
import 'package:tutorial_app/components/my_textfield.dart';
import 'package:tutorial_app/components/square_tile.dart';
import 'package:tutorial_app/controllers/user_controller.dart';
import 'package:tutorial_app/services/auth_service.dart';

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
  final ProfileController profileController=Get.find();

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
      //  showDialog(context: context, builder: (context){
      //     return Center(child: CircularProgressIndicator(),);
      //   });
      final result=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
         password: passwordController.text
         );

         if (result.user!=null){
          final user=result.user;
          print('EMAIL SIGN IN USER'+user.toString());
          await profileController.createUserProfile(user!.uid, user.email.toString());
          await profileController.loadUserProfile(user!.uid);
         }

         //Navigator.pop(context);
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
                  SquareTile(imagePath: 'assets/google.png',onTap:(){
                     AuthService().signInWithGoogle();
                  }),
                       SizedBox(width: 10,),
                      SquareTile(imagePath: 'assets/apple.png',onTap: () {
                        
                      },),
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