class FilterListModel {
  FilterListModel({
    this.statusCode,
    this.message,
    this.maritals,
    this.lookingFors,
    this.interests,
    this.sexualOrientations,
    this.drinkOptions,
    this.smokeOptions,
    this.feelAboutKids,
    this.educationLevels,
    this.introvertOrExtroverts,
    this.starSigns,
    this.havePets,
    this.religions,
    this.languages,
  });

  dynamic statusCode;
  dynamic message;
  List<DrinkOption>? maritals;
  List<DrinkOption>? lookingFors;
  List<DrinkOption>? interests;
  List<DrinkOption>? sexualOrientations;
  List<DrinkOption>? drinkOptions;
  List<DrinkOption>? smokeOptions;
  List<DrinkOption>? feelAboutKids;
  List<DrinkOption>? educationLevels;
  List<DrinkOption>? introvertOrExtroverts;
  List<DrinkOption>? starSigns;
  List<DrinkOption>? havePets;
  List<DrinkOption>? religions;
  List<Language>? languages;

  factory FilterListModel.fromJson(Map<String, dynamic> json) => FilterListModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    maritals: json["maritals"] == null ? null : List<DrinkOption>.from(json["maritals"].map((x) => DrinkOption.fromJson(x))),
    lookingFors: json["looking_fors"] == null ? null : List<DrinkOption>.from(json["looking_fors"].map((x) => DrinkOption.fromJson(x))),
    interests: json["interests"] == null ? null : List<DrinkOption>.from(json["interests"].map((x) => DrinkOption.fromJson(x))),
    sexualOrientations: json["sexual_orientations"] == null ? null : List<DrinkOption>.from(json["sexual_orientations"].map((x) => DrinkOption.fromJson(x))),
    drinkOptions: json["drink_options"] == null ? null : List<DrinkOption>.from(json["drink_options"].map((x) => DrinkOption.fromJson(x))),
    smokeOptions: json["smoke_options"] == null ? null : List<DrinkOption>.from(json["smoke_options"].map((x) => DrinkOption.fromJson(x))),
    feelAboutKids: json["feel_about_kids"] == null ? null : List<DrinkOption>.from(json["feel_about_kids"].map((x) => DrinkOption.fromJson(x))),
    educationLevels: json["education_levels"] == null ? null : List<DrinkOption>.from(json["education_levels"].map((x) => DrinkOption.fromJson(x))),
    introvertOrExtroverts: json["introvert_or_extroverts"] == null ? null : List<DrinkOption>.from(json["introvert_or_extroverts"].map((x) => DrinkOption.fromJson(x))),
    starSigns: json["star_signs"] == null ? null : List<DrinkOption>.from(json["star_signs"].map((x) => DrinkOption.fromJson(x))),
    havePets: json["have_pets"] == null ? null : List<DrinkOption>.from(json["have_pets"].map((x) => DrinkOption.fromJson(x))),
    religions: json["religions"] == null ? null : List<DrinkOption>.from(json["religions"].map((x) => DrinkOption.fromJson(x))),
    languages: json["languages"] == null ? null : List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "maritals": maritals == null ? null : List<dynamic>.from(maritals!.map((x) => x.toJson())),
    "looking_fors": lookingFors == null ? null : List<dynamic>.from(lookingFors!.map((x) => x.toJson())),
    "interests": interests == null ? null : List<dynamic>.from(interests!.map((x) => x.toJson())),
    "sexual_orientations": sexualOrientations == null ? null : List<dynamic>.from(sexualOrientations!.map((x) => x.toJson())),
    "drink_options": drinkOptions == null ? null : List<dynamic>.from(drinkOptions!.map((x) => x.toJson())),
    "smoke_options": smokeOptions == null ? null : List<dynamic>.from(smokeOptions!.map((x) => x.toJson())),
    "feel_about_kids": feelAboutKids == null ? null : List<dynamic>.from(feelAboutKids!.map((x) => x.toJson())),
    "education_levels": educationLevels == null ? null : List<dynamic>.from(educationLevels!.map((x) => x.toJson())),
    "introvert_or_extroverts": introvertOrExtroverts == null ? null : List<dynamic>.from(introvertOrExtroverts!.map((x) => x.toJson())),
    "star_signs": starSigns == null ? null : List<dynamic>.from(starSigns!.map((x) => x.toJson())),
    "have_pets": havePets == null ? null : List<dynamic>.from(havePets!.map((x) => x.toJson())),
    "religions": religions == null ? null : List<dynamic>.from(religions!.map((x) => x.toJson())),
    "languages": languages == null ? null : List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class DrinkOption {
  DrinkOption({
    this.id,
    this.icon,
    this.name,
    this.status,
    this.isSelected
  });

  dynamic id;
  dynamic icon;
  dynamic name;
  dynamic status;
  bool? isSelected=false;


  factory DrinkOption.fromJson(Map<String, dynamic> json) => DrinkOption(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
  };
}

class Language {
  Language({
    this.id,
    this.icon,
    this.languageCode,
    this.language,
    this.status,
    this.isSelected
  });

  dynamic id;
  dynamic icon;
  dynamic languageCode;
  dynamic language;
  dynamic status;
  bool? isSelected=false;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"],
    languageCode: json["language_code"] == null ? null : json["language_code"],
    language: json["language"] == null ? null : json["language"],
    status: json["status"] == null ? null : json["status"],
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon,
    "language_code": languageCode == null ? null : languageCode,
    "language": language == null ? null : language,
    "status": status == null ? null : status,
  };
}
