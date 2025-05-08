import 'package:get/get.dart';

class Signupcontroller extends GetxController{
  var errorMessage="".obs;
  seterrorMessage(newMessage){
    errorMessage.value=newMessage;

  }
}