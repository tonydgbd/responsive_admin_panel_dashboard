import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/gare_management/gare_list.dart';
import 'package:responsive_admin_panel_dashboard/screen/marketing_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/panel_center_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/staf_management%20copy.dart';
import 'package:responsive_admin_panel_dashboard/screen/trajet_management/trjaet_list.dart';
import 'package:responsive_admin_panel_dashboard/widget/custom_app_bar.dart';
import 'package:responsive_admin_panel_dashboard/widget/responsive_layout.dart';

import 'screen/booking/booking_screen.dart';
import 'screen/dashboard/dashboard.dart';


class WidgetTree extends StatefulWidget {
  WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  final List<Widget> _icons = const [
    Icon(Icons.add, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.compare_arrows, size: 30),
  ];
  final List<Widget> _screens =  [
    DashboardScreen(),
    // StationScreen(),
    TrajetScreen(),
    BookingScreen(),
    StafManagementScreen(),
    MarketingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx( () => Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context))
            ? Container()
            : const CustomAppBar(),
      ),
      body: _screens[CoreController.instance.currentIndex.value],
      drawer:  DrawerScreen(),
      bottomNavigationBar: ResponsiveLayout.isPhoneLimit(context)
          ? CurvedNavigationBar(
              backgroundColor: AppColors.purpleDark,
              color: Colors.white24,
              index: CoreController.instance.tabIndex.value,
              items: _icons,
              onTap: (index) {
                
                  CoreController.instance.changeTab(index);
                
              },
            )
          : const SizedBox(),
    )));
  }
}
