import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String userName;
  String email;
  String phone;
  String age;
  String gender;
  String ratings;
  String date;

  bool revisit;

  Client({
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.age,
    this.gender,
    this.ratings,
    this.date,
    this.revisit,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        gender: json["gender"],
        ratings: json["ratings"],
        date: json["date"],
        revisit: json["revisit"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userName": userName,
        "email": email,
        "phone": phone,
        "age": age,
        "gender": gender,
        "ratings": ratings,
        "date": date,
        "revisit": revisit,
      };
}
