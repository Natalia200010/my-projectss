import 'package:get/get.dart';

class Snackbarcontroller extends GetxController{
  var errorMessage="".obs;
  seterrorMessage(newMessage){
    errorMessage.value=newMessage;

  }
}