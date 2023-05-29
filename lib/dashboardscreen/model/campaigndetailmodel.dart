class CampaignDetailModel {
  CampaignDetailModel({
    this.statusCode,
    this.message,
    this.data,
    this.suggestedCampaigns,
  });

  int? statusCode;
  String? message;
  Data? data;
  List<Data>? suggestedCampaigns;

  factory CampaignDetailModel.fromJson(Map<String, dynamic> json) => CampaignDetailModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    suggestedCampaigns: json["suggested_campaigns"] == null ? null : List<Data>.from(json["suggested_campaigns"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "suggested_campaigns": suggestedCampaigns == null ? null : List<dynamic>.from(suggestedCampaigns!.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.discount,
    this.banner,
    this.couponCode,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? discount;
  String? banner;
  String? couponCode;
  String? title;
  String? description;
  bool? status;
  String? createdAt;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    discount: json["discount"] == null ? null : json["discount"],
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
    "discount": discount == null ? null : discount,
    "banner": banner == null ? null : banner,
    "coupon_code": couponCode == null ? null : couponCode,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
