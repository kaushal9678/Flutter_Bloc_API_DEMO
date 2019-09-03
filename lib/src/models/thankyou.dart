import 'dart:convert';

ThankyouScreenModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return ThankyouScreenModel.fromMap(jsonData);
}

String clientToJson(ThankyouScreenModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ThankyouScreenModel {
  String title;
  ThankyouScreenModelProperties properties;
  Attachment attachment;

  ThankyouScreenModel({
    this.title,
    this.properties,
    this.attachment,
  });
  ThankyouScreenModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    properties = json['properties'] != null
        ? new ThankyouScreenModelProperties.fromJson(json['properties'])
        : null;
    attachment = json['attachment'] != null
        ? new Attachment.fromJson(json['attachment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    if (this.attachment != null) {
      data['attachment'] = this.attachment.toJson();
    }
    return data;
  }

  factory ThankyouScreenModel.fromMap(Map<String, dynamic> json) =>
      new ThankyouScreenModel(
        title: json["title"],
        properties: json["properties"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "properties": properties,
        "attachment": attachment,
      };
}

Attachment attachmentFromJson(String str) {
  final jsonData = json.decode(str);
  return Attachment.fromMap(jsonData);
}

String attachmentToJson(Attachment data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Attachment {
  String type;
  String href;

  Attachment({
    this.type,
    this.href,
  });
  Attachment.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['href'] = this.href;
    return data;
  }

  factory Attachment.fromMap(Map<String, dynamic> json) => new Attachment(
        type: json["type"],
        href: json["href"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "href": href,
      };
}

ThankyouScreenModelProperties thankPropFromJson(String str) {
  final jsonData = json.decode(str);
  return ThankyouScreenModelProperties.fromMap(jsonData);
}

String thankPropToJson(ThankyouScreenModelProperties data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ThankyouScreenModelProperties {
  bool showButton;
  bool shareIcons;
  String buttonMode;
  String buttonText;

  ThankyouScreenModelProperties({
    this.showButton,
    this.shareIcons,
    this.buttonMode,
    this.buttonText,
  });
  ThankyouScreenModelProperties.fromJson(Map<String, dynamic> json) {
    showButton = json['show_button'];
    shareIcons = json['share_icons'];
    buttonMode = json['button_mode'];
    buttonText = json['button_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_button'] = this.showButton;
    data['share_icons'] = this.shareIcons;
    data['button_mode'] = this.buttonMode;
    data['button_text'] = this.buttonText;
    return data;
  }

  factory ThankyouScreenModelProperties.fromMap(Map<String, dynamic> json) =>
      new ThankyouScreenModelProperties(
        showButton: json["showButton"],
        shareIcons: json["shareIcons"],
        buttonMode: json["buttonMode"],
        buttonText: json["buttonText"],
      );

  Map<String, dynamic> toMap() => {
        "showButton": showButton,
        "shareIcons": shareIcons,
        "buttonMode": buttonMode,
        "buttonText": buttonText,
      };
}
