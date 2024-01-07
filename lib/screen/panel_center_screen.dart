import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';

import '../resource/app_colors.dart';
import '../resource/app_padding.dart';
import '../widget/bar_chat.dart';

class Person {
  String name;
  Color color;
  Person({required this.name, required this.color});
}

class PanelCenterScreen extends StatefulWidget {
  PanelCenterScreen({super.key});
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final Color avgColor = const Color(0xFFFF683B).avg(const Color(0xFFE80054));
  @override
  State<PanelCenterScreen> createState() => _PanelCenterScreenState();
}

class _PanelCenterScreenState extends State<PanelCenterScreen> {
  final List<Person> _persons = [
    Person(name: "Theia Bowen", color: Color(0xfff8b250)),
    Person(name: "Fariha Odling", color: Color(0xffff5182)),
    Person(name: "Viola Willis", color: Color(0xff0293ee)),
    Person(name: "Emmett Forrest", color: Color(0xfff8b250)),
    Person(name: "Nick Jarvis", color: Color(0xff13d38e)),
    Person(name: "ThAmit Clayeia", color: Color(0xfff8b250)),
    Person(name: "ThAmalie Howardeia", color: Color(0xffff5182)),
    Person(name: "Campbell Britton", color: Color(0xff0293ee)),
    Person(name: "Haley Mellor", color: Color(0xffff5182)),
    Person(name: "Harlen Higgins", color: Color(0xff13d38e)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        "Trajets Disponibles",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Obx(() => Chip(
                            label: Text(
                              DataController.instance.trajets.length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  )),
            ),
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
                        "Total des Departs",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Obx(() => Chip(
                            label: Text(
                              DataController.instance.trajets
                                  .map((element) => element.horaires!.length)
                                  .toList()
                                  .fold(
                                      0,
                                      (previousValue, element) =>
                                          previousValue + element)
                                  .toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  )),
            ),

            Obx(() {
              var rawBarGroups = <BarChartGroupData>[];
    var showingBarGroups = <BarChartGroupData>[];
              final barGroup1 = makeGroupData(0, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==1 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());
    final barGroup2 = makeGroupData(1, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==2 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());
    final barGroup3 = makeGroupData(2, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==3 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());;
    final barGroup4 = makeGroupData(3, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==4 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());
    final barGroup5 = makeGroupData(4, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==5 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());
    final barGroup6 = makeGroupData(5, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==6 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());
    final barGroup7 = makeGroupData(6, DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -15))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 15)))).where((element) => element.dateCreated.weekday==1 ).length.toDouble(), DataController.instance.tickets.where((p0) => p0.dateCreated.isAfter(DateTime.now().add(Duration(days: -3))) && p0.dateCreated.isBefore(DateTime.now().add(Duration(days: 3)))).where((element) => element.dateCreated.weekday==7 ).fold(0, (previousValue, element) => previousValue+element.prix).toDouble());

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
              return Visibility(
              visible: DataController.instance.tickets.isNotEmpty,
              child: BarChartSample2(rawBarGroups: rawBarGroups, showingBarGroups: showingBarGroups,))
  ;}),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: AppPadding.P10 / 2,
            //       top: AppPadding.P10,
            //       bottom: AppPadding.P10,
            //       right: AppPadding.P10 / 2),
            //   child: Card(
            //     color: AppColors.purpleLight,
            //     elevation: 3,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: Column(
            //       children: List.generate(
            //           _persons.length,
            //           (index) => ListTile(
            //                 leading: CircleAvatar(
            //                   radius: 15,
            //                   backgroundColor: _persons[index].color,
            //                   child: Text(
            //                     _persons[index].name.substring(0, 1),
            //                     style: const TextStyle(color: Colors.white),
            //                   ),
            //                 ),
            //                 title: Text(
            //                   _persons[index].name,
            //                   style: const TextStyle(color: Colors.white),
            //                 ),
            //                 trailing: IconButton(
            //                     onPressed: () {},
            //                     icon: const Icon(
            //                       Icons.message,
            //                       color: Colors.white,
            //                     )),
            //               )),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    final double width = 7;
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
  
  

