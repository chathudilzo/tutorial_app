import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/user_controller.dart';
import 'package:tutorial_app/pages/home_page.dart';
import 'package:tutorial_app/pages/login_or_register.dart';
import 'package:tutorial_app/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController=Get.find();

    return Scaffold(
      body:StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context,snapshot){
        if(snapshot.hasData){
          return Obx((){
            if(profileController.isLoading.value){
            return Container();
          }else{
            return  HomePage();
          }
          });
          
        }else{
          return LoginOrRegisterPage();
        }
       }),
    );
  }
}