import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';

import '../resource/app_padding.dart';
import '../widget/charts.dart';
import '../widget/pie_chart.dart';
import '../widget/responsive_layout.dart';

class Todo {
  String name;
  bool enable;
  Todo({this.enable = true, required this.name});
}

class PanelLeftScreen extends StatefulWidget {
  const PanelLeftScreen({super.key});

  @override
  State<PanelLeftScreen> createState() => _PanelLeftScreenState();
}

class _PanelLeftScreenState extends State<PanelLeftScreen> {
  final List<Todo> _todos = [
    Todo(name: "Purchase Paper", enable: true),
    Todo(name: "Refill the inventory of speakers", enable: true),
    Todo(name: "Hire someone", enable: true),
    Todo(name: "Maketing Strategy", enable: true),
    Todo(name: "Selling furniture", enable: true),
    Todo(name: "Finish the disclosure", enable: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (ResponsiveLayout.isComputer(context))
            Container(
              color: AppColors.purpleLight,
              width: 50,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.purpleDark,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.P10 / 2,
                      top: AppPadding.P10 / 2,
                      right: AppPadding.P10 / 2),
                  child: Card(
                    color: AppColors.purpleLight,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: ListTile(
                        title: Text(
                          "Tickets Vendus",
                          style: TextStyle(color: Colors.white),
                        ),
                        // subtitle: Text(
                        //   // "18% of Products Sold",
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        trailing: Chip(
                          label: Obx(() => Text(
                                DataController.instance.tickets.length
                                    .toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                const LineChartSample2(),
                const PieChartSample2(),
                Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.P10 / 2,
                        top: AppPadding.P10 / 2,
                        right: AppPadding.P10 / 2,
                        bottom: AppPadding.P10),
                    child: Card(
                      color: AppColors.purpleLight,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(() => Column(
                          children: DataController.instance.tickets.map((ticket) => ListTile(
                                  title: Text(
                                    " Destination ${DataController.instance.trajets.firstWhere((element) => element.id== ticket.trajetId).villeArrive} - ${DataController.instance.trajets.firstWhere((element) => element.id== ticket.trajetId).villeDepart} - ${ticket.dateDepart} - ${ticket.heureDepart} - ${ticket.prix} FCFA}" ,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  
                                  )).toList()
                                  )),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
