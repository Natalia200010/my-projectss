import 'package:get/get.dart';

class Homescreencontroller extends GetxController{

var selectedScreenIndex=0.obs;
updateSelectedIndex(pos)=> selectedScreenIndex.value=pos;

}