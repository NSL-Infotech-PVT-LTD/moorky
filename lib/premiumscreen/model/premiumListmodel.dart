

class PremiumListModel {
  PremiumListModel({
    this.statusCode,
    this.message,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  List<Datum>? data;

  factory PremiumListModel.fromJson(Map<String, dynamic> json) => PremiumListModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic icon;
  dynamic title;
  dynamic description;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
