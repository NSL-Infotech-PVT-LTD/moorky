// To parse this JSON data, do
//
//     final emailSignUpModel = emailSignUpModelFromJson(jsonString);

import 'dart:convert';

EmailSignUpModel emailSignUpModelFromJson(String str) => EmailSignUpModel.fromJson(json.decode(str));

String emailSignUpModelToJson(EmailSignUpModel data) => json.encode(data.toJson());

class EmailSignUpModel {
  EmailSignUpModel({
    this.statusCode,
    this.message,
    this.alreadyRegister,
    this.data,
  });

  int? statusCode;
  String? message;
  bool? alreadyRegister;
  Data? data;

  factory EmailSignUpModel.fromJson(Map<String, dynamic> json) => EmailSignUpModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    alreadyRegister: json["already_register"] == null ? null : json["already_register"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "already_register": alreadyRegister == null ? null : alreadyRegister,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.gender,
    this.showGender,
    this.maritalStatus,
    this.lookingFor,
    this.biography,
    this.sexualOrientation,
    this.tallAreYou,
    this.school,
    this.jobTitle,
    this.companyName,
    this.doYouDrink,
    this.doYouSmoke,
    this.feelAboutKids,
    this.education,
    this.introvertOrExtrovert,
    this.starSign,
    this.havePets,
    this.religion,
    this.realPhoto,
    this.isPremium,
    this.address,
    this.latitude,
    this.longitude,
    this.liveStatus,
    this.liveAt,
    this.status,
    this.accessToken,
  });

  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  String? gender;
  bool? showGender;
  String? dateWith;
  String? maritalStatus;
  String? lookingFor;
  String? biography;
  String? sexualOrientation;
  String? tallAreYou;
  String? school;
  String? jobTitle;
  String? companyName;
  String? doYouDrink;
  String? doYouSmoke;
  String? feelAboutKids;
  String? education;
  String? introvertOrExtrovert;
  String? starSign;
  String? havePets;
  String? religion;
  String? realPhoto;
  bool? isPremium;
  String? address;
  String? latitude;
  String? longitude;
  bool? liveStatus;
  String? liveAt;
  bool? status;
  String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    gender: json["gender"] == null ? null : json["gender"],
    showGender: json["show_gender"] == null ? null : json["show_gender"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    lookingFor: json["looking_for"] == null ? null : json["looking_for"],
    biography: json["biography"] == null ? null : json["biography"],
    sexualOrientation: json["sexual_orientation"] == null ? null : json["sexual_orientation"],
    tallAreYou: json["tall_are_you"] == null ? null : json["tall_are_you"],
    school: json["school"] == null ? null : json["school"],
    jobTitle: json["job_title"] == null ? null : json["job_title"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    doYouDrink: json["do_you_drink"] == null ? null : json["do_you_drink"],
    doYouSmoke: json["do_you_smoke"] == null ? null : json["do_you_smoke"],
    feelAboutKids: json["feel_about_kids"] == null ? null : json["feel_about_kids"],
    education: json["education"] == null ? null : json["education"],
    introvertOrExtrovert: json["introvert_or_extrovert"] == null ? null : json["introvert_or_extrovert"],
    starSign: json["star_sign"] == null ? null : json["star_sign"],
    havePets: json["have_pets"] == null ? null : json["have_pets"],
    religion: json["religion"] == null ? null : json["religion"],
    realPhoto: json["real_photo"] == null ? null : json["real_photo"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    liveStatus: json["live_status"] == null ? null : json["live_status"],
    liveAt: json["live_at"] == null ? null : json["live_at"],
    status: json["status"] == null ? null : json["status"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_code": phoneCode == null ? null : phoneCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "gender": gender == null ? null : gender,
    "show_gender": showGender == null ? null : showGender,
    "date_with": dateWith == null ? null : dateWith,
    "marital_status": maritalStatus == null ? null : maritalStatus,
    "looking_for": lookingFor == null ? null : lookingFor,
    "biography": biography == null ? null : biography,
    "sexual_orientation": sexualOrientation == null ? null : sexualOrientation,
    "tall_are_you": tallAreYou == null ? null : tallAreYou,
    "school": school == null ? null : school,
    "job_title": jobTitle == null ? null : jobTitle,
    "company_name": companyName == null ? null : companyName,
    "do_you_drink": doYouDrink == null ? null : doYouDrink,
    "do_you_smoke": doYouSmoke == null ? null : doYouSmoke,
    "feel_about_kids": feelAboutKids == null ? null : feelAboutKids,
    "education": education == null ? null : education,
    "introvert_or_extrovert": introvertOrExtrovert == null ? null : introvertOrExtrovert,
    "star_sign": starSign == null ? null : starSign,
    "have_pets": havePets == null ? null : havePets,
    "religion": religion == null ? null : religion,
    "real_photo": realPhoto == null ? null : realPhoto,
    "is_premium": isPremium == null ? null : isPremium,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "live_status": liveStatus == null ? null : liveStatus,
    "live_at": liveAt == null ? null : liveAt,
    "status": status == null ? null : status,
    "access_token": accessToken == null ? null : accessToken
  };
}
