import 'package:get/get.dart';

class Menucontroller extends GetxController{
  var errorMessage="".obs;
  seterrorMessage(newMessage){
    errorMessage.value=newMessage;

  }
}