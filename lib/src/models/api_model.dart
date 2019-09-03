import './settings.dart';
import './welcome.dart';
import './thankyou.dart';
import './fields.dart';
import 'dart:convert';

APIModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return APIModel.fromMap(jsonData);
}

String clientToJson(APIModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class APIModel {
  String id;
  String title;
  Settings settings;
  List<WelcomeScreenModel> welcomeScreens;
  List<ThankyouScreenModel> thankyouScreens;
  List<Field> fields;

  APIModel(
      {this.id,
      this.title,
      this.settings,
      this.welcomeScreens,
      this.thankyouScreens,
      this.fields});

  factory APIModel.fromMap(Map<String, dynamic> json) => new APIModel(
        id: json["id"],
        title: json["title"],
        settings: json["settings"],
        welcomeScreens: json["welcomeScreens"],
        thankyouScreens: json["thankyouScreens"],
        fields: json["fields"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "settings": settings,
        "welcomeScreens": welcomeScreens,
        "thankyouScreens": thankyouScreens,
        "fields": fields,
      };

  APIModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    if (json['welcome_screens'] != null) {
      welcomeScreens = new List<WelcomeScreenModel>();
      json['welcome_screens'].forEach((v) {
        welcomeScreens.add(new WelcomeScreenModel.fromJson(v));
      });
    }
    if (json['thankyou_screens'] != null) {
      thankyouScreens = new List<ThankyouScreenModel>();
      json['thankyou_screens'].forEach((v) {
        thankyouScreens.add(new ThankyouScreenModel.fromJson(v));
      });
    }
    if (json['fields'] != null) {
      fields = new List<Field>();
      json['fields'].forEach((v) {
        fields.add(new Field.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    if (this.welcomeScreens != null) {
      data['welcome_screens'] =
          this.welcomeScreens.map((v) => v.toJson()).toList();
    }
    if (this.thankyouScreens != null) {
      data['thankyou_screens'] =
          this.thankyouScreens.map((v) => v.toJson()).toList();
    }
    if (this.fields != null) {
      data['fields'] = this.fields.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
