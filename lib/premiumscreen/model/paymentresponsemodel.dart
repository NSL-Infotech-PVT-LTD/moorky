class PaymentresponseModel {
  PaymentresponseModel({
    this.statusCode,
    this.message,
    this.paymentLink,
  });

  dynamic statusCode;
  dynamic message;
  dynamic paymentLink;

  factory PaymentresponseModel.fromJson(Map<String, dynamic> json) => PaymentresponseModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    paymentLink: json["payment_link"] == null ? null : json["payment_link"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "payment_link": paymentLink == null ? null : paymentLink,
  };
}
