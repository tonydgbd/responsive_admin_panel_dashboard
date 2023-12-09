

import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/textstyles.dart';

import '../../widget/responsive_layout.dart';

class StationScreen extends StatelessWidget {
  const StationScreen({super.key});

  @override
  Widget build(BuildContext context) {
      PanelLeftScreen(){
        return Container(
          color: Colors.red,
        );
      }
      PanelCenterScreen(){
        return Obx(
          ()=> Container(
            
            decoration: BoxDecoration( 
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  ExpandableTheme(
          data: ExpandableThemeData(
            context,
            
            headerColor: AppColors.purpleLight,
            headerTextStyle: mediumTitle.copyWith(color: Colors.white),
            rowBorder: const BorderSide(color: Colors.amber),
            expandedBorderColor: Colors.white,
            rowColor: Colors.white,
            paginationSize: 50,
          ),
          child: ExpandableDataTable(
            rows:   [
              ...DataController.instance.gares.map((element) => ExpandableRow(cells:  [
                  ExpandableCell(columnTitle: 'Nom de la Gare',value: element.nom),
                  ExpandableCell(columnTitle: 'Ville',value: element.ville),
                ],
              )).toList(),
              ExpandableRow(cells:  [
                  ExpandableCell(columnTitle: 'Nom de la Gare',value: "Gare 1"),
                  ExpandableCell(columnTitle: 'Ville',value: "Ouagadougou"),
                ],
              )
            ],
            headers: [
              ExpandableColumn(columnTitle: "Nom de la Gare", columnFlex: 2),
              ExpandableColumn(columnTitle: "Ville", columnFlex: 1),
            ],
            visibleColumnCount: 2,
          ),
              ),
          ),
        );
      }
      PanelRightScreen(){
        return Container(
          color: Colors.green,
        );
      }


    return Obx( () =>ResponsiveLayout(
        tiny: Container(),
        phone: CoreController.instance.tabIndex == 0
            ?  PanelLeftScreen()
            : CoreController.instance.tabIndex == 1
                ?  PanelCenterScreen()
                :  PanelRightScreen(),
        tablet: Row(
          children:  [
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
             DrawerScreen(),
            Expanded(child: PanelCenterScreen()),
          ],
        ),
      ))
      ;
  }
}