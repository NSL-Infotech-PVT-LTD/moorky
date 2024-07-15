class ProfileDetailModel {
  ProfileDetailModel({
    this.statusCode,
    this.message,
    this.data,
  });

  dynamic statusCode;
  dynamic message;
  Data? data;

  factory ProfileDetailModel.fromJson(Map<String, dynamic> json) => ProfileDetailModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
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
    this.age,
    this.latestMessageType,
    this.latestMessage,
    this.latestMessageAt,
    this.images,
    this.interests,
    this.userQuestions,
    this.city,
    this.state,
    this.distance,
    this.looking_for_icon,
    this.company_name_icon,
    this.do_you_drink_icon,
    this.do_you_smoke_icon,
    this.education_icon,
    this.feel_about_kids_icon,
    this.have_pets_icon,
    this.introvert_or_extrovert_icon,
    this.job_title_icon,
    this.religion_icon,
    this.school_icon,
    this.sexual_orientation_icon,
    this.star_sign_icon,
    this.tall_are_you_icon,
    this.languages,
    this.subscription,
    this.your_activity,
    this.hide_account,
    this.quizQuestion,
    this.is_ghost,
    this.active_monogamy,
    this.profile_image,
    this.ghost_profile,
    this.active_monogamy_user_id,
    this.active_monogamy_user_name,
    this.active_monogamy_user_image,
    this.user_plan,
    this.user_type,
    this.swipe_count,
    this.is_super_monogamy,
    this.direct_chat_count,
    this.gender_id,
    this.date_with_id,
    this.userfilterdata,
    this.realImages,
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic phoneCode;
  dynamic phoneNumber;
  dynamic phoneVerifiedAt;
  dynamic dateOfBirth;
  bool? hideMyAge;
  dynamic gender;
  bool? showGender;
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
  dynamic swipe_count;
  dynamic direct_chat_count;
  bool? isPremium;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic distance;
  dynamic latitude;
  dynamic longitude;
  dynamic hideMyLocation;
  dynamic incognitoMode;
  dynamic inAppNotifications;
  dynamic pushNotifications;
  dynamic emails;
  bool? liveStatus;
  bool? active_monogamy;
  bool? is_super_monogamy;
  dynamic liveAt;
  dynamic showLiveStatus;
  dynamic deviceFaceId;
  dynamic enableFaceId;
  dynamic allowProfileSharing;
  dynamic showAds;
  dynamic looking_for_icon;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic date_with_id;
  dynamic gender_id;
  dynamic age;
  dynamic latestMessageType;
  dynamic latestMessage;
  dynamic latestMessageAt;
  bool? ghost_profile;
  bool? subscription;
  List<Images>? images;
  List<Images>? realImages;
  List<Interest>? interests;
  List<UserQuestion>? userQuestions;
  List<Language>? languages;
  dynamic sexual_orientation_icon;
  dynamic tall_are_you_icon;
  dynamic school_icon;
  dynamic job_title_icon;
  dynamic company_name_icon;
  dynamic do_you_drink_icon;
  dynamic do_you_smoke_icon;
  dynamic feel_about_kids_icon;
  dynamic education_icon;
  dynamic introvert_or_extrovert_icon;
  dynamic star_sign_icon;
  dynamic have_pets_icon;
  dynamic religion_icon;
  dynamic your_activity;
  dynamic hide_account;
  dynamic profile_image;
  dynamic active_monogamy_user_id;
  dynamic active_monogamy_user_name;
  dynamic active_monogamy_user_image;
  dynamic user_plan;
  dynamic user_type;
  bool? is_ghost;
  QuizQuestionClass? quizQuestion;
  UserFilterData? userfilterdata;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    is_super_monogamy: json["is_super_monogamy"] == null ? null : json["is_super_monogamy"],
    direct_chat_count: json["direct_chat_count"] == null ? null : json["direct_chat_count"],
    looking_for_icon: json["looking_for_icon"] == null ? null : json["looking_for_icon"],
    company_name_icon: json["company_name_icon"] == null ? null : json["company_name_icon"],
    sexual_orientation_icon: json["sexual_orientation_icon"] == null ? null : json["sexual_orientation_icon"],
    tall_are_you_icon: json["tall_are_you_icon"] == null ? null : json["tall_are_you_icon"],
    school_icon: json["school_icon"] == null ? null : json["school_icon"],
    job_title_icon: json["job_title_icon"] == null ? null : json["job_title_icon"],
    do_you_drink_icon: json["do_you_drink_icon"] == null ? null : json["do_you_drink_icon"],
    do_you_smoke_icon: json["do_you_smoke_icon"] == null ? null : json["do_you_smoke_icon"],
    feel_about_kids_icon: json["feel_about_kids_icon"] == null ? null : json["feel_about_kids_icon"],
    education_icon: json["education_icon"] == null ? null : json["education_icon"],
    introvert_or_extrovert_icon: json["introvert_or_extrovert_icon"] == null ? null : json["introvert_or_extrovert_icon"],
    star_sign_icon: json["star_sign_icon"] == null ? null : json["star_sign_icon"],
    have_pets_icon: json["have_pets_icon"] == null ? null : json["have_pets_icon"],
    religion_icon: json["religion_icon"] == null ? null : json["religion_icon"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : json["phone_verified_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
    hideMyAge: json["hide_my_age"] == null ? null : json["hide_my_age"],
    gender: json["gender"] == null ? null : json["gender"],
    active_monogamy: json["active_monogamy"] == null ? null : json["active_monogamy"],
    showGender: json["show_gender"] == null ? null : json["show_gender"],
    dateWith: json["date_with"] == null ? null : json["date_with"],
    maritalStatus: json["marital_status"] == null ? null : json["marital_status"],
    lookingFor: json["looking_for"] == null ? null : json["looking_for"],
    biography: json["biography"] == null ? null : json["biography"],
    sexualOrientation: json["sexual_orientation"] == null ? null : json["sexual_orientation"],
    tallAreYou: json["tall_are_you"] == null ? null : json["tall_are_you"],
    swipe_count: json["swipe_count"] == null ? null : json["swipe_count"],
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
    distance: json["distance"] == null ? null : json["distance"],
    user_plan: json["user_plan"] == null ? null : json["user_plan"],
    city: json["city"] == null ? null : json["city"],
    profile_image: json["profile_image"] == null ? null : json["profile_image"],
    state: json["state"] == null ? null : json["state"],
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
    is_ghost: json["is_ghost"] == null ? null : json["is_ghost"],
    deviceFaceId: json["device_face_id"] == null ? null : json["device_face_id"],
    enableFaceId: json["enable_face_id"] == null ? null : json["enable_face_id"],
    allowProfileSharing: json["allow_profile_sharing"] == null ? null : json["allow_profile_sharing"],
    showAds: json["show_ads"] == null ? null : json["show_ads"],
    user_type: json["user_type"] == null ? null : json["user_type"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    subscription: json["subscription"] == null ? null : json["subscription"],
    your_activity: json["your_activity"] == null ? null : json["your_activity"],
    hide_account: json["hide_account"] == null ? null : json["hide_account"],
    ghost_profile: json["ghost_profile"] == null ? null : json["ghost_profile"],
    date_with_id: json["date_with_id"] == null ? null : json["date_with_id"],
    gender_id: json["gender_id"] == null ? null : json["gender_id"],
    active_monogamy_user_id: json["active_monogamy_user_id"] == null ? null : json["active_monogamy_user_id"],
    active_monogamy_user_name: json["active_monogamy_user_name"] == null ? null : json["active_monogamy_user_name"],
    active_monogamy_user_image: json["active_monogamy_user_image"] == null ? null : json["active_monogamy_user_image"],
    age: json["age"] == null ? null : json["age"],
    latestMessageType: json["latest_message_type"] == null ? null : json["latest_message_type"],
    latestMessage: json["latest_message"] == null ? null : json["latest_message"],
    latestMessageAt: json["latest_message_at"] == null ? null : json["latest_message_at"],
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    realImages: json["real_images"] == null ? null : List<Images>.from(json["real_images"].map((x) => Images.fromJson(x))),
    interests: json["interests"] == null ? null : List<Interest>.from(json["interests"].map((x) => Interest.fromJson(x))),
    userQuestions: json["user_questions"] == null ? null : List<UserQuestion>.from(json["user_questions"].map((x) => UserQuestion.fromJson(x))),
    languages: json["languages"] == null ? null : List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    quizQuestion: json["quiz_question"] == null ? null : QuizQuestionClass.fromJson(json["quiz_question"]),
    userfilterdata: json["filter_data"] == null ? null : UserFilterData.fromJson(json["filter_data"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "is_super_monogamy": is_super_monogamy == null ? null : is_super_monogamy,
    "direct_chat_count": direct_chat_count == null ? null : direct_chat_count,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
    "phone_code": phoneCode == null ? null : phoneCode,
    "looking_for_icon": looking_for_icon == null ? null : looking_for_icon,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "phone_verified_at": phoneVerifiedAt == null ? null : phoneVerifiedAt,
    "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
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
    "profile_image": profile_image == null ? null : profile_image,
    "gender_id": gender_id == null ? null : gender_id,
    "date_with_id": date_with_id == null ? null : date_with_id,
    "religion": religion == null ? null : religion,
    "is_ghost": is_ghost == null ? null : is_ghost,
    "real_photo": realPhoto == null ? null : realPhoto,
    "is_premium": isPremium == null ? null : isPremium,
    "ghost_profile": ghost_profile == null ? null : ghost_profile,
    "address": address == null ? null : address,
    "user_plan": user_plan == null ? null : user_plan,
    "city": city == null ? null : city,
    "swipe_count": swipe_count == null ? null : swipe_count,
    "state": state == null ? null : state,
    "distance": distance == null ? null : distance,
    "latitude": latitude == null ? null : latitude,
    "user_type": user_type == null ? null : user_type,
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
    "age": age == null ? null : age,
    "company_name_icon": company_name_icon == null ? null : company_name_icon,
    "sexual_orientation_icon": sexual_orientation_icon == null ? null : sexual_orientation_icon,
    "tall_are_you_icon": tall_are_you_icon == null ? null : tall_are_you_icon,
    "school_icon": school_icon == null ? null : school_icon,
    "job_title_icon": job_title_icon == null ? null : job_title_icon,
    "do_you_drink_icon": do_you_drink_icon == null ? null : do_you_drink_icon,
    "do_you_smoke_icon": do_you_smoke_icon == null ? null : do_you_smoke_icon,
    "feel_about_kids_icon": feel_about_kids_icon == null ? null : feel_about_kids_icon,
    "your_activity": your_activity == null ? null : your_activity,
    "hide_account": hide_account == null ? null : hide_account,
    "education_icon": education_icon == null ? null : education_icon,
    "active_monogamy": active_monogamy == null ? null : active_monogamy,
    "introvert_or_extrovert_icon": introvert_or_extrovert_icon == null ? null : introvert_or_extrovert_icon,
    "star_sign_icon": star_sign_icon == null ? null : star_sign_icon,
    "have_pets_icon": have_pets_icon == null ? null : have_pets_icon,
    "active_monogamy_user_id": active_monogamy_user_id == null ? null : active_monogamy_user_id,
    "active_monogamy_user_name": active_monogamy_user_name == null ? null : active_monogamy_user_name,
    "active_monogamy_user_image": active_monogamy_user_image == null ? null : active_monogamy_user_image,
    "religion_icon": religion_icon == null ? null : religion_icon,
    "latest_message_type": latestMessageType == null ? null : latestMessageType,
    "latest_message": latestMessage == null ? null : latestMessage,
    "latest_message_at": latestMessageAt == null ? null : latestMessageAt,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "real_images": realImages == null ? null : List<dynamic>.from(realImages!.map((x) => x.toJson())),
    "interests": interests == null ? null : List<dynamic>.from(interests!.map((x) => x.toJson())),
    "user_questions": userQuestions == null ? null : List<dynamic>.from(userQuestions!.map((x) => x.toJson())),
    "languages": languages == null ? null : List<dynamic>.from(languages!.map((x) => x.toJson())),
    "quiz_question": quizQuestion == null ? null : quizQuestion!.toJson(),
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

class Interest {
  Interest({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.intrestmatch
  });

  dynamic id;
  dynamic name;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  bool? intrestmatch;
  Pivot? pivot;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    intrestmatch: json["intrestmatch"] == null ? null : json["intrestmatch"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "intrestmatch": intrestmatch == null ? null : intrestmatch,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.userId,
    this.interestId,
    this.id,
  });

  dynamic userId;
  dynamic interestId;
  dynamic id;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"] == null ? null : json["user_id"],
    interestId: json["interest_id"] == null ? null : json["interest_id"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "interest_id": interestId == null ? null : interestId,
    "id": id == null ? null : id,
  };
}
class UserFilterData{
  dynamic only_premium_member;
  dynamic date_with;
  dynamic age_from;
  dynamic age_to;
  dynamic maritals;
  dynamic looking_fors;
  dynamic sexual_orientation;
  dynamic start_tall_are_you;
  dynamic end_tall_are_you;
  dynamic do_you_drink;
  dynamic do_you_smoke;
  dynamic feel_about_kids;
  dynamic education;
  dynamic introvert_or_extrovert;
  dynamic star_sign;
  dynamic have_pets;
  dynamic religion;
  dynamic languages;

  UserFilterData({
    this.only_premium_member,
    this.date_with,
    this.age_from,
    this.age_to,
    this.maritals,
    this.looking_fors,
    this.sexual_orientation,
    this.start_tall_are_you,
    this.end_tall_are_you,
    this.do_you_drink,
    this.do_you_smoke,
    this.feel_about_kids,
    this.education,
    this.introvert_or_extrovert,
    this.star_sign,
    this.have_pets,
    this.religion,
    this.languages,
  });


  factory UserFilterData.fromJson(Map<String, dynamic> json) => UserFilterData(
    only_premium_member: json["only_premium_member"] == null ? "" : json["only_premium_member"],
    date_with: json["date_with"] == null ? "" : json["date_with"],
    age_from: json["age_from"] == null ? "" : json["age_from"],
    age_to: json["age_to"] == null ? "" : json["age_to"],
    maritals: json["maritals"] == null ? "" : json["maritals"],
    looking_fors: json["looking_fors"] == null ? "" : json["looking_fors"],
    sexual_orientation: json["sexual_orientation"] == null ? "" : json["sexual_orientation"],
    start_tall_are_you: json["start_tall_are_you"] == null ? "" : json["start_tall_are_you"],
    end_tall_are_you: json["end_tall_are_you"] == null ? "" : json["end_tall_are_you"],
    do_you_drink: json["do_you_drink"] == null ? "" : json["do_you_drink"],
    do_you_smoke: json["do_you_smoke"] == null ? "" : json["do_you_smoke"],
    feel_about_kids: json["feel_about_kids"] == null ? "" : json["feel_about_kids"],
    education: json["education"] == null ? "" : json["education"],
    introvert_or_extrovert: json["introvert_or_extrovert"] == null ? "" : json["introvert_or_extrovert"],
    star_sign: json["star_sign"] == null ? "" : json["star_sign"],
    have_pets: json["have_pets"] == null ? "" : json["have_pets"],
    religion: json["religion"] == null ? "" : json["religion"],
    languages: json["languages"] == null ? "" : json["languages"],
  );

  Map<String, dynamic> toJson() => {
    "only_premium_member": only_premium_member == null ? null : only_premium_member,
    "date_with": date_with == null ? null : date_with,
    "age_from": age_from == null ? null : age_from,
    "age_to": age_to == null ? null : age_to,
    "maritals": maritals == null ? null : maritals,
    "looking_fors": looking_fors == null ? null : looking_fors,
    "sexual_orientation": sexual_orientation == null ? null : sexual_orientation,
    "start_tall_are_you": start_tall_are_you == null ? null : start_tall_are_you,
    "end_tall_are_you": end_tall_are_you == null ? null : end_tall_are_you,
    "do_you_drink": do_you_drink == null ? null : do_you_drink,
    "do_you_smoke": do_you_smoke == null ? null : do_you_smoke,
    "feel_about_kids": feel_about_kids == null ? null : feel_about_kids,
    "education": education == null ? null : education,
    "introvert_or_extrovert": introvert_or_extrovert == null ? null : introvert_or_extrovert,
    "star_sign": star_sign == null ? null : star_sign,
    "have_pets": have_pets == null ? null : have_pets,
    "religion": religion == null ? null : religion,
    "languages": languages == null ? null : languages,
  };
}

class UserQuestion {
  UserQuestion({
    this.id,
    this.userId,
    this.questionId,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.question,
    this.isDelete
  });

  dynamic id;
  dynamic userId;
  dynamic questionId;
  dynamic answer;
  dynamic createdAt;
  dynamic updatedAt;
  Question? question;
  bool? isDelete=false;

  factory UserQuestion.fromJson(Map<String, dynamic> json) => UserQuestion(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    questionId: json["question_id"] == null ? null : json["question_id"],
    answer: json["answer"] == null ? null : json["answer"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
    isDelete: false
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "question_id": questionId == null ? null : questionId,
    "answer": answer == null ? null : answer,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "question": question == null ? null : question!.toJson(),
  };
}

class Question {
  Question({
    this.id,
    this.question,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic question;
  dynamic createdAt;
  dynamic updatedAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"] == null ? null : json["id"],
    question: json["question"] == null ? null : json["question"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "question": question == null ? null : question,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class Language {
  Language({
    this.id,
    this.icon,
    this.languageCode,
    this.language,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  dynamic id;
  dynamic icon;
  dynamic languageCode;
  dynamic language;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    languageCode: json["language_code"] == null ? null : json["language_code"],
    language: json["language"] == null ? null : json["language"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "language_code": languageCode == null ? null : languageCode,
    "language": language == null ? null : language,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class QuizQuestionClass {
  QuizQuestionClass({
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
    this.answer_question
  });

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
  dynamic answer_question;

  factory QuizQuestionClass.fromJson(Map<String, dynamic> json) => QuizQuestionClass(
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
    answer_question: json["answer_question"] == null ? null : json["answer_question"],
  );

  Map<String, dynamic> toJson() => {
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
    "answer_question": answer_question == null ? null : answer_question,
  };
}


