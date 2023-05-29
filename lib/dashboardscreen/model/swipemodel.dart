class UserSwipeModel {
  UserSwipeModel({
    this.statusCode,
    this.message,
    this.swipeCount,
  });

  dynamic statusCode;
  dynamic message;
  dynamic swipeCount;

  factory UserSwipeModel.fromJson(Map<String, dynamic> json) => UserSwipeModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    swipeCount: json["swipe_count"] == null ? null : json["swipe_count"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "swipe_count": swipeCount == null ? null : swipeCount,
  };
}
