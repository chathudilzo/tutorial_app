import 'package:flutter/material.dart';
import 'package:tutorial_app/pages/login_page.dart';
import 'package:tutorial_app/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLogin=true;

  void togglePages(){
    setState(() {
      showLogin=!showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return LoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}