class UsersChatListModel {
  UsersChatListModel({
    this.statusCode,
    this.message,
    this.totalPages,
    this.totalCount,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  dynamic totalPages;
  dynamic totalCount;
  List<Datum>? data;

  factory UsersChatListModel.fromJson(Map<String, dynamic> json) => UsersChatListModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    totalPages: json["total_pages"] == null ? null : json["total_pages"],
    totalCount: json["total_count"] == null ? null : json["total_count"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "total_pages": totalPages == null ? null : totalPages,
    "total_count": totalCount == null ? null : totalCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.selfId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.isDeleteChat
  });

  dynamic id;
  dynamic selfId;
  dynamic userId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isDeleteChat;
  User? user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    selfId: json["self_id"] == null ? null : json["self_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
      isDeleteChat:false
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "self_id": selfId == null ? null : selfId,
    "user_id": userId == null ? null : userId,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneCode,
    this.phoneNumber,
    this.phoneVerifiedAt,
    this.dateOfBirth,
    this.hideMyAge,
    this.gender,
    this.showGender,
    this.dateWith,
    this.maritalStatus,
    this.lookingFor,
    this.biography,
    this.sexualOrientation,
    this.tallAreYou,
    this.school,
    this.jobTitle,
    this.companyName,
    this.doYouDrink,
    this.doYouSmoke,
    this.feelAboutKids,
    this.education,
    this.introvertOrExtrovert,
    this.starSign,
    this.havePets,
    this.religion,
    this.realPhoto,
    this.isPremium,
    this.address,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.hideMyLocation,
    this.incognitoMode,
    this.inAppNotifications,
    this.pushNotifications,
    this.emails,
    this.liveStatus,
    this.liveAt,
    this.showLiveStatus,
    this.deviceFaceId,
    this.enableFaceId,
    this.allowProfileSharing,
    this.showAds,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.unseenMessagesCount,
    this.age,
    this.profileImage,
    this.lookingForIcon,
    this.sexualOrientationIcon,
    this.tallAreYouIcon,
    this.schoolIcon,
    this.jobTitleIcon,
    this.companyNameIcon,
    this.doYouDrinkIcon,
    this.doYouSmokeIcon,
    this.feelAboutKidsIcon,
    this.educationIcon,
    this.introvertOrExtrovertIcon,
    this.starSignIcon,
    this.havePetsIcon,
    this.religionIcon,
    this.latestMessageType,
    this.latestMessage,
    this.latestMessageAt,
    this.images,
    this.is_remove
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic phoneCode;
  dynamic phoneNumber;
  dynamic phoneVerifiedAt;
  dynamic dateOfBirth;
  dynamic hideMyAge;
  dynamic gender;
  bool? showGender;
  bool? is_remove;
  dynamic dateWith;
  dynamic maritalStatus;
  dynamic lookingFor;
  dynamic biography;
  dynamic sexualOrientation;
  dynamic tallAreYou;
  dynamic school;
  dynamic jobTitle;
  dynamic companyName;
  dynamic doYouDrink;
  dynamic doYouSmoke;
  dynamic feelAboutKids;
  dynamic education;
  dynamic introvertOrExtrovert;
  dynamic starSign;
  dynamic havePets;
  dynamic religion;
  dynamic realPhoto;
  bool? isPremium;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic latitude;
  dynamic longitude;
  dynamic hideMyLocation;
  dynamic incognitoMode;
  dynamic inAppNotifications;
  dynamic pushNotifications;
  dynamic emails;
  bool? liveStatus;
  dynamic liveAt;
  dynamic showLiveStatus;
  dynamic deviceFaceId;
  dynamic enableFaceId;
  dynamic allowProfileSharing;
  dynamic showAds;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic unseenMessagesCount;
  dynamic age;
  dynamic profileImage;
  dynamic lookingForIcon;
  dynamic sexualOrientationIcon;
  dynamic tallAreYouIcon;
  dynamic schoolIcon;
  dynamic jobTitleIcon;
  dynamic companyNameIcon;
  dynamic doYouDrinkIcon;
  dynamic doYouSmokeIcon;
  dynamic feelAboutKidsIcon;
  dynamic educationIcon;
  dynamic introvertOrExtrovertIcon;
  dynamic starSignIcon;
  dynamic havePetsIcon;
  dynamic religionIcon;
  dynamic latestMessageType;
  dynamic latestMessage;
  dynamic latestMessageAt;
  List<Images>? images;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    is_remove: json["is_remove"] == null ? null : json["is_remove"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : json["phone_verified_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    hideMyAge: json["hide_my_age"] == null ? null : json["hide_my_age"],
    gender: json["gender"] == null ? null : json["gender"],
    showGender: json["show_gender"] == null ? null : json["show_gender"],
    dateWith: json["date_with"] == null ? null : json["date_with"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    lookingFor: json["looking_for"] == null ? null : json["looking_for"],
    biography: json["biography"] == null ? null : json["biography"],
    sexualOrientation: json["sexual_orientation"] == null ? null : json["sexual_orientation"],
    tallAreYou: json["tall_are_you"] == null ? null : json["tall_are_you"],
    school: json["school"] == null ? null : json["school"],
    jobTitle: json["job_title"] == null ? null : json["job_title"],
    companyName: json["company_name"] == null ? null : json["company_name"],
    doYouDrink: json["do_you_drink"] == null ? null : json["do_you_drink"],
    doYouSmoke: json["do_you_smoke"] == null ? null : json["do_you_smoke"],
    feelAboutKids: json["feel_about_kids"] == null ? null : json["feel_about_kids"],
    education: json["education"] == null ? null : json["education"],
    introvertOrExtrovert: json["introvert_or_extrovert"] == null ? null : json["introvert_or_extrovert"],
    starSign: json["star_sign"] == null ? null : json["star_sign"],
    havePets: json["have_pets"] == null ? null : json["have_pets"],
    religion: json["religion"] == null ? null : json["religion"],
    realPhoto: json["real_photo"] == null ? null : json["real_photo"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    hideMyLocation: json["hide_my_location"] == null ? null : json["hide_my_location"],
    incognitoMode: json["incognito_mode"] == null ? null : json["incognito_mode"],
    inAppNotifications: json["in_app_notifications"] == null ? null : json["in_app_notifications"],
    pushNotifications: json["push_notifications"] == null ? null : json["push_notifications"],
    emails: json["emails"] == null ? null : json["emails"],
    liveStatus: json["live_status"] == null ? null : json["live_status"],
    liveAt: json["live_at"] == null ? null : json["live_at"],
    showLiveStatus: json["show_live_status"] == null ? null : json["show_live_status"],
    deviceFaceId: json["device_face_id"] == null ? null : json["device_face_id"],
    enableFaceId: json["enable_face_id"] == null ? null : json["enable_face_id"],
    allowProfileSharing: json["allow_profile_sharing"] == null ? null : json["allow_profile_sharing"],
    showAds: json["show_ads"] == null ? null : json["show_ads"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    unseenMessagesCount: json["unseen_messages_count"] == null ? null : json["unseen_messages_count"],
    age: json["age"] == null ? null : json["age"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    lookingForIcon: json["looking_for_icon"] == null ? null : json["looking_for_icon"],
    sexualOrientationIcon: json["sexual_orientation_icon"] == null ? null : json["sexual_orientation_icon"],
    tallAreYouIcon: json["tall_are_you_icon"] == null ? null : json["tall_are_you_icon"],
    schoolIcon: json["school_icon"] == null ? null : json["school_icon"],
    jobTitleIcon: json["job_title_icon"] == null ? null : json["job_title_icon"],
    companyNameIcon: json["company_name_icon"] == null ? null : json["company_name_icon"],
    doYouDrinkIcon: json["do_you_drink_icon"] == null ? null : json["do_you_drink_icon"],
    doYouSmokeIcon: json["do_you_smoke_icon"] == null ? null : json["do_you_smoke_icon"],
    feelAboutKidsIcon: json["feel_about_kids_icon"] == null ? null : json["feel_about_kids_icon"],
    educationIcon: json["education_icon"] == null ? null : json["education_icon"],
    introvertOrExtrovertIcon: json["introvert_or_extrovert_icon"] == null ? null : json["introvert_or_extrovert_icon"],
    starSignIcon: json["star_sign_icon"] == null ? null : json["star_sign_icon"],
    havePetsIcon: json["have_pets_icon"] == null ? null : json["have_pets_icon"],
    religionIcon: json["religion_icon"] == null ? null : json["religion_icon"],
    latestMessageType: json["latest_message_type"] == null ? null : json["latest_message_type"],
    latestMessage: json["latest_message"] == null ? null : json["latest_message"],
    latestMessageAt: json["latest_message_at"] == null ? null : json["latest_message_at"],
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "is_remove": is_remove == null ? null : is_remove,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
    "phone_code": phoneCode == null ? null : phoneCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "phone_verified_at": phoneVerifiedAt == null ? null : phoneVerifiedAt.toIso8601String(),
    "date_of_birth": dateOfBirth == null ? null : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "hide_my_age": hideMyAge == null ? null : hideMyAge,
    "gender": gender == null ? null : gender,
    "show_gender": showGender == null ? null : showGender,
    "date_with": dateWith == null ? null : dateWith,
    "marital_status": maritalStatus == null ? null : maritalStatus,
    "looking_for": lookingFor == null ? null : lookingFor,
    "biography": biography == null ? null : biography,
    "sexual_orientation": sexualOrientation == null ? null : sexualOrientation,
    "tall_are_you": tallAreYou == null ? null : tallAreYou,
    "school": school == null ? null : school,
    "job_title": jobTitle == null ? null : jobTitle,
    "company_name": companyName == null ? null : companyName,
    "do_you_drink": doYouDrink == null ? null : doYouDrink,
    "do_you_smoke": doYouSmoke == null ? null : doYouSmoke,
    "feel_about_kids": feelAboutKids == null ? null : feelAboutKids,
    "education": education == null ? null : education,
    "introvert_or_extrovert": introvertOrExtrovert == null ? null : introvertOrExtrovert,
    "star_sign": starSign == null ? null : starSign,
    "have_pets": havePets == null ? null : havePets,
    "religion": religion == null ? null : religion,
    "real_photo": realPhoto == null ? null : realPhoto,
    "is_premium": isPremium == null ? null : isPremium,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "hide_my_location": hideMyLocation == null ? null : hideMyLocation,
    "incognito_mode": incognitoMode == null ? null : incognitoMode,
    "in_app_notifications": inAppNotifications == null ? null : inAppNotifications,
    "push_notifications": pushNotifications == null ? null : pushNotifications,
    "emails": emails == null ? null : emails,
    "live_status": liveStatus == null ? null : liveStatus,
    "live_at": liveAt == null ? null : liveAt,
    "show_live_status": showLiveStatus == null ? null : showLiveStatus,
    "device_face_id": deviceFaceId == null ? null : deviceFaceId,
    "enable_face_id": enableFaceId == null ? null : enableFaceId,
    "allow_profile_sharing": allowProfileSharing == null ? null : allowProfileSharing,
    "show_ads": showAds == null ? null : showAds,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "unseen_messages_count": unseenMessagesCount == null ? null : unseenMessagesCount,
    "age": age == null ? null : age,
    "profile_image": profileImage == null ? null : profileImage,
    "looking_for_icon": lookingForIcon == null ? null : lookingForIcon,
    "sexual_orientation_icon": sexualOrientationIcon == null ? null : sexualOrientationIcon,
    "tall_are_you_icon": tallAreYouIcon == null ? null : tallAreYouIcon,
    "school_icon": schoolIcon == null ? null : schoolIcon,
    "job_title_icon": jobTitleIcon == null ? null : jobTitleIcon,
    "company_name_icon": companyNameIcon == null ? null : companyNameIcon,
    "do_you_drink_icon": doYouDrinkIcon == null ? null : doYouDrinkIcon,
    "do_you_smoke_icon": doYouSmokeIcon == null ? null : doYouSmokeIcon,
    "feel_about_kids_icon": feelAboutKidsIcon == null ? null : feelAboutKidsIcon,
    "education_icon": educationIcon == null ? null : educationIcon,
    "introvert_or_extrovert_icon": introvertOrExtrovertIcon == null ? null : introvertOrExtrovertIcon,
    "star_sign_icon": starSignIcon == null ? null : starSignIcon,
    "have_pets_icon": havePetsIcon == null ? null : havePetsIcon,
    "religion_icon": religionIcon == null ? null : religionIcon,
    "latest_message_type": latestMessageType == null ? null : latestMessageType,
    "latest_message": latestMessage == null ? null : latestMessage,
    "latest_message_at": latestMessageAt == null ? null : latestMessageAt,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Images {
  Images({
    this.id,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic userId;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    image: json["image"] == null ? null : json["image"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "image": image == null ? null : image,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
