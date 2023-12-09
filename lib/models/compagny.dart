class Compagnie {
  final int id;
  final String status;
  final String? userCreated;
  final DateTime? dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String name;
  final String logo;
  final bool isInformatiser;
  final bool nomOfClientRequired;
  final bool ticketAutoConfirmation;
  final bool respectOfSeatNumbers;
  final int? nombreDeJourReservation;

  const Compagnie({
    required this.id,
    required this.status,
    required this.userCreated,
     this.dateCreated,
    required this.userUpdated,
     this.dateUpdated,
    required this.name,
    required this.logo,
    required this.isInformatiser,
    required this.nomOfClientRequired,
    required this.ticketAutoConfirmation,
    required this.respectOfSeatNumbers,
    required this.nombreDeJourReservation,
  });

  factory Compagnie.fromJson(Map<String, dynamic> json) {
    return Compagnie(
      id: json['id'] as int,
      status: json['status'] as String,
      userCreated: json['user_created'],
      // dateCreated: DateTime.parse(json['date_created'] as String),
      userUpdated: json['user_updated'] as String? ?? null,
      // dateUpdated: json['date_updated'] as DateTime? ?? null,
      name: json['name'] as String,
      logo: json['logo'] as String,
      isInformatiser: json['is_informatiser'] as bool,
      nomOfClientRequired: json['nom_of_client_required'] as bool,
      ticketAutoConfirmation: json['ticket_auto_confirmation'] as bool,
      respectOfSeatNumbers: json['respect_of_seat_numbers'] as bool,
      nombreDeJourReservation: json['nombre_de_jour_reservation'] as int? ?? null,
    );
  }
}
