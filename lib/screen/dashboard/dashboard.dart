

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/panel_center_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/panel_left_screen.dart';
import 'package:responsive_admin_panel_dashboard/screen/panel_right_screen.dart';
import 'package:responsive_admin_panel_dashboard/widget/responsive_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx( () =>ResponsiveLayout(
        tiny: Container(),
        phone: CoreController.instance.tabIndex == 0
            ? const PanelLeftScreen()
            : CoreController.instance.tabIndex == 1
                ?  PanelCenterScreen()
                : const PanelRightScreen(),
        tablet: Row(
          children: const [
            Expanded(child: PanelLeftScreen()),
            Expanded(child: PanelRightScreen())
          ],
        ),
        largeTablet: Row(
          children:  [
            Expanded(child: PanelLeftScreen()),
            Expanded(child: PanelCenterScreen()),
            Expanded(child: PanelRightScreen())
          ],
        ),
        computer: Row(
          children:  [
            Expanded(child: DrawerScreen()),
            Expanded(child: PanelLeftScreen()),
            Expanded(child: PanelCenterScreen()),
            Expanded(child: PanelRightScreen())
          ],
        ),
      ))
      ;
  }
}