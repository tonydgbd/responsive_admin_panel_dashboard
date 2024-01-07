import 'package:directus/directus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';
import 'package:responsive_admin_panel_dashboard/models/compagny.dart';
import 'package:responsive_admin_panel_dashboard/models/gare.dart';
import 'package:responsive_admin_panel_dashboard/models/horaire.dart';
import 'package:responsive_admin_panel_dashboard/models/stock_ticket.dart';
import 'package:responsive_admin_panel_dashboard/models/ticket.dart';
import 'package:responsive_admin_panel_dashboard/models/trajet.dart';
import 'package:responsive_admin_panel_dashboard/models/user.dart' as user;
import 'package:supabase_flutter/supabase_flutter.dart';
class DataController extends GetxController{
  static DataController instance = Get.find();
  static DirectusCore sdk = DirectusCoreSingleton.instance;
  Rx<Compagnie?> compagnie= null.obs;
  RxList<Gare> gares= <Gare>[].obs;
  RxList<Trajet> trajets = <Trajet>[].obs;
  RxList<String> villes = <String>[].obs;
  Rx<StockTicket> stock = StockTicket(id: '0', userCreated: '', dateCreated: DateTime.now(), dateUpdated: DateTime.now(), horaires: 0, stockRestants: 50, stockInitial: 50, dateValidity: DateTime.now(), takenPlaces: {}).obs ;
  RxList<Ticket> tickets = <Ticket>[].obs;
  RxList<DirectusUser> SoftawresUser = <DirectusUser>[].obs;
  RxList<user.User> client = <user.User>[].obs;
  @override
  DataController(){
    print("DataController");
  }

  get firstNameController => null;
refreshUI(){
  // getCompany();
  // getStocket();
}

  Future getGares() async {
    try {
       gares.clear();
    // var response = await sdk.items('gares').readMany();
    var response = await Supabase.instance.client.from('gares').select('*');
    var soft = await DirectusCoreSingleton.instance.users.readMany(filters: Filters({
    'company': F.eq(compagnie.value!.id)
  }),);
  SoftawresUser.clear();
  soft.data.forEach((element) {
    SoftawresUser.add(element);
  });
  print(SoftawresUser);
    response.forEach((element) {
      print(element);
      gares.add(Gare.fromJson(element));
    });
    
    print(response);
    } catch (e) {
      print((e as DirectusError).message);
    }
   
  }
   
   addTrajet(Trajet tjr)async{
  //  var res = await sdk.items("trajets").createOne(tjr.toJson());
  var res = await Supabase.instance.client.from('trajets').insert(tjr.toJson()).select('*');
   print(res);
   trajets.add(Trajet.fromJson(res.first));
   EasyLoading.showSuccess("Trajet ajouté avec success");
   }
   Stream<List<Map<String, dynamic>>> getStocket(int id_horaire){
    //  Supabase.instance.client.from('stock_tickets').select('*').eq('horaire', 1);
      return Supabase.instance.client.from('stock_tickets').stream(primaryKey: ['id']).eq('horaires', id_horaire).asBroadcastStream();

   }
   getTrajet() async {
    try {
      
      trajets.clear();
      // var response = await sdk.items('trajets').readMany(query: Query(fields: ['*','horaires.*']));
      var response = await Supabase.instance.client.from('trajets').select("* , horaires(*)").eq('gare_de_depart', AuthController.instance.user.value!.gareId!);
    response.forEach((element) {
      trajets.add(Trajet.fromJson(element));
    });
    // trajets.retainWhere((element) => element.gareDeDepart == AuthController.instance.user.value!.gareId);
    // var rs = await sdk.items("settings").readOne('1');
    var rs = await Supabase.instance.client.from('settings').select('*').eq('id', 1);
    await getTicketS();
    villes.clear();
    for (var el in (rs[0]['villes_disponible']as List)) {
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
    // var response = await sdk.items('companies').readOne(AuthController.instance.user!.value!.companyId!.toString(),);
    var response = await Supabase.instance.client.from('companies').select('*').eq('id', AuthController.instance.user.value!.companyId!);
    print(response);
    getGares();
    getTrajet();
     compagnie = Compagnie.fromJson(response[0]).obs;
    print(compagnie.value!.name);
  }
  updateHoraire(Horaire horaire)async{
  //  var res = await sdk.items('horaires').updateOne(data: horaire.tojson(), id: horaire.id.toString());
  var res = await Supabase.instance.client.from('horaires').update(horaire.tojson()).eq('id', horaire.id).select('*');
  EasyLoading.showSuccess("Horaire modifié avec success");
   getTrajet();
   print(res);
  }
  addHoraire(Horaire horaire)async{
  //  var res = await sdk.items('horaires').createOne( horaire.tojson(),);
  var res = await Supabase.instance.client.from('horaires').insert(horaire.tojson()).select('*');
   getTrajet();
   EasyLoading.showSuccess("Horaire ajouté avec success");
  }

  Future getTicketS()  async{
  try {
      var data = await Supabase.instance.client.from("tickets").select("* , trajets(*,gares(*,companies(*)))").inFilter("trajet_id", trajets.map((e) => e.id).toList());
  for(var element in data){
    tickets.add(Ticket.fromJson(element));
    // print(element);
  }
  tickets.refresh();
  } catch (e) {
    print(e);
  }

}


}