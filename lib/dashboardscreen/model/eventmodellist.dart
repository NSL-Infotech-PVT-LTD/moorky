class EventModelList {
  EventModelList({
    this.statusCode,
    this.message,
    this.data,
    this.usersDetail
  });

  dynamic statusCode;
  dynamic message;
  List<Datum>? data;
  UsersDetail? usersDetail;

  factory EventModelList.fromJson(Map<String, dynamic> json) => EventModelList(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    usersDetail: json["users_detail"] == null ? null : UsersDetail.fromJson(json["users_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "users_detail": usersDetail == null ? null : usersDetail!.toJson(),
  };
}

class Datum {
  Datum({
    this.id,
    this.selfId,
    this.userId,
    this.date,
    this.title,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.reminder,
    this.event_for,
    this.event_color_code
  });

  dynamic id;
  dynamic selfId;
  dynamic userId;
  dynamic date;
  dynamic title;
  dynamic description;
  dynamic event_for;
  dynamic event_color_code;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  User? user;
  Remainder? reminder;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    selfId: json["self_id"] == null ? null : json["self_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    date: json["date"] == null ? null : json["date"],
    title: json["title"] == null ? null : json["title"],
    event_for: json["event_for"] == null ? null : json["event_for"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    event_color_code: json["event_color_code"] == null ? null : json["event_color_code"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    reminder: json["reminder"] == null ? null : Remainder.fromJson(json["reminder"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "self_id": selfId == null ? null : selfId,
    "user_id": userId == null ? null : userId,
    "event_for": event_for == null ? null : event_for,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "event_color_code": event_color_code == null ? null : event_color_code,
    "user": user == null ? null : user!.toJson(),
    "reminder": reminder == null ? null : reminder!.toJson(),

  };
}



class UsersDetail {
  UsersDetail({
    this.userId,
    this.userName,
    this.userImage,
    this.secondaryUserId,
    this.secondaryUserName,
    this.secondaryUserImage,
    this.user_color
  });

  dynamic userId;
  dynamic userName;
  dynamic userImage;
  dynamic secondaryUserId;
  dynamic secondaryUserName;
  dynamic secondaryUserImage;
  dynamic user_color;

  factory UsersDetail.fromJson(Map<String, dynamic> json) => UsersDetail(
    userId: json["user_id"] == null ? null : json["user_id"],
    user_color: json["user_color"] == null ? null : json["user_color"],
    userName: json["user_name"] == null ? null : json["user_name"],
    userImage: json["user_image"] == null ? null : json["user_image"],
    secondaryUserId: json["secondary_user_id"] == null ? null : json["secondary_user_id"],
    secondaryUserName: json["secondary_user_name"] == null ? null : json["secondary_user_name"],
    secondaryUserImage: json["secondary_user_image"] == null ? null : json["secondary_user_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "user_color": user_color == null ? null : user_color,
    "user_name": userName == null ? null : userName,
    "user_image": userImage == null ? null : userImage,
    "secondary_user_id": secondaryUserId == null ? null : secondaryUserId,
    "secondary_user_name": secondaryUserName == null ? null : secondaryUserName,
    "secondary_user_image": secondaryUserImage == null ? null : secondaryUserImage,
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
    this.tallAreYouOption,
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
    this.ghostStickerId,
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
    this.subscriptionEndsAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.age,
    this.profileImage,
    this.subscription,
    this.ghostSticker,
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
  dynamic dateWith;
  dynamic maritalStatus;
  dynamic lookingFor;
  dynamic biography;
  dynamic sexualOrientation;
  dynamic tallAreYou;
  dynamic tallAreYouOption;
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
  bool? hideMyLocation;
  bool? incognitoMode;
  dynamic ghostStickerId;
  bool? inAppNotifications;
  bool? pushNotifications;
  bool? emails;
  bool? liveStatus;
  dynamic liveAt;
  bool? showLiveStatus;
  dynamic deviceFaceId;
  bool? enableFaceId;
  bool? allowProfileSharing;
  bool? showAds;
  dynamic subscriptionEndsAt;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic age;
  dynamic profileImage;
  bool? subscription;
  dynamic ghostSticker;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
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
    tallAreYouOption: json["tall_are_you_option"] == null ? null : json["tall_are_you_option"],
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
    ghostStickerId: json["ghost_sticker_id"] == null ? null : json["ghost_sticker_id"],
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
    subscriptionEndsAt: json["subscription_ends_at"] == null ? null : json["subscription_ends_at"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    age: json["age"] == null ? null : json["age"],
    profileImage: json["profile_image"] == null ? null : json["profile_image"],
    subscription: json["subscription"] == null ? null : json["subscription"],
    ghostSticker: json["ghost_sticker"] == null ? null : json["ghost_sticker"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
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
    "tall_are_you_option": tallAreYouOption == null ? null : tallAreYouOption,
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
    "ghost_sticker_id": ghostStickerId == null ? null : ghostStickerId,
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
    "subscription_ends_at": subscriptionEndsAt == null ? null : subscriptionEndsAt,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "age": age == null ? null : age,
    "profile_image": profileImage == null ? null : profileImage,
    "subscription": subscription == null ? null : subscription,
    "ghost_sticker": ghostSticker == null ? null : ghostSticker,
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
  };
}
class Remainder {
  Remainder({
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

  factory Remainder.fromJson(Map<String, dynamic> json) => Remainder(
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
