

import 'package:directus/directus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';

import '../controllers/screenscontroller.dart';
import '../widget/responsive_layout.dart';

class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

 Widget PanelLeftScreen(){
    return Container(
      width: Get.width * 0.2,
      color: Colors.white,
      height: Get.height,
      child: Column(
        children: [
          Text("Liste des utilisateurs", style: TextStyle(color: Colors.white),),

          Divider(color: Colors.white,),
          CupertinoButton(child: Text("Ajouter un utilisateur"),padding: EdgeInsets.all(2.5),  color: primaryColor, onPressed: ()async{
            TextEditingController emailController = TextEditingController();
            TextEditingController firstNameController = TextEditingController();
            TextEditingController lastNameController = TextEditingController();
            TextEditingController passwordController = TextEditingController();
            // TextEditingController roleController = TextEditingController();
            Get.defaultDialog(
               content: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  width: Get.width*0.5,
                  height: Get.height*0.5,
                  child: Column(
                    children: [
                      Text("Ajouter un utilisateur", style: TextStyle(color: Colors.white),),
                      Divider(color: Colors.white,),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email"
                        ),
                      ),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          hintText: "Prénom"
                        ),
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          hintText: "Nom"
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Mot de passe"
                        ),
                      ),
            CupertinoButton(child: Text("Ajouter"),padding: EdgeInsets.all(5), color: primaryColor, onPressed: ()async{
                        try {
                          if(emailController.text.isEmpty){
                            await EasyLoading.showError("Veuillez renseigner l'email");
                      
                            return;

                          }
                          if(firstNameController.text.isEmpty){
                            EasyLoading.showError("Veuillez renseigner le prénom");
                            return;
                          }
                          if(lastNameController.text.isEmpty){
                            EasyLoading.showError("Veuillez renseigner le nom");
                            return;
                          }
                          if(passwordController.text.isEmpty){
                            EasyLoading.showError("Veuillez renseigner le mot de passe");
                            return;
                          }
                          if(AuthController.instance.user.value == null){
                            EasyLoading.showError("Veuillez vous connecter");
                            return;
                          }
                          if(emailController.text.isEmail==false){
                            EasyLoading.showError("Veuillez renseigner un email valide");
                            return;
                          }
                          EasyLoading.show(status: "Chargement");
                          await DirectusCoreSingleton.instance.users.createOne(
                            DirectusUser(
                              email: emailController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              role: AuthController.instance.user.value!.roleId,
                              password: passwordController.text
                            )
                          );
                          await DataController.instance.getGares();
                          EasyLoading.showSuccess("Utilisateur ajouté avec succès");
                        } catch (e) {
                          EasyLoading.dismiss();
                          print((e as DirectusError).message);
                        }
                      })
                    ],
                  ),
                )
            );
           

          }),
         DataController.instance.SoftawresUser.length > 0 ? Expanded(
            child: ListView.builder(
              itemCount: DataController.instance.SoftawresUser.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(DataController.instance.SoftawresUser[index].firstName! + " " + DataController.instance.SoftawresUser[index].lastName!),
                  subtitle: Text(DataController.instance.SoftawresUser[index].email!),
                  // trailing: Text(DataController.instance.SoftawresUser[index].role),
                );
              },
            ),
          ) : Container()
        ],
       ),
    );
 }
  Widget PanelCenterScreen(){
      return Container();
  }
  Widget PanelRightScreen(){
      return Container();
  }

  @override
  Widget build(BuildContext context) {
     return Obx(() => ResponsiveLayout(
          tiny: Container(),
          phone: CoreController.instance.tabIndex == 0
              ? PanelLeftScreen()
              : CoreController.instance.tabIndex == 1
                  ? PanelCenterScreen()
                  : PanelRightScreen(),
          tablet: Row(
            children: [
              Expanded(child: PanelLeftScreen()),
              Expanded(child: PanelRightScreen())
            ],
          ),
          largeTablet: Row(
            children: [
              Expanded(child: PanelLeftScreen()),
              Expanded(child: PanelCenterScreen()),
              Expanded(child: PanelRightScreen())
            ],
          ),
          computer: Row(
            children: [
              SizedBox(width: Get.width * 0.2, child: DrawerScreen()),
              SizedBox(width: Get.width * 0.2, child: PanelLeftScreen()),
              SizedBox(width: Get.width * 0.2, child: PanelCenterScreen()),
              Expanded(child: PanelRightScreen())
            ],
          ),
        ));
  }
}