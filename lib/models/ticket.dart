


import 'trajet.dart';

class Ticket {
  final int id;
  final dynamic userCreated;
  final DateTime dateCreated;
  final dynamic userUpdated;
  final DateTime? dateUpdated;
  final int? userId;
  final String stockId;
  final int placeNumber;
  final int trajetId;
  final int prix;
  final Map<String, dynamic>? data;
  final DateTime dateDepart;
  final String heureDepart;

  Ticket({
    required this.id,
    this.userCreated,
    required this.dateCreated,
    this.userUpdated,
    this.dateUpdated,
    this.userId,
    required this.stockId,
    required this.placeNumber,
    required this.trajetId,
    required this.prix,
    this.data,
    required this.dateDepart,
    required this.heureDepart,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as int,
      userCreated: json['user_created'],
      dateCreated: DateTime.parse(json['date_created']),
      userUpdated: json['user_updated'],
      dateUpdated: json['date_updated'] != null
          ? DateTime.parse(json['date_updated'])
          : null,
      userId: json['user_id'] as int,
      stockId: json['stock_id'] as String,
      placeNumber: json['place_number'] as int,
      trajetId: json['trajet_id'],
      prix: json['prix'] ,
      data: json['data'] as Map<String, dynamic>,
      dateDepart: DateTime.parse(json['date_depart']),
      heureDepart: json['Heure_depart'] as String,
    );
  }
  
  toJson() {
    return {
      // 'id': id !=0 ? id : null,
      'user_created': userCreated,
      'date_created': dateCreated.toIso8601String(),
      'user_updated': userUpdated,
      'date_updated': dateUpdated?.toIso8601String(),
      'user_id': userId,
      'stock_id': stockId,
      'place_number': placeNumber,
      'trajet_id': trajetId,
      'prix': prix,
      'data': data,
      'date_depart': dateDepart.toIso8601String(),
      'Heure_depart': heureDepart,
    };
  }
}

