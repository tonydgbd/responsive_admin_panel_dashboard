import 'package:choice/choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/models/horaire.dart';
import 'package:responsive_admin_panel_dashboard/models/trajet.dart';
import 'package:responsive_admin_panel_dashboard/resource/app_colors.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/colors.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/textstyles.dart';

import '../../widget/responsive_layout.dart';

class TrajetScreen extends StatelessWidget {
  RxInt selected_horaires = 0.obs;
  RxInt selected_trajet = 0.obs;
  TextEditingController nombre_place_controller = TextEditingController();
  TextEditingController heure_depart_controller = TextEditingController();
  TrajetScreen({super.key});

  RxList<String> selected_days = <String>[].obs;
  List<String> choices = [
    'lundi',
    'mardi',
    'mercredi',
    'jeudi',
    'vendredi',
    'samedi',
    'dimanche'
  ];
  String? selectedValue;
  RxString screenToShow = 'modifyHoraire'.obs;

  @override
  Widget build(BuildContext context) {
// ever(screenToShow, (callback)  {
//   print(callback);
//   if(callback !="addHoraire"){
//       selected_horaires.value = 0 ;
//    selected_trajet.value = 0;
//   }

// });
    Widget showModifyDeparture() {
      return Obx(() {
        if (selected_horaires.value == 0 || selected_trajet.value == 0 ||
            DataController.instance.trajets
                .firstWhere((element) => element.id == selected_trajet.value)
                .horaires!
                .isEmpty) {
          return SizedBox();
        }
        var hora = DataController.instance.trajets
            .firstWhere((element) => element.id == selected_trajet.value)
            .horaires!
            .firstWhere((element) {
              if(selected_horaires.value == 0){
                return false;
              }else{
          return element.id == selected_horaires.value;

              }
            });
        nombre_place_controller.text = hora.nombrePlace.toString();
        heure_depart_controller.text = hora.heureDepart.toString();
        selected_days.value = hora.jourDeDisponibilite;
        print(selected_days.value);
        return selected_horaires != 0 && selected_trajet != 0
            ? Column(
                children: [
                  Text(
                    "Modifier l'horaire",
                    style: largeTitle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Nombre de places disponible"),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: TextField(
                      controller: nombre_place_controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Heure de depart"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width * 0.2,
                    child: TextField(
                      onTap: () async {
                        var time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (time != null) {
                          heure_depart_controller.text =
                              "${time.hour}H${time.minute}";
                        } else {
                          heure_depart_controller.text = "8h00";
                        }
                      },
                      controller: heure_depart_controller,
                      keyboardType: TextInputType.none,
                      enabled: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Jour de disponibilite"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width * 0.3,
                    child: Obx(
                      () => Choice<String>.inline(
                        clearable: true,
                        multiple: true,
                        value: selected_days.value,
                        onChanged: (value) {
                          selected_days.value = value;
                        },
                        itemCount: choices.length,
                        itemBuilder: (state, i) {
                          return Obx(
                            () => ChoiceChip(
                              selectedColor: Colors.green,
                              backgroundColor: Colors.grey[300],
                              selected:
                                  selected_days.value.contains(choices[i]),
                              onSelected: (val) {
                                if (selected_days.contains(choices[i])) {
                                  selected_days.remove(choices[i]);
                                } else {
                                  selected_days.add(choices[i]);
                                }
                              },
                              label: Text(choices[i]),
                            ),
                          );
                        },
                        listBuilder: ChoiceList.createGrid(
                          spacing: 1,
                          columns: 3,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      child: Text(
                        "Enregistrer",
                        style: mediumTitle.copyWith(color: Colors.white),
                      ),
                      color: AppColors.purpleLight,
                      onPressed: () {
                        DataController.instance.updateHoraire(Horaire(
                            id: hora.id,
                            trajet_id: selected_trajet.value,
                            nombrePlace:
                                int.parse(nombre_place_controller.text),
                            userCreated: hora.userCreated,
                            dateCreated: hora.dateCreated,
                            userUpdated: AuthController.instance.user.value!.id,
                            dateUpdated: DateTime.now(),
                            heureDepart: heure_depart_controller.text,
                            jourDeDisponibilite: selected_days.value));
                        nombre_place_controller.clear();
                        selected_days.clear();
                        heure_depart_controller.clear();
                        selected_horaires.value = 0;
                        selected_trajet.value = 0;
                      })
                ],
              )
            : SizedBox();
      });
    }

    Widget showAddDeparture() {
      return Obx(() {
        if (selected_trajet == 0) {
          return Container(
            child: Text("Selectionner un trajet d'abord"),
          );
        }

        return Column(
          children: [
            Text(
              "Ajouter une heure de depart",
              style: largeTitle,
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Nombre de places disponible"),
            SizedBox(
              width: Get.width * 0.2,
              child: TextField(
                controller: nombre_place_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Heure de depart"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width * 0.2,
              child: TextField(
                onTap: () async {
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    heure_depart_controller.text =
                        "${time.hour}H${time.minute}";
                  } else {
                    heure_depart_controller.text = "8h00";
                  }
                },
                controller: heure_depart_controller,
                keyboardType: TextInputType.none,
                enabled: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Jour de disponibilite"),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: Get.width * 0.3,
              child: Obx(
                () => Choice<String>.inline(
                  clearable: true,
                  multiple: true,
                  value: selected_days.value,
                  onChanged: (value) {
                    selected_days.value = value;
                  },
                  itemCount: choices.length,
                  itemBuilder: (state, i) {
                    return Obx(
                      () => ChoiceChip(
                        selectedColor: Colors.green,
                        backgroundColor: Colors.grey[300],
                        selected: selected_days.value.contains(choices[i]),
                        onSelected: (val) {
                          if (selected_days.contains(choices[i])) {
                            selected_days.remove(choices[i]);
                          } else {
                            selected_days.add(choices[i]);
                          }
                        },
                        label: Text(choices[i]),
                      ),
                    );
                  },
                  listBuilder: ChoiceList.createGrid(
                    spacing: 1,
                    columns: 3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                child: Text(
                  "Enregistrer",
                  style: mediumTitle.copyWith(color: Colors.white),
                ),
                color: AppColors.purpleLight,
                onPressed: () {
                  print(selected_days);
                  DataController.instance.addHoraire(Horaire(
                      id: 0,
                      trajet_id: selected_trajet.value,
                      nombrePlace: int.parse(nombre_place_controller.text),
                      userCreated: AuthController.instance.user.value!.id!,
                      dateCreated: DateTime.now(),
                      userUpdated: AuthController.instance.user.value!.id,
                      dateUpdated: DateTime.now(),
                      heureDepart: heure_depart_controller.text,
                      jourDeDisponibilite: selected_days.value));
                  nombre_place_controller.clear();
                  selected_days.clear();
                  heure_depart_controller.clear();
                  selected_horaires.value = 0;
                  selected_trajet.value = 0;
                })
          ],
        );
      });
    }

    Widget showAddTrajet() {
      RxString selected_destination = "".obs;
      String selected_depart = "";
      int? selected_gare_destination;
      int prix = 0;
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ajouter une destination",
              style: largeTitle,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Prix d'une place",
              style: mediumTitle,
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty && value.isNumericOnly) {
                    prix = int.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            // Text("Choisir la ville de depart",style: mediumTitle,),

            // DropdownButtonFormField(items: DataController.instance.villes.map((e)=> DropdownMenuItem(child: Text(e),value: e,)).toList()

            // , onChanged: (value){
            //   selected_depart = value!;
            // },
            // dropdownColor: Colors.white,),
            // const SizedBox(
            //   height: 20,
            // ),
            Text(
              "Choisir la ville d'arrive",
              style: mediumTitle,
            ),

            DropdownButtonFormField(
              items: DataController.instance.villes
                  .where((p0) =>
                      p0.toLowerCase().trim() !=
                      DataController.instance.gares
                          .firstWhere((element) =>
                              element.id ==
                              AuthController.instance.user.value!.gareId!)
                          .ville
                          .toLowerCase()
                          .trim())
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) {
                selected_destination.value = value!;
                selected_destination.refresh();
              },
              dropdownColor: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Choisir la Gare d'arrive",
              style: mediumTitle,
            ),

            Obx(() => DropdownButtonFormField(
                  items: DataController.instance.gares
                      .where((p0) {
                        return p0.ville.toLowerCase().trim() !=
                            DataController.instance.gares
                                .firstWhere((element) =>
                                    element.id ==
                                    AuthController.instance.user.value!.gareId!)
                                .ville
                                .toLowerCase()
                                .trim();
                      })
                      .where((element) {
                        if (selected_destination.isNotEmpty) {
                          return element.ville.toLowerCase().trim() ==
                              selected_destination.toLowerCase().trim();
                        } else {
                          return true;
                        }
                      })
                      .map((e) => DropdownMenuItem(
                            child: Text("${e.nom}-${e.ville}"),
                            value: e.id,
                          ))
                      .toList(),
                  onChanged: (value) {
                    selected_gare_destination = value!;
                  },
                  dropdownColor: Colors.white,
                )),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CupertinoButton(
                  child: Text(
                    "Ajouter",
                    style: mediumTitle.copyWith(color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: () async {
                    await DataController.instance.addTrajet(Trajet(
                        id: 0,
                        userCreated: AuthController.instance.user.value!.id!,
                        dateCreated: DateTime.now(),
                        userUpdated: AuthController.instance.user.value!.id!,
                        dateUpdated: DateTime.now(),
                        prix: prix,
                        gareDeDepart:
                            AuthController.instance.user.value!.gareId!,
                        villeDepart: DataController.instance.gares
                            .firstWhere((element) =>
                                element.id ==
                                AuthController.instance.user.value!.gareId!)
                            .ville,
                        villeArrive: selected_destination.value,
                        horaires: []));
                    screenToShow.value = "";
                  }),
            )
          ],
        ),
      );
    }

    PanelLeftScreen() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: Colors.white,
        height: Get.height,
        child: Column(
          children: [
            CupertinoButton(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onPressed: () {
                screenToShow.value = 'addTrajet';
              },
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    "Ajouter un trajet",
                    style: mediumTitle.copyWith(color: Colors.white),
                  )
                ],
              ),
              color: primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Trajets",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: DataController.instance.trajets.length,
                    itemBuilder: (context, index) {
                      var trj = DataController.instance.trajets[index];
                      return Obx(() => ListTile(
                            tileColor: selected_trajet.value == trj.id
                                ? Colors.green
                                : Colors.red,
                            onTap: () {
                              selected_trajet.value = trj.id!;
                              selected_horaires.value = trj.horaires!.isEmpty
                                  ? 0
                                  : trj.horaires!.first.id!;
                              // DataController.instance.trajets.get\
                              screenToShow.value = "";
                            },
                            leading: CircleAvatar(
                              backgroundColor: selected_trajet.value == trj.id
                                  ? Colors.green
                                  : Colors.grey,
                              child: Text("T"),
                            ),
                            title: Text(
                                "${trj.villeDepart} -> ${trj.villeArrive} "),
                            subtitle: Text("Trajet "),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {},
                            ),
                          ));
                    }),
              ),
            )
          ],
        ),
      );
    }

    PanelCenterScreen() {
      return Obx(
        () => selected_trajet.value != 0
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: Colors.grey[200],
                height: Get.height,
                child: Column(
                  children: [
                    CupertinoButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      onPressed: () {
                        screenToShow.value = 'addHoraire';
                        print(screenToShow.value);
                        print(selected_horaires.value);
                        print(selected_trajet.value);
                        nombre_place_controller.clear();
                        selected_days.clear();
                        heure_depart_controller.clear();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            "Ajouter un Depart",
                            style: mediumTitle.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                      color: primaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Departs",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                            itemCount: DataController.instance.trajets
                                .firstWhere((element) =>
                                    element.id == selected_trajet.value)
                                .horaires!
                                .length,
                            itemBuilder: (context, index) {
                              var trj = DataController.instance.trajets
                                  .firstWhere((element) =>
                                      element.id == selected_trajet.value)
                                  .horaires![index];
                              return Obx(
                                () => ListTile(
                                  selected: trj.id == selected_horaires.value,
                                  onTap: () {
                                    selected_horaires.value = trj.id;
                                    selected_horaires.refresh();
                                    selected_trajet.refresh();
                                    screenToShow.value = "";
                                  },
                                  selectedColor: AppColors.purpleLight,
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        trj.id == selected_horaires.value
                                            ? Colors.green
                                            : null,
                                    child: Text(
                                      "${trj.heureDepart}",
                                      style: smallTitle.copyWith(
                                          fontSize: 10, color: Colors.black),
                                    ),
                                  ),
                                  title: Text(
                                      "${trj.heureDepart} -> ${trj.nombrePlace} "),
                                  subtitle: Text("${trj.jourDeDisponibilite}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                child: Column(
                  children: [Text("Veuillez selectionner un trajet")],
                ),
              ),
      );
    }

    PanelRightScreen() {
      return Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          color: screenToShow.value != null?Colors.white:null,
          child: Obx(() {
            if (screenToShow.value == "addTrajet") {
              return showAddTrajet();
            } else if (screenToShow.value == "addHoraire") {
              return showAddDeparture();
            } else if (selected_horaires.value != 0 &&
                selected_trajet.value != 0) {
              return showModifyDeparture();
            } else {
              return SizedBox();
            }
          })
          // child: screenToShow.value== "addTrajet" ? showAddTrajet() : screenToShow.value=="addHoraire"? showAddDeparture(): selected_horaires.value != 0 && selected_trajet.value != 0? showModifyDeparture():null
          ));
    }

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
              Expanded(child: DrawerScreen()),
              Expanded(child: PanelLeftScreen()),
              Expanded(child: PanelCenterScreen()),
              Expanded(child: PanelRightScreen())
            ],
          ),
        ));
  }
}
