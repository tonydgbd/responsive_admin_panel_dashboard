import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';

import '../resource/app_padding.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(
      //     left: AppPadding.P10 / 2,
      //     right: AppPadding.P10 / 2,
      //     top: AppPadding.P10,
      //     bottom: AppPadding.P10),
      child: Card(
        color: AppColors.purpleLight,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Obx(() => PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      )),
                ),
              ),
              Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...DataController.instance.trajets.map((element) {
                        return Indicator(
                          color: generateColorFromString(element.villeArrive!),
                          text: element.villeArrive,
                          isSquare: true,
                        );
                      }).toList(),
                     
                    ],
                  )),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
Color generateColorFromString(String inputString) {
  // Utilisez une fonction de hachage pour convertir la chaîne en un entier
  int hash = 0;
  for (int i = 0; i < inputString.length; i++) {
    hash = inputString.codeUnitAt(i) + ((hash << 5) - hash);
  }

  // Utilisez le résultat du hachage pour générer une couleur
  final double hue = (hash % 360).toDouble();
  final double saturation = 0.4; // 0.0 à 1.0
  final double value = 0.8; // 0.0 à 1.0

  return HSVColor.fromAHSV(1.0, hue, saturation, value).toColor();
}
  List<PieChartSectionData> showingSections() {
    return DataController.instance.trajets.map((element) {
      final isTouched = element.id == touchedIndex;
      final fontSize = isTouched ? 25.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: generateColorFromString(element.villeArrive!),
        value: 40,
        title: DataController.instance.tickets
            .where((p0) => p0.trajetId == element.id)
            .length
            .toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 14.0;
    //   final radius = isTouched ? 60.0 : 50.0;
    //   const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: const Color(0xff0293ee),
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: const Color(0xfff8b250),
    //         value: 30,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: const Color(0xffff5182),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: const Color(0xff13d38e),
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = Colors.white70,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            // fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
