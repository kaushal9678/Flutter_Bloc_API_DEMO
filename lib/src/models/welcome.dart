
import 'dart:convert';
WelcomeScreenModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return WelcomeScreenModel.fromMap(jsonData);
}

String clientToJson(WelcomeScreenModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}


class WelcomeScreenModel {
  String title;
  Properties properties;


  WelcomeScreenModel({

    this.title,
    this.properties,
  });
  WelcomeScreenModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
  factory WelcomeScreenModel.fromMap(Map<String, dynamic> json) => new WelcomeScreenModel(
    title: json["title"],
    properties: json["properties"],


  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "properties": properties,


  };
}

Properties propertiesFromJson(String str) {
  final jsonData = json.decode(str);
  return Properties.fromMap(jsonData);
}

String propertiesToJson(Properties data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
class Properties {
  bool showButton;
  String description;
  String buttonText;

  Properties({
    this.showButton,
    this.description,
    this.buttonText,
  });
  Properties.fromJson(Map<String, dynamic> json) {
    showButton = json['show_button'];
    description = json['description'];
    buttonText = json['button_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_button'] = this.showButton;
    data['description'] = this.description;
    data['button_text'] = this.buttonText;
    return data;
  }

  factory Properties.fromMap(Map<String, dynamic> json) => new Properties(
    showButton: json["show_button"],
    description: json["description"],
    buttonText: json["button_text"],

  );

  Map<String, dynamic> toMap() => {
    "show_button": showButton,
    "description": description,
    "button_text":buttonText,

  };
}
