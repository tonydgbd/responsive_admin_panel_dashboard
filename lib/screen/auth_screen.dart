import 'package:directus/directus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/textstyles.dart';
import 'package:responsive_admin_panel_dashboard/utils/loader.dart';
import 'package:rive/rive.dart';

class AuthScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          // RiveAnimation.asset("assets/6199-12052-swift.riv",fit: BoxFit.cover,),
          Center(
            child: Card(
              borderOnForeground: false,
              shape: StadiumBorder(),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                 ),
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: 400,
                height: 400,
                child: Column(
                  children: [
                    Text("Identification",style: largeTitle,),
                  const SizedBox(height: 20,),

                    TextField(
                      controller:emailController ,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: mediumTitle,
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: mediumTitle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 50,),
                  CupertinoButton(child: Text("S'identifier",style: mediumTitle.copyWith(color: Colors.white),), onPressed: ()async{
                    try {
                      showLoader();
                      // var res=await CoreController.instance.sdk.items("User").readMany();
                      // print(res.data);
                       await DirectusCoreSingleton.instance.auth.login(email: "manager@test.com", password: "12345678");
                      //  await DirectusCoreSingleton.instance.auth.staticToken(token);
                       stopLoader();
                    print(DirectusCoreSingleton.instance.auth.currentUser);
                    } catch (e) {
                       stopLoader();
                       EasyLoading.showError("Erreur d'authentification");
                      print((e as DirectusError).message);
                      print((e as DirectusError).additionalInfo);
                      print((e as DirectusError).dioError);
                      print((e as DirectusError).dioError!.requestOptions.data);
                    }
                   

                  },color: primaryColor,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}