class YourActivitylistModel {
  YourActivitylistModel({
    this.statusCode,
    this.message,
    this.matches,
    this.visitors,
    this.likes,
    this.data,
    this.your_activity
  });

  dynamic statusCode;
  dynamic message;
  dynamic matches;
  dynamic visitors;
  dynamic likes;
  dynamic your_activity;
  List<UserActivityData>? data;

  factory YourActivitylistModel.fromJson(Map<String, dynamic> json) => YourActivitylistModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    matches: json["matches"] == null ? null : json["matches"],
    visitors: json["visitors"] == null ? null : json["visitors"],
    likes: json["likes"] == null ? null : json["likes"],
    your_activity: json["your_activity"] == null ? null : json["your_activity"],
    data: json["data"] == null ? null : List<UserActivityData>.from(json["data"].map((x) => UserActivityData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "matches": matches == null ? null : matches,
    "visitors": visitors == null ? null : visitors,
    "likes": likes == null ? null : likes,
    "your_activity": your_activity == null ? null : your_activity,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserActivityData {
  UserActivityData({
    this.date,
    this.count,
  });

  dynamic date;
  dynamic count;

  factory UserActivityData.fromJson(Map<String, dynamic> json) => UserActivityData(
    date: json["date"] == null ? null : json["date"],
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "date": date == null ? null : date,
    "count": count == null ? null : count,
  };
}
