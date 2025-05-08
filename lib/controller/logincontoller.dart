import 'package:get/get.dart';

class Logincontoller extends GetxController{
  var errorMessage="".obs;
  seterrorMessage(newMessage){
    errorMessage.value=newMessage;

  }
}