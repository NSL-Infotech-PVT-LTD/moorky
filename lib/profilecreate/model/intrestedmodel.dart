
class InterestedModel {
  InterestedModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Datum>? data;


  factory InterestedModel.fromJson(Map<String, dynamic> json) => InterestedModel(
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
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isSelected
  });

  int? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  bool? isSelected=false;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      status: json["status"] == null ? null : json["status"],
      createdAt: json["created_at"] == null ? null : json["created_at"],
      updatedAt: json["updated_at"] == null ? null : json["updated_at"], isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
