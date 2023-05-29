// To parse this JSON data, do
//
//     final updatePhoneModel = updatePhoneModelFromJson(jsonString);

import 'dart:convert';

UpdatePhoneModel updatePhoneModelFromJson(String str) => UpdatePhoneModel.fromJson(json.decode(str));

String updatePhoneModelToJson(UpdatePhoneModel data) => json.encode(data.toJson());

class UpdatePhoneModel {
  UpdatePhoneModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory UpdatePhoneModel.fromJson(Map<String, dynamic> json) => UpdatePhoneModel(
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
    this.phoneCode,
    this.phoneNumber,
    this.token,
    this.otp,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.otp_text,
    this.msg_status
  });

  int? id;
  String? phoneCode;
  String? phoneNumber;
  String? token;
  String? otp;
  bool? status;
  bool? msg_status;
  String? createdAt;
  String? updatedAt;
  dynamic otp_text;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    token: json["token"] == null ? null : json["token"],
    otp: json["otp"] == null ? null : json["otp"],
    status: json["status"] == null ? null : json["status"],
    msg_status: json["msg_status"] == null ? null : json["msg_status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    otp_text: json["otp_text"] == null ? null : json["otp_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "phone_code": phoneCode == null ? null : phoneCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "token": token == null ? null : token,
    "otp": otp == null ? null : otp,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "otp_text": otp_text == null ? null : otp_text,
    "msg_status": msg_status == null ? null : msg_status,
  };
}
