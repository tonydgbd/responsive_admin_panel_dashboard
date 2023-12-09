import 'dart:ffi';
import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/data_controller.dart';
import 'package:responsive_admin_panel_dashboard/controllers/screenscontroller.dart';
import 'package:responsive_admin_panel_dashboard/models/stock_ticket.dart';
import 'package:responsive_admin_panel_dashboard/screen/drawer_screen.dart';
import 'package:responsive_admin_panel_dashboard/utils/contants/textstyles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widget/responsive_layout.dart';

class BookingScreen extends StatelessWidget {
  RxInt selected_horaires = 0.obs;
  RxInt selected_trajet = 1.obs;
  BookingScreen({super.key});
  RxString selected_day =
      DateTime.now().toString()
          .obs;
  RxList<String> selected_places = <String>[].obs;
  String? selectedValue;
  DatePickerController datePickerController =DatePickerController();
  RxBool isloading = false.obs;
  RxBool showCustomerdetails = false.obs;
  RxList<DateTime> inactiveDates = <DateTime>[].obs;
  RxList<DateTime> activeDates = <DateTime>[].obs;
  StockTicket stock = StockTicket(
      id: "",
      userCreated: AuthController.instance.user.value!.id!,
      dateCreated: DateTime.now(),
      dateUpdated: DateTime.now(),
      horaires: 0,
      stockRestants: 0,
      stockInitial: 0,
      dateValidity: DateTime.now(),
      takenPlaces: {});

