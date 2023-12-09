class Gare {
  final int id;
  final String status;
  final String? userCreated;
  final DateTime dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String ville;
  final String nom;
  final int company;

  const Gare({
    required this.id,
    required this.status,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,
    required this.ville,
    required this.nom,
    required this.company,
  });

  factory Gare.fromJson(Map<String, dynamic> json) {
    return Gare(
      id: json['id'] as int,
      status: json['status'] as String,
      userCreated: json['user_created'],
      dateCreated: json['date_created'].runtimeType == String? DateTime.parse(json['date_created'] as String):json['date_created'],
      userUpdated: json['user_updated'] as String? ?? null,
      dateUpdated:   json['date_updated'] !=null && json['date_updated'].runtimeType == String? DateTime.parse(json['date_updated'] as String):json['date_updated'],
      ville: json['ville'] as String,
      nom: json['nom'] as String,
      company: json['company'] as int,
    );
  }
}
