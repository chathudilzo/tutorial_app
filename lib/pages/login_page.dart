import 'package:flutter/material.dart';
import 'package:tutorial_app/components/my_button.dart';
import 'package:tutorial_app/components/my_textfield.dart';
import 'package:tutorial_app/components/square_tile.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});


  //Text Editing controllers
final userNameController=TextEditingController();
final passwordController=TextEditingController();


void signUserIn(){

}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                const Icon(Icons.lock,size: 100,),
                const SizedBox(height: 50,),
                const Text('Welcome Back You\'ve been missed!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 43, 42, 42)),)
                ,
                const SizedBox(height: 50,),
                MyTextField(
                  controller: userNameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 20,),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
               const  Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?',style: TextStyle(color: const Color.fromARGB(255, 97, 97, 97)),)
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                MyButton(
                  onTap: signUserIn,
                ),SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400]
                    )),
                    Text(' Or Continue With ',style: TextStyle(color: Colors.grey[700]),),
                    Expanded(child: Divider(
                      thickness: 0.5,
                     color: Colors.grey[400],
                    )),
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
                ),SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',style: TextStyle(color: Colors.grey[700]),),
                    SizedBox(width: 4,),
                    Text('Register now!',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}