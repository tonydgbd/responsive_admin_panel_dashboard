import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';

import '../resource/app_padding.dart';
import '../widget/responsive_layout.dart';

class ButtonsInfo {
  String title;
  IconData icon;

  ButtonsInfo({required this.title, required this.icon});
}

List<ButtonsInfo> _buttonInfo = [
  ButtonsInfo(title: "Home", icon: Icons.home),
  ButtonsInfo(title: "Gestion des Gares", icon: Icons.business),
  ButtonsInfo(title: "Gestion des trajets", icon: Icons.trip_origin),
  ButtonsInfo(title: "Billeterie", icon: Icons.airplane_ticket),
  ButtonsInfo(title: "Sales", icon: Icons.sell),
  ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
  ButtonsInfo(title: "Security", icon: Icons.verified_user),
  ButtonsInfo(title: "Users", icon: Icons.supervised_user_circle_rounded),
];


class DrawerScreen extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        elevation: 0,
        backgroundColor: AppColors.purpleDark,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.P10),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    'EasyTicket Menu',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: !ResponsiveLayout.isComputer(context)
                      ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close, color: Colors.white))
                      : null,
                ),
                ...List.generate(
                    _buttonInfo.length,
                    (index) => Obx(
                      ()=> Column(
                            children: [
                              Container(
                                decoration: index == CoreController.instance.currentIndex.value
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(colors: [
                                          AppColors.red.withOpacity(0.9),
                                          AppColors.orange.withOpacity(0.9),
                                        ]))
                                    : null,
                                child: ListTile(
                                  title: Text(
                                    _buttonInfo[index].title,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(AppPadding.P10),
                                    child: Icon(
                                      _buttonInfo[index].icon,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    
                                      CoreController.instance.currentIndex.value = index;
                                  
                                    CoreController.instance.changeIndex(index);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 0.1,
                              ),
                            ],
                          ),
                    )
                        )
              ],
            ),
          ),
        ),
      )
    ;
  }
}
