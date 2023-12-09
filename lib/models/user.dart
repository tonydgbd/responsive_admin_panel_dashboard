
class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? location;
  final String? title;
  final String? description;
  final String? tags;
  final String? avatar;
  final String? language;
  final String? tfaSecret;
  final String? status;
  final String? roleId;
  final String? token;
  final String? lastPage;
  final String provider;
  final String? externalIdentifier;
  final String? authData;
  final bool emailNotifications;
  final String? appearance;
  final int? companyId;
  final int? gareId;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.language,
    this.tfaSecret,
    required this.status,
    required this.roleId,
    this.token,
   this.lastPage,
    required this.provider,
    this.externalIdentifier,
    this.authData,
    required this.emailNotifications,
    this.appearance,
    required this.companyId,
    required this.gareId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ,
      firstName: json['first_name'] ,
      lastName: json['last_name'] ,
      email: json['email'] ,
      password: json['password'] ,
      location: json['location'] ,
      title: json['title'] ,
      description: json['description'],
      tags: json['tags'] ,
      avatar: json['avatar'] ,
      language: json['language'] ,
      tfaSecret: json['tfa_secret'] ,
      status: json['status'],
      roleId: json['role'],
      token: json['token'] ,
      lastPage: json['last_page'] ,
      provider: json['provider'],
      externalIdentifier: json['external_identifier'],
      authData: json['auth_data'] ,
      emailNotifications: json['email_notifications'],
      appearance: json['appearance'] ,
      companyId: json['company'],
      gareId: json['gare'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'company': companyId,
    'gare': gareId,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
    'location': location,
    'title': title,
    'description': description,
    'tags': tags,
    'avatar': avatar,
    'language': language,
    'tfa_secret': tfaSecret,
    'status': status,
    'role': roleId,
    'token': token,
    'last_page': lastPage,
    'provider': provider,
    'external_identifier': externalIdentifier,
    'auth_data': authData,
    'email_notifications': emailNotifications,
    'appearance': appearance,

  };
}

class Client {
  final int id;
  final String userCreated;
  final DateTime dateCreated;
  final String? userUpdated;
  final DateTime? dateUpdated;
  final String name;
  final String phoneNumber;
  final String fcmid;
  final int solde;
  final int ptsFidelity;

  const Client({
    required this.id,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,
    required this.name,
    required this.phoneNumber,
    required this.fcmid,
    required this.solde,
    required this.ptsFidelity,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] as int,
      userCreated: json['user_created'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
      userUpdated: json['user_updated'] as String? ?? null,
      dateUpdated: json['date_updated'] as DateTime? ?? null,
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      fcmid: json['fcmid'] as String,
      solde: json['solde'] as int,
      ptsFidelity: json['pts_fidelity'] as int,
    );
  }
}
