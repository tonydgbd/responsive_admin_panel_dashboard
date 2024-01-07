import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_padding.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'responsive_layout.dart';

List<String> _buttonNames = ["Apercu", "Revenu", "Vente", "Gestions"];
int _currentSelectedButton = 0;

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purpleLight,
      child: Row(children: [
        if (ResponsiveLayout.isComputer(context))
          Container(
            margin: const EdgeInsets.all(AppPadding.P10),
            height: double.infinity,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 0),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ], shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/flutterLogo.png",
                ),
              ),
            ),
          )
        else
          IconButton(
            color: Colors.white,
            iconSize: 30,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        const SizedBox(width: AppPadding.P10),
        if (ResponsiveLayout.isComputer(context))
          ...List.generate(
              _buttonNames.length,
              (index) => TextButton(
                  onPressed: () {
                    setState(() {
                      _currentSelectedButton = index;
                      CoreController.instance!.changeIndex(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.P10 * 2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _buttonNames[index],
                            style: TextStyle(
                              color: _currentSelectedButton == index
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(AppPadding.P10 / 2),
                            width: 60,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: _currentSelectedButton == index
                                  ? const LinearGradient(
                                      colors: [
                                        AppColors.red,
                                        AppColors.orange,
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ]),
                  )))
        else
          Padding(
            padding: const EdgeInsets.all(AppPadding.P10 * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _buttonNames[_currentSelectedButton],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(AppPadding.P10 / 2),
                  width: 60,
                  height: 2,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.red,
                        AppColors.orange,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        const Spacer(),
        IconButton(
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            // DataController.instance.refreshUI();
            // Supabase.instance.client.from("Users").select("*");
          },
          icon: const Icon(Icons.refresh),
        ),
        Stack(
          children: [
            IconButton(
              color: Colors.white,
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            const Positioned(
              right: 6,
              top: 6,
              child: CircleAvatar(
                backgroundColor: Colors.pink,
                radius: 8,
                child: Text(
                  "3",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        if (!ResponsiveLayout.isPhoneLimit(context))
          InkWell(
            onTap: () {
              showMenu(context: context, position: RelativeRect.fromLTRB(Get.width-50, 50, 0, 20), items: [
                PopupMenuItem(
                  onTap: (() {
                    AuthController.instance.logout();
                  }),
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      Text("Logout"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: (() {
                    DataController.instance.getCompany();
                  }),
                  child: Row(
                    children: [
                      Icon(Icons.person),
                      Text("Profile"),
                    ],
                  ),
                ),
              ]);
            },
            child: Container(
              margin: const EdgeInsets.all(AppPadding.P10),
              height: double.infinity,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                  blurRadius: 10,
                )
              ], shape: BoxShape.circle),
              child: const CircleAvatar(
                backgroundColor: AppColors.orange,
                radius: 35,
                backgroundImage: AssetImage(
                  "assets/images/profile.png",
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
