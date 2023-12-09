

import 'package:directus/directus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/models/user.dart';
import 'package:responsive_admin_panel_dashboard/screen/auth_screen.dart';
import 'package:responsive_admin_panel_dashboard/utils/loader.dart';
import 'package:responsive_admin_panel_dashboard/widget_tree.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
    static DirectusCore sdk = DirectusCoreSingleton.instance;
    Rx<User?> user = null.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     
   
  }
  @override
   onReady() {  
    super.onReady();
     setinitalScreen();
    DirectusCoreSingleton.instance.auth.onChange((type, event) async{
      print(type);
      if(type=="login"){
        await fetchUserdata();
        Get.to(WidgetTree());
      }
      else if( event == null){
        Get.to(AuthScreen());
      }else{
        await fetchUserdata();
        Get.to(WidgetTree());
      }
    });
   }

  fetchUserdata()async{
    var response = await sdk.auth.currentUser!.client.request('/users/me');
    print(response.data);
     user = User.fromJson(response.data['data']).obs;
    print("ended user data");
  }
  logout(){
    sdk.auth.logout();
    Get.to(AuthScreen());
  }

  setinitalScreen()async {
    var value = DirectusCoreSingleton.instance.auth.currentUser;
      if(value !=null){
         await fetchUserdata();
         await DataController.instance.getCompany();
        Get.to(WidgetTree());
      }else{
       
        Get.to(AuthScreen());
      }
    
  }
}