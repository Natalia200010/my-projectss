import 'package:flutter/material.dart';

Widget myButton(VoidCallback action,{ required label,color=const Color.fromARGB(255, 46, 133, 200),}){
  return MaterialButton(onPressed: action,
  color: const Color.fromARGB(255, 209, 115, 181),
    minWidth: 500,
  child: Text(label),
  );

}


