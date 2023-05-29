

class ChatListModel {
  ChatListModel({
    this.statusCode,
    this.message,
    this.pages,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  dynamic pages;
  List<ChatData>? data;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    pages: json["pages"] == null ? null : json["pages"],
    data: json["data"] == null ? null : List<ChatData>.from(json["data"].map((x) => ChatData.fromJson(x))).reversed.toList(),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "pages": pages == null ? null : pages,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChatData {
  ChatData({
    this.id,
    this.message,
    this.type,
    this.sender,
    this.date,
    this.senderData,
    this.receiverData,
  });

  dynamic id;
  dynamic message;
  dynamic type;
  bool? sender;
  DateTime? date;
  ErData? senderData;
  ErData? receiverData;

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
    id: json["id"] == null ? null : json["id"],
    message: json["message"] == null ? null : json["message"],
    type: json["type"] == null ? null : json["type"],
    sender: json["sender"] == null ? null : json["sender"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    senderData: json["sender_data"] == null ? null : ErData.fromJson(json["sender_data"]),
    receiverData: json["receiver_data"] == null ? null : ErData.fromJson(json["receiver_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "message": message == null ? null : message,
    "type": type == null ? null : type,
    "sender": sender == null ? null : sender,
    "date": date == null ? null : date!.toIso8601String(),
    "sender_data": senderData == null ? null : senderData!.toJson(),
    "receiver_data": receiverData == null ? null : receiverData!.toJson(),
  };
}

class ErData {
  ErData({
    this.id,
    this.name,
    this.profileImage,
  });

  dynamic id;
  dynamic name;
  dynamic profileImage;

  factory ErData.fromJson(Map<String, dynamic> json) => ErData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "profile_image": profileImage == null ? null : profileImage,
  };
}
