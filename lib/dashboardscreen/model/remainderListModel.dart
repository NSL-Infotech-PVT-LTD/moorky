class RemainderListModel {
  RemainderListModel({
    this.statusCode,
    this.message,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  List<Datum>? data;

  factory RemainderListModel.fromJson(Map<String, dynamic> json) => RemainderListModel(
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
    this.durationPeriod,
    this.durationType,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic durationPeriod;
  dynamic durationType;
  dynamic title;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    durationPeriod: json["duration_period"] == null ? null : json["duration_period"],
    durationType: json["duration_type"] == null ? null : json["duration_type"],
    title: json["title"] == null ? null : json["title"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "duration_period": durationPeriod == null ? null : durationPeriod,
    "duration_type": durationType == null ? null : durationType,
    "title": title == null ? null : title,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
