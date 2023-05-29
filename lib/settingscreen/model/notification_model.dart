// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.statusCode,
    this.message,
    this.pages,
    this.rows,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  dynamic pages;
  dynamic rows;
  List<Datum>? data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    pages: json["pages"] == null ? null : json["pages"],
    rows: json["rows"] == null ? null : json["rows"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "pages": pages == null ? null : pages,
    "rows": rows == null ? null : rows,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.notificationType,
    this.notification,
    this.createdAt,
    this.updatedAt,
    this.date,
    this.seletdate
  });

  dynamic id;
  dynamic userId;
  dynamic notificationType;
  Notification? notification;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic date;
  dynamic seletdate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    notificationType: json["notification_type"] == null ? null : json["notification_type"],
    notification: json["notification"] == null ? null : Notification.fromJson(json["notification"]),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    date: json["date"] == null ? null : json["date"], seletdate:""
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "notification_type": notificationType == null ? null : notificationType,
    "notification": notification == null ? null : notification!.toJson(),
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "date": date == null ? null : date,
  };
}



class Notification {
  Notification({
    this.title,
    this.body,
    this.type,
    this.image,
    this.isNotifictiondelete
  });

  dynamic title;
  dynamic body;
  dynamic type;
  dynamic image;
  bool? isNotifictiondelete=false;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
      isNotifictiondelete:false  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
  };
}
