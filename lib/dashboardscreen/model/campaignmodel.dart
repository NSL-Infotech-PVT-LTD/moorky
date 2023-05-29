class CampaignModel {
  CampaignModel({
    this.statusCode,
    this.message,
    this.pages,
    this.data,
  });

  int? statusCode;
  String? message;
  int? pages;
  List<Datum>? data;

  factory CampaignModel.fromJson(Map<String, dynamic> json) => CampaignModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    pages: json["pages"] == null ? null : json["pages"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "pages": pages == null ? null : pages,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.banner,
    this.couponCode,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? banner;
  String? couponCode;
  String? title;
  String? description;
  bool? status;
  String? createdAt;
  String? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    banner: json["banner"] == null ? null : json["banner"],
    couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "banner": banner == null ? null : banner,
    "coupon_code": couponCode == null ? null : couponCode,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
