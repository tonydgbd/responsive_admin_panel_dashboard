

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/models/compagny.dart';
import 'package:responsive_admin_panel_dashboard/models/gare.dart';
import 'package:responsive_admin_panel_dashboard/models/horaire.dart';
import 'package:responsive_admin_panel_dashboard/models/stock_ticket.dart';
import 'package:responsive_admin_panel_dashboard/models/trajet.dart';
import 'package:responsive_admin_panel_dashboard/models/user.dart';
import 'package:responsive_admin_panel_dashboard/utils/loader.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
class DataController extends GetxController{
  static DataController instance = Get.find();
  static DirectusCore sdk = DirectusCoreSingleton.instance;
  Rx<Compagnie?> compagnie= null.obs;
  RxList<Gare> gares= <Gare>[].obs;
  RxList<Trajet> trajets = <Trajet>[].obs;
  RxList<String> villes = <String>[].obs;
  Rx<StockTicket> stock = StockTicket(id: '0', userCreated: '', dateCreated: DateTime.now(), dateUpdated: DateTime.now(), horaires: 0, stockRestants: 50, stockInitial: 50, dateValidity: DateTime.now(), takenPlaces: {}).obs ;
  @override
  DataController(){
    print("DataController");
  }
refreshUI(){
  // getCompany();
  // getStocket();
}

  getGares() async {
    gares.clear();
    var response = await sdk.items('gares').readMany();
    response.data.forEach((element) {
      print(element);
      gares.add(Gare.fromJson(element));
    });
    
    print(response.data);
  }
   
   addTrajet(Trajet tjr)async{
   var res = await sdk.items("trajets").createOne(tjr.toJson());
   print(res.data);
   trajets.add(Trajet.fromJson(res.data));
   }
   Stream<List<Map<String, dynamic>>> getStocket(int id_horaire){
    //  Supabase.instance.client.from('stock_tickets').select('*').eq('horaire', 1);
      return Supabase.instance.client.from('stock_tickets').stream(primaryKey: ['id']).eq('horaires', id_horaire).asBroadcastStream();

   }
   getTrajet() async {
    try {
      
      trajets.clear();
      var response = await sdk.items('trajets').readMany(query: Query(fields: ['*','horaires.*']));
    response.data.forEach((element) {
      trajets.add(Trajet.fromJson(element));
    });
    trajets.retainWhere((element) => element.gareDeDepart == AuthController.instance.user.value!.gareId);
    var rs = await sdk.items("settings").readOne('1');
    villes.clear();
    for (var el in (rs.data['villes_disponible']as List)) {
      villes.add(el);
    }
    print(villes.value);
    } catch (e) {
      print(e);
    }
    
   }
  getCompany() async {
    if(AuthController.instance.user.value == null){
      return;
    }
    var response = await sdk.items('companies').readOne(AuthController.instance.user!.value!.companyId!.toString(),);
    print(response.data);
    getGares();
    getTrajet();
     compagnie = Compagnie.fromJson(response.data).obs;
    print(compagnie.value!.name);
  }
  updateHoraire(Horaire horaire)async{
   var res = await sdk.items('horaires').updateOne(data: horaire.tojson(), id: horaire.id.toString());
   getTrajet();
   print(res.data);
  }
  addHoraire(Horaire horaire)async{
   var res = await sdk.items('horaires').createOne( horaire.tojson(),);
   getTrajet();
  }

}