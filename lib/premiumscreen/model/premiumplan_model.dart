

class PremiumPlansModel {
  PremiumPlansModel({
    this.statusCode,
    this.message,
    this.subscription,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  bool? subscription;
  List<Datum>? data;

  factory PremiumPlansModel.fromJson(Map<String, dynamic> json) => PremiumPlansModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    subscription: json["subscription"] == null ? null : json["subscription"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "subscription": subscription == null ? null : subscription,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.isActive,
    this.isPopular,
    this.expectedPrice,
    this.price,
    this.signupFee,
    this.currency,
    this.currencySymbol,
    this.trialPeriod,
    this.trialInterval,
    this.invoicePeriod,
    this.invoiceInterval,
    this.gracePeriod,
    this.graceInterval,
    this.prorateDay,
    this.proratePeriod,
    this.prorateExtendDue,
    this.activeSubscribersLimit,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.per_month_price,
    this.ios_sku,
    this.android_sku
  });

  dynamic id;
  bool? isActive;
  bool? isPopular;
  dynamic expectedPrice;
  dynamic price;
  dynamic ios_sku;
  dynamic android_sku;
  dynamic signupFee;
  dynamic currency;
  dynamic currencySymbol;
  dynamic trialPeriod;
  dynamic trialInterval;
  dynamic invoicePeriod;
  dynamic invoiceInterval;
  dynamic gracePeriod;
  dynamic graceInterval;
  dynamic prorateDay;
  dynamic proratePeriod;
  dynamic prorateExtendDue;
  dynamic activeSubscribersLimit;
  dynamic sortOrder;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic per_month_price;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isPopular: json["is_popular"] == null ? null : json["is_popular"],
    expectedPrice: json["expected_price"] == null ? null : json["expected_price"].toDouble(),
    price: json["price"] == null ? null : json["price"].toDouble(),
    android_sku: json["android_sku"] == null ? null : json["android_sku"],
    ios_sku: json["ios_sku"] == null ? null : json["ios_sku"],
    signupFee: json["signup_fee"] == null ? null : json["signup_fee"],
    currency: json["currency"] == null ? null : json["currency"],
    currencySymbol: json["currency_symbol"] == null ? null : json["currency_symbol"],
    trialPeriod: json["trial_period"] == null ? null : json["trial_period"],
    trialInterval: json["trial_interval"] == null ? null : json["trial_interval"],
    invoicePeriod: json["invoice_period"] == null ? null : json["invoice_period"],
    invoiceInterval: json["invoice_interval"] == null ? null : json["invoice_interval"],
    gracePeriod: json["grace_period"] == null ? null : json["grace_period"],
    graceInterval: json["grace_interval"] == null ? null : json["grace_interval"],
    prorateDay: json["prorate_day"] == null ? null : json["prorate_day"],
    proratePeriod: json["prorate_period"] == null ? null : json["prorate_period"],
    prorateExtendDue: json["prorate_extend_due"] == null ? null : json["prorate_extend_due"],
    activeSubscribersLimit: json["active_subscribers_limit"] == null ? null : json["active_subscribers_limit"],
    sortOrder: json["sort_order"] == null ? null : json["sort_order"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    per_month_price: json["per_month_price"] == null ? null : json["per_month_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "is_active": isActive == null ? null : isActive,
    "is_popular": isPopular == null ? null : isPopular,
    "expected_price": expectedPrice == null ? null : expectedPrice,
    "price": price == null ? null : price,
    "android_sku": android_sku == null ? null : android_sku,
    "ios_sku": ios_sku == null ? null : ios_sku,
    "signup_fee": signupFee == null ? null : signupFee,
    "currency": currency == null ? null : currency,
    "currency_symbol": currencySymbol == null ? null : currencySymbol,
    "trial_period": trialPeriod == null ? null : trialPeriod,
    "trial_interval": trialInterval == null ? null : trialInterval,
    "invoice_period": invoicePeriod == null ? null : invoicePeriod,
    "invoice_interval": invoiceInterval == null ? null : invoiceInterval,
    "grace_period": gracePeriod == null ? null : gracePeriod,
    "grace_interval": graceInterval == null ? null : graceInterval,
    "prorate_day": prorateDay == null ? null : prorateDay,
    "prorate_period": proratePeriod == null ? null : proratePeriod,
    "prorate_extend_due": prorateExtendDue == null ? null : prorateExtendDue,
    "active_subscribers_limit": activeSubscribersLimit == null ? null : activeSubscribersLimit,
    "sort_order": sortOrder == null ? null : sortOrder,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "per_month_price": per_month_price == null ? null : per_month_price,
  };
}