  bool checkifDayisInListOfDepartureDays(
    //Fonction retur true si le jour est dans la liste des jours autoriser pour les depart
      DateTime date, List<String> prohibitedDays) {
    var datewithindex = {
      "lundi": 1,
      "mardi": 2,
      "mercredi": 3,
      "jeudi": 4,
      "vendredi": 5,
      "samedi": 6,
      "dimanche": 7,
    };
    for (var element in prohibitedDays) {
      if (datewithindex[element.toLowerCase()] == date.weekday) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ever(selected_trajet, (callback) {
      if (DataController.instance.trajets
          .firstWhere((element) => element.id == selected_trajet.value)
          .horaires!
          .isNotEmpty) {
        selected_horaires.value = DataController.instance.trajets
            .firstWhere((element) => element.id == selected_trajet.value)
            .horaires!
            .first
            .id;
        selected_horaires.refresh();
        selected_places.clear();
        activeDates.clear();
        activeDates.refresh();


        print(selected_horaires.value);
      }
    });
    ever(selected_horaires, (callback) {
      if (selected_horaires.value != 0) {
        selected_places.clear();
        activeDates.clear();
        inactiveDates.clear();
        print(selected_horaires.value);
        for (int i = 0; i < 15; i++) {
          DateTime date = DateTime.now().add(Duration(days: i));
          var days = (DataController.instance.trajets
                  .firstWhere((element) => element.id == selected_trajet.value)
                  .horaires!
                  .firstWhere(
                      (element) => element.id == selected_horaires.value)
                  .jourDeDisponibilite);
          if (checkifDayisInListOfDepartureDays(date,days)) {
            activeDates.add(date);
          }else{
            inactiveDates.add(date);
            
          }
          
        }
        activeDates.refresh();
        inactiveDates.refresh();

        // selected_day.value =activeDates.first.toString();
        if(activeDates.isNotEmpty){
              datePickerController.setDateAndAnimate(activeDates.first);

        }
        isloading.value = true;
      }
    });
    PanelLeftScreen() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.white),
        height: Get.height,
        child: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  Text(
                    "Selectionner la destination",
                    style: mediumTitle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...DataController.instance.trajets
                      .where((p0) => p0.horaires!.isNotEmpty)
                      .map((e) => Obx(() => RadioListTile(
                            value: e.id,
                            groupValue: selected_trajet.value,
                            onChanged: (v) {
                              selected_trajet.value = e.id;
                              selected_horaires.value = 0;
                              // selected_horaires.value = DataController
                              //     .instance.trajets
                              //     .elementAt(e.id)
                              //     .horaires!
                              //     .first
                              //     .id!;
                            },
                            title: Text(e.villeArrive.toUpperCase()),
                          )))
                ],
              )),
        ),
      );
    }

    PanelCenterScreen() {
      return Obx(() => DataController.instance.trajets
              .firstWhere((element) => element.id == selected_trajet.value)
              .horaires!
              .isNotEmpty
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              height: Get.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[200],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Selectionner l'heure de depart",
                      style: mediumTitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...DataController.instance.trajets
                        .firstWhere(
                            (element) => element.id == selected_trajet.value)
                        .horaires!
                        .map((e) => Obx(() => RadioListTile(
                              value: e.id,
                              groupValue: selected_horaires.value,
                              onChanged: (v) {
                                selected_horaires.value = e.id;
                                
                              },
                              title: Text(e.heureDepart.toUpperCase()),
                            )))
                  ],
                ),
              ),
            )
          : SizedBox());
    }

    PanelRightScreen() {
      return Obx(() => selected_horaires.value != 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Text("Selectionner les places a reserver",
                      style: mediumTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Selectionner la Date", style: mediumTitle),
                  SizedBox(
                    width: Get.width * 0.25,
                    height: 85,
                    child: Obx(() => DatePicker(
                      
                          DateTime.now(),
                          // activeDates: activeDates.value,
                          inactiveDates: inactiveDates.value,
                          deactivatedColor: Colors.red,
                          controller: datePickerController,
                          initialSelectedDate: DateTime.parse(selected_day.value) ,
                          selectionColor: Colors.black,
                          selectedTextColor: Colors.white,
                          daysCount: 30,
                          onDateChange: (date) {
                            // New date selected
                            selected_day.value = date.toString();
                            print(selected_day);
                            selected_places.clear();
                            selected_day.refresh();
                            isloading.value = true;
                          },
                          height: 80,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      // width: Get.width * 0.4,
                      height: Get.height * 0.50,
                      child: Obx(() => StreamBuilder(
                          stream: Supabase.instance.client
                              .from('stock_tickets')
                              .stream(primaryKey: ['id']).eq(
                                  "date_validity", selected_day.value),
                          builder: (context, snapshot) {
                            print("new data in " + snapshot.data.toString());
                            if (snapshot.hasData && snapshot.data != null) {
                              print("new data out " + snapshot.data.toString());

                              isloading.value = false;
                              // if(snapshot.data!.contains((element) => element['horaires'] == selected_horaires.value) == false){
                              //  Supabase.instance.client.from('stock_tickets').insert([{
                              //     "date_validity": selected_day.value,
                              //     "horaires": selected_horaires.value,
                              //     "stock_initial": DataController.instance.trajets.firstWhere((element) => element.id == selected_trajet.value).horaires!.firstWhere((element) => element.id== selected_horaires.value).nombrePlace,
                              //     "stock_restant": DataController.instance.trajets.firstWhere((element) => element.id == selected_trajet.value).horaires!.firstWhere((element) => element.id== selected_horaires.value).nombrePlace,
                              //     "taken_places": {}
                              //   }]).select();
                              //   return Center(child: Column(
                              //     children: [
                              //       CircularProgressIndicator(),
                              //       Text("Aucun stock disponible pour cette date"),
                              //     ],
                              //   ));
                              // }
                              print(
                                  "selected horaire ${selected_horaires.value}");
                              print(
                                  "Containe horaire == ${snapshot.data!.where((element) => element['horaires'] == selected_horaires.value).isNotEmpty}");
                              stock = snapshot.data!
                                      .where((element) =>
                                          element['horaires'] ==
                                          selected_horaires.value)
                                      .isEmpty
                                  ? StockTicket(
                                      id: "",
                                      userCreated: AuthController
                                          .instance.user.value!.id!,
                                      dateCreated: DateTime.now(),
                                      dateUpdated: DateTime.now(),
                                      horaires: selected_horaires.value,
                                      stockRestants: DataController.instance.trajets
                                          .firstWhere((element) =>
                                              element.id ==
                                              selected_trajet.value)
                                          .horaires!
                                          .firstWhere((element) =>
                                              element.id ==
                                              selected_horaires.value)
                                          .nombrePlace,
                                      stockInitial: DataController.instance.trajets
                                          .firstWhere((element) =>
                                              element.id ==
                                              selected_trajet.value)
                                          .horaires!
                                          .firstWhere((element) =>
                                              element.id == selected_horaires.value)
                                          .nombrePlace,
                                      dateValidity: DateTime.parse(selected_day.value),
                                      takenPlaces: {})
                                  : StockTicket.fromJson(snapshot.data!.firstWhere((element) => element['horaires'] == selected_horaires.value));
                              print("Stock id ${stock.id}");
                              return GridView.builder(
                                  itemCount: stock.stockInitial,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5),
                                  itemBuilder: (ctx, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (selected_places
                                            .contains(index.toString())) {
                                          selected_places
                                              .remove(index.toString());
                                        } else if (stock.takenPlaces[
                                                    index.toString()] ==
                                                PlaceState.free.index ||
                                            stock.takenPlaces.containsKey(
                                                    index.toString()) ==
                                                false) {
                                          selected_places.add(index.toString());
                                        }
                                      },
                                      child: Card(
                                        elevation: 5,
                                        child: Obx(() => Container(
                                              width: selected_places.contains(
                                                      index.toString())
                                                  ? 25
                                                  : 20,
                                              padding: EdgeInsets.all(2),
                                              height: selected_places
                                                      .contains(index)
                                                  ? 30
                                                  : 25,
                                              decoration: BoxDecoration(
                                                  color: selected_places.contains(
                                                          index.toString())
                                                      ? Colors.blue
                                                      : stock.takenPlaces.containsKey(index
                                                                      .toString()) ==
                                                                  false ||
                                                              stock.takenPlaces[index
                                                                      .toString()] ==
                                                                  PlaceState
                                                                      .free
                                                                      .index
                                                          ? Colors.green
                                                          : PlaceColor[
                                                              stock.takenPlaces[index
                                                                  .toString()]!],
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.person),
                                                  Text(
                                                    "Place ${index + 1}",
                                                    style: mediumTitle,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  });
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }))),
                  Container(
                    height: 50,
                    width: Get.width * 0.4,
                    child: Row(
                      children: [
                        ...selected_places.map((element) => Chip(
                                label: Text(
                              element,
                              style: mediumTitle.copyWith(color: Colors.white),
                            )))
                      ],
                    ),
                  ),
                  selected_places.isNotEmpty
                      ? Center(
                          child: CupertinoButton(
                              child: Text(
                                "Passez a l'achat",
                                style:
                                    mediumTitle.copyWith(color: Colors.white),
                              ),
                              color: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              onPressed: () async {
                                if (false) {
                                  showCustomerdetails.value = true;
                                } else {
                                  //case confirmed registration
                                  print("for up" + stock.toJson().toString());
                                  if (stock.stockInitial != 0) {
                                    EasyLoading.show();
                                    stock.stockRestants = stock.stockRestants -
                                        selected_places.length;
                                    for (var element in selected_places) {
                                      stock.takenPlaces[element] =
                                          PlaceState.confirmed.index;
                                    }
                                    var dt = await Supabase.instance.client
                                        .from("stock_tickets")
                                        .upsert(stock.toJson())
                                        .select();
                                    print("upsert rs " + dt.toString());
                                    selected_places.clear();
                                    EasyLoading.dismiss();
                                  } else {
                                    EasyLoading.showError(
                                        "Aucune place disponible");
                                  }
                                }
                              }),
                        )
                      : SizedBox()
                ],
              ),
            )
          : SizedBox());
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
              SizedBox(width: Get.width * 0.2, child: DrawerScreen()),
              SizedBox(width: Get.width * 0.2, child: PanelLeftScreen()),
              SizedBox(width: Get.width * 0.2, child: PanelCenterScreen()),
              Expanded(child: PanelRightScreen())
            ],
          ),
        ));
  }
}
