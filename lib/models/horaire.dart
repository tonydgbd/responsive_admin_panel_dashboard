import 'package:responsive_admin_panel_dashboard/controllers/auth_controller.dart';

class Horaire {
  final int id;
  final String? userCreated;
  final DateTime? dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String heureDepart;
    final int nombrePlace;
  final List<String> jourDeDisponibilite;
  final int trajet_id;

  const Horaire({
    required this.id,
    required this.trajet_id,
    required this.nombrePlace,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,
    required this.heureDepart,
    required this.jourDeDisponibilite,
  });

  factory Horaire.fromJson(Map<String, dynamic> json) {
    return Horaire(
      id: json['id'] as int,
      trajet_id:json['trajet_id'] as int,
      nombrePlace: json['nombre_place'] as int,
      userCreated: json['user_created'] ,
      dateCreated: json['date_created'] !=null ? DateTime.parse(json['date_created'] as String) : null,
      userUpdated: json['user_updated'] as String? ?? null,
      dateUpdated: json['date_updated'] !=null? DateTime.parse(json['date_updated'] as String) : null,
      heureDepart: json['heure_depart'] as String,
      jourDeDisponibilite: (json['jour_de_disponibilite'] as List<dynamic>)
          .map((dynamic day) => day as String)
          .toList(),
    );
  }
  tojson(){
    return {
      "trajet_id":trajet_id,
      "user_created": AuthController.instance.user.value!.id,
      "nombre_place":nombrePlace,
      "user_updated":userUpdated,
      "date_updated":dateUpdated.toString(),
      "heure_depart":heureDepart,
      "jour_de_disponibilite": jourDeDisponibilite
  };
}
}