

import 'package:directus/directus.dart';
import 'package:get/get.dart';
class CoreController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt tabIndex = 0.obs;
  static CoreController instance = Get.find();
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    try {

    } catch (e) {
      print("Erreur sdk");
      print((e as DirectusError).message);
    }
      
  }
  void changeIndex(int index) {
    currentIndex.value = index;
  }
   void changeTab(int index) {
    tabIndex.value = index;
  }

}