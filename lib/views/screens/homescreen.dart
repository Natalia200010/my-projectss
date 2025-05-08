import 'package:flutter/material.dart';
import 'package:flutter_app/configs/mycolors.dart';
import 'package:flutter_app/controller/homescreencontroller.dart';
import 'package:flutter_app/views/screens/dashboard.dart';
import 'package:flutter_app/views/screens/orders.dart';
import 'package:flutter_app/views/screens/products.dart';
import 'package:flutter_app/views/screens/profile.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
Homescreencontroller homescreencontroller= Homescreencontroller();
List myScreens=[Dashboard(),Products(),Orders(),Profile()];

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), backgroundColor: const Color.fromARGB(255, 156, 62, 94),   ),
      bottomNavigationBar: Obx( 
        ()=> BottomNavigationBar(items:[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.category_rounded),label: "Menu"),
        BottomNavigationBarItem(icon: Icon(Icons.list),label: "Orders"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
         

      ],
      
     unselectedItemColor: secondaryColor,
     selectedItemColor: secondary2Color,
     backgroundColor:backgroundcolor ,
     showUnselectedLabels: true,
     currentIndex: homescreencontroller.selectedScreenIndex.value,
     onTap: (p)=>homescreencontroller.updateSelectedIndex(p),
    ),
    ),
    body: Obx(()=>myScreens[homescreencontroller.selectedScreenIndex.value],

     ) );
  }
}