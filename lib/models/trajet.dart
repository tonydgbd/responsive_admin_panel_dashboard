import 'package:responsive_admin_panel_dashboard/models/horaire.dart';

class Trajet {
  final int id;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdated;
  final DateTime dateUpdated;

  final int prix;
  final int gareDeDepart;
  final String villeDepart;
  final String villeArrive;
  final List<Horaire>? horaires;

  const Trajet({
    required this.id,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,

    required this.prix,
    required this.gareDeDepart,
    required this.villeDepart,
    required this.villeArrive,
    required this.horaires,
  });

  factory Trajet.fromJson(Map<String, dynamic> json) {
    return Trajet(
      id: json['id'] as int,
      userCreated: json['user_created'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      userUpdated: json['user_updated'] as String,
      dateUpdated: DateTime.parse(json['date_updated'] as String),
      prix: json['prix'] as int,
      gareDeDepart: json['gare_de_depart'] as int,
      villeDepart: json['ville_depart'] as String,
      villeArrive: json['ville_arrive'] as String,
      horaires: json['horaires'] != null ? (json['horaires'] as List).map((e) => Horaire.fromJson(e)).toList() :null ,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    'user_created': userCreated,
    'date_created': dateCreated.toIso8601String(),
    'user_updated': userUpdated,
    'date_updated': dateUpdated.toIso8601String(),
    'prix': prix,
    'gare_de_depart': gareDeDepart,
    'ville_depart': villeDepart,
    'ville_arrive': villeArrive,
  };
}
}
