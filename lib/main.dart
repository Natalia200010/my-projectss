import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/routes.dart';
//import 'package:flutter_app/views/screens/homescreen.dart';
import 'package:flutter_app/views/screens/loginpage.dart';
import 'package:get/get_navigation/get_navigation.dart';


void main() {
  runApp(GetMaterialApp (
  debugShowCheckedModeBanner:false,
  home: MyApp(),
    getPages: routes,
    initialRoute: "/",
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: Login(),
    );
  }
}
