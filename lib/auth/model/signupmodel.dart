// To parse this JSON data, do
//
//     final signupmodel = signupmodelFromJson(jsonString);

class Signupmodel {
  Signupmodel({
    this.statusCode,
    this.message,
    this.data,
    required this.already_register
  });

  int? statusCode;
  String? message;
  bool already_register=false;
  Data? data;

  factory Signupmodel.fromJson(Map<String, dynamic> json) => Signupmodel(
    statusCode: json["statusCode"],
    message: json["message"],
    already_register: json['already_register'],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data!.toJson(),
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
  bool? status=false;
  bool? msg_status;
  String? createdAt;
  String? updatedAt;
  dynamic otp_text;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    token: json["token"],
    otp: json["otp"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    otp_text: json["otp_text"],
    msg_status: json["msg_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "token": token,
    "otp": otp,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "otp_text": otp_text,
    "msg_status": msg_status,
  };
}
