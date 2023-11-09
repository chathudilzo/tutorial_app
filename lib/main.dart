import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_app/controllers/tutorial_controller.dart';
import 'package:tutorial_app/controllers/user_controller.dart';
import 'package:tutorial_app/firebase_options.dart';
import 'package:tutorial_app/pages/admin_home_page.dart';
import 'package:tutorial_app/pages/admin_page.dart';
import 'package:tutorial_app/pages/auth_page.dart';
import 'package:tutorial_app/pages/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.put(TutorialController());
    Get.put(ProfileController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AdminHomePage(),
    );
  }
}

