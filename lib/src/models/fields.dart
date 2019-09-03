class Field {
  String id;
  String title;
  Validations validations;
  String type;
  FieldProperties properties;

  Field({
    this.id,
    this.title,
    this.validations,
    this.type,
    this.properties,
  });
  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    validations = json['validations'] != null
        ? new Validations.fromJson(json['validations'])
        : null;
    type = json['type'];
    properties = json['properties'] != null
        ? new FieldProperties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.validations != null) {
      data['validations'] = this.validations.toJson();
    }
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class FieldProperties {
  bool alphabeticalOrder;
  List<Choice> choices;
  int steps;
  String shape;
  String structure;
  String separator;

  FieldProperties({
    this.alphabeticalOrder,
    this.choices,
    this.steps,
    this.shape,
    this.structure,
    this.separator,
  });
  FieldProperties.fromJson(Map<String, dynamic> json) {
    alphabeticalOrder = json['alphabetical_order'];
    if (json['choices'] != null) {
      choices = new List<Choice>();
      json['choices'].forEach((v) {
        choices.add(new Choice.fromJson(v));
      });
    }
    steps = json['steps'];
    shape = json['shape'];
    structure = json['structure'];
    separator = json['separator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alphabetical_order'] = this.alphabeticalOrder;
    if (this.choices != null) {
      data['choices'] = this.choices.map((v) => v.toJson()).toList();
    }
    data['steps'] = this.steps;
    data['shape'] = this.shape;
    data['structure'] = this.structure;
    data['separator'] = this.separator;
    return data;
  }
}

class Choice {
  String label;

  Choice({
    this.label,
  });
  Choice.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    return data;
  }
}

class Validations {
  bool required;

  Validations({
    this.required,
  });
  Validations.fromJson(Map<String, dynamic> json) {
    required = json['required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['required'] = this.required;
    return data;
  }
}
