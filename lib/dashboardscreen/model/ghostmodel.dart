class GhostModel {
  GhostModel({
    this.statusCode,
    this.message,
    this.pages,
    this.rows,
    this.data,
    this.subscription
  });

  dynamic statusCode;
  dynamic message;
  dynamic pages;
  dynamic rows;
  bool? subscription;
  List<Datum>? data;

  factory GhostModel.fromJson(Map<String, dynamic> json) => GhostModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    pages: json["pages"] == null ? null : json["pages"],
    rows: json["rows"] == null ? null : json["rows"],
    subscription: json["subscription"] == null ? null : json["subscription"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "pages": pages == null ? null : pages,
    "rows": rows == null ? null : rows,
    "subscription": subscription == null ? null : subscription,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic icon;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
