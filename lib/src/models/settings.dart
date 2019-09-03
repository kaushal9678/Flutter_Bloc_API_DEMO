import 'dart:convert';

Settings settingsFromJson(String str) {
  final jsonData = json.decode(str);
  return Settings.fromMap(jsonData);
}

String settingsToJson(Settings data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Settings {
  String language;
  String progressBar;
  bool showProgressBar;

  Settings({
    this.language,
    this.progressBar,
    this.showProgressBar,
  });
  Settings.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    progressBar = json['progress_bar'];
    showProgressBar = json['show_progress_bar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['progress_bar'] = this.progressBar;
    data['show_progress_bar'] = this.showProgressBar;
    return data;
  }

  factory Settings.fromMap(Map<String, dynamic> json) => new Settings(
        language: json["language"],
        progressBar: json["progressBar"],
        showProgressBar: json["showProgressBar"],
      );

  Map<String, dynamic> toMap() => {
        "language": language,
        "progressBar": progressBar,
        "showProgressBar": showProgressBar,
      };
}
