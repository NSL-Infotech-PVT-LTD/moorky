// To parse this JSON data, do
//
//     final signupverifymodel = signupverifymodelFromJson(jsonString);

import 'dart:convert';

Signupverifymodel signupverifymodelFromJson(String str) => Signupverifymodel.fromJson(json.decode(str));

String signupverifymodelToJson(Signupverifymodel data) => json.encode(data.toJson());

class Signupverifymodel {
  Signupverifymodel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory Signupverifymodel.fromJson(Map<String, dynamic> json) => Signupverifymodel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneCode,
    this.phoneNumber,
    this.phoneVerifiedAt,
    this.dateOfBirth,
    this.gender,
    this.showGender,
    this.dateWith,
    this.maritalStatus,
    this.lookingFor,
    this.biography,
    this.sexualOrientation,
    this.tallAreYou,
    this.school,
    this.jobTitle,
    this.doYouDrink,
    this.doYouSmoke,
    this.feelAboutKids,
    this.education,
    this.introvertOrExtrovert,
    this.starSign,
    this.havePets,
    this.religion,
    this.address,
    this.latitude,
    this.longitude,
    this.isPremium,
    this.liveStatus,
    this.liveAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.accessToken,
  });

  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phoneCode;
  String? phoneNumber;
  DateTime? phoneVerifiedAt;
  String? dateOfBirth;
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
  String? doYouDrink;
  String? doYouSmoke;
  String? feelAboutKids;
  String? education;
  String? introvertOrExtrovert;
  String? starSign;
  String? havePets;
  String? religion;
  String? address;
  String? latitude;
  String? longitude;
  bool? isPremium;
  bool? liveStatus;
  String? liveAt;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    gender: json["gender"] == null ? null : json["gender"],
    showGender: json["show_gender"] == null ? null : json["show_gender"],
    dateWith: json["date_with"] == null ? null : json["date_with"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    lookingFor: json["looking_for"] == null ? null : json["looking_for"],
    biography: json["biography"] == null ? null : json["biography"],
    sexualOrientation: json["sexual_orientation"] == null ? null : json["sexual_orientation"],
    tallAreYou: json["tall_are_you"] == null ? null : json["tall_are_you"],
    school: json["school"] == null ? null : json["school"],
    jobTitle: json["job_title"] == null ? null : json["job_title"],
    doYouDrink: json["do_you_drink"] == null ? null : json["do_you_drink"],
    doYouSmoke: json["do_you_smoke"] == null ? null : json["do_you_smoke"],
    feelAboutKids: json["feel_about_kids"] == null ? null : json["feel_about_kids"],
    education: json["education"] == null ? null : json["education"],
    introvertOrExtrovert: json["introvert_or_extrovert"] == null ? null : json["introvert_or_extrovert"],
    starSign: json["star_sign"] == null ? null : json["star_sign"],
    havePets: json["have_pets"] == null ? null : json["have_pets"],
    religion: json["religion"] == null ? null : json["religion"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    liveStatus: json["live_status"] == null ? null : json["live_status"],
    liveAt: json["live_at"] == null ? null : json["live_at"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
    "phone_code": phoneCode == null ? null : phoneCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "phone_verified_at": phoneVerifiedAt == null ? null : phoneVerifiedAt!.toIso8601String(),
    "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
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
    "do_you_drink": doYouDrink == null ? null : doYouDrink,
    "do_you_smoke": doYouSmoke == null ? null : doYouSmoke,
    "feel_about_kids": feelAboutKids == null ? null : feelAboutKids,
    "education": education == null ? null : education,
    "introvert_or_extrovert": introvertOrExtrovert == null ? null : introvertOrExtrovert,
    "star_sign": starSign == null ? null : starSign,
    "have_pets": havePets == null ? null : havePets,
    "religion": religion == null ? null : religion,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "is_premium": isPremium == null ? null : isPremium,
    "live_status": liveStatus == null ? null : liveStatus,
    "live_at": liveAt == null ? null : liveAt,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "access_token": accessToken == null ? null : accessToken,
  };
}
