import 'package:flutter_app/views/screens/dashboard.dart';
import 'package:flutter_app/views/screens/homescreen.dart';
import 'package:flutter_app/views/screens/loginpage.dart';
import 'package:flutter_app/views/screens/orders.dart';
import 'package:flutter_app/views/screens/products.dart';
import 'package:flutter_app/views/screens/profile.dart';
import 'package:flutter_app/views/screens/signup.dart';
import 'package:get/get.dart';

List <GetPage> routes=[
  GetPage(name: "/", page: ()=>Login() ),
  GetPage(name: "/signup", page: ()=>SignUpPage()),
  GetPage(name: "/homescreen", page: ()=>Homescreen()),
  GetPage(name: "/", page: ()=>Dashboard()),
  GetPage(name: "/", page: ()=>Products()),
  GetPage(name: "/", page: ()=>Orders()),
  GetPage(name: "/", page: ()=>Profile()),


];