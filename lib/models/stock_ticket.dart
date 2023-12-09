
  import 'dart:ui';

import 'package:flutter/material.dart';

enum PlaceState{
    free,
    inHold,
    confirmed,
    cancelled,
    refunded
  }
const List<Color>  PlaceColor =[
    Colors.green,
    Colors.yellow,
    Colors.grey,
    Colors.red,
    Colors.greenAccent,

];
class StockTicket {
  String id;
  String? userCreated;
  DateTime dateCreated;
  DateTime dateUpdated;
  int horaires;
  int stockRestants;
  int stockInitial;
  DateTime dateValidity;
  Map takenPlaces;

  // {
  //   'id_place': PlaceState.inHold.index
  // }

  StockTicket({
    required this.id,
    required this.userCreated,
    required this.dateCreated,
    required this.dateUpdated,
    required this.horaires,
    required this.stockRestants,
    required this.stockInitial,
    required this.dateValidity,
    required this.takenPlaces,
  });

  factory StockTicket.fromJson(Map<String, dynamic> json) {
    return StockTicket(
      id: json['id'],
      userCreated: json['user_created'],
      dateCreated: DateTime.parse(json['date_created']),
      dateUpdated: DateTime.parse(json['date_updated']),
      horaires: json['horaires'],
      stockRestants: json['stock_restants'],
      stockInitial: json['stock_initial'],
      dateValidity: DateTime.parse(json['date_validity']),
      takenPlaces: json['taken_places'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = {
      'user_created': userCreated,
      'date_created': dateCreated.toIso8601String(),
      'date_updated': dateUpdated.toIso8601String(),
      'horaires': horaires,
      'stock_restants': stockRestants,
      'stock_initial': stockInitial,
      'date_validity': dateValidity.toIso8601String(),
      'taken_places': takenPlaces,
    };
    if (id != '') {
      data['id'] = id;
    }
    return data;
  }
}