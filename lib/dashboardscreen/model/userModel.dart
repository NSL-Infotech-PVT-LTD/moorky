

List<UserDatum> likeUserFromJson(dynamic str) => List<UserDatum>.from((str).map((x) => UserDatum.fromJson(x)));
class UserModel {
  UserModel({
    this.statusCode,
    this.message,
    this.pages,
    this.data,
    required this.undo_count
  });

  dynamic statusCode;
  dynamic message;
  dynamic pages;
  int undo_count=0;
  List<UserDatum>? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
    pages: json["pages"] == null ? null : json["pages"],
    undo_count: json["undo_count"] == null ? 0 : json["undo_count"],
    data: json["data"] == null ? null : List<UserDatum>.from(json["data"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
    "pages": pages == null ? null : pages,
    "undo_count": undo_count == null ? 0 : undo_count,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UserDatum {
  UserDatum({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phoneCode,
    this.phoneNumber,
    this.phoneVerifiedAt,
    this.dateOfBirth,
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
    this.liveStatus,
    this.liveAt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.latestMessageType,
    this.latestMessage,
    this.latestMessageAt,
    this.images,
    this.interests,
    this.age,
    this.city,
    this.state,
    this.looking_for_icon,
    this.hide_my_age,
    this.hide_my_location,
    this.profile_image,
    this.subscription,
    this.swipe_count,
    this.is_ghost,
    this.languages,this.userQuestions
  });

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic phoneCode;
  dynamic phoneNumber;
  dynamic phoneVerifiedAt;
  dynamic dateOfBirth;
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
  bool? isPremium;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic latitude;
  dynamic longitude;
  bool? liveStatus;
  dynamic liveAt;
  bool? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic latestMessageType;
  dynamic latestMessage;
  dynamic latestMessageAt;
  dynamic age;
  dynamic looking_for_icon;
  dynamic profile_image;
  dynamic swipe_count;
  bool? hide_my_age;
  bool? hide_my_location;
  bool? is_ghost;
  bool? subscription;
  List<Images>? images;
  List<Interest>? interests;
  List<UserQuestion>? userQuestions;
  List<Language>? languages;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    age: json["age"] == null ? null : json["age"],
    email: json["email"] == null ? null : json["email"],
    is_ghost: json["is_ghost"] == null ? null : json["is_ghost"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
    phoneCode: json["phone_code"] == null ? null : json["phone_code"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    phoneVerifiedAt: json["phone_verified_at"] == null ? null : json["phone_verified_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : json["date_of_birth"],
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
    doYouDrink: json["do_you_drink"] == null ? null :json["do_you_drink"],
    doYouSmoke: json["do_you_smoke"] == null ? null : json["do_you_smoke"],
    feelAboutKids: json["feel_about_kids"] == null ? null : json["feel_about_kids"],
    education: json["education"] == null ? null : json["education"],
    subscription: json["subscription"] == null ? null : json["subscription"],
    introvertOrExtrovert: json["introvert_or_extrovert"] == null ? null : json["introvert_or_extrovert"],
    starSign: json["star_sign"] == null ? null : json["star_sign"],
    havePets: json["have_pets"] == null ? null : json["have_pets"],
    religion: json["religion"] == null ? null : json["religion"],
    realPhoto: json["real_photo"] == null ? null : json["real_photo"],
    isPremium: json["is_premium"] == null ? null : json["is_premium"],
    profile_image: json["profile_image"] == null ? null : json["profile_image"],
    hide_my_location: json["hide_my_location"] == null ? null : json["hide_my_location"],
    hide_my_age: json["hide_my_age"] == null ? null : json["hide_my_age"],
    address: json["address"] == null ? null : json["address"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    liveStatus: json["live_status"] == null ? null : json["live_status"],
    liveAt: json["live_at"] == null ? null : json["live_at"],
    status: json["status"] == null ? null : json["status"],
    looking_for_icon: json["looking_for_icon"] == null ? null : json["looking_for_icon"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
    swipe_count: json["swipe_count"] == null ? null : json["swipe_count"],
    latestMessageType: json["latest_message_type"] == null ? null : json["latest_message_type"],
    latestMessage: json["latest_message"] == null ? null : json["latest_message"],
    latestMessageAt: json["latest_message_at"] == null ? null : json["latest_message_at"],
    images: json["images"] == null ? null : List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
    interests: json["interests"] == null ? null : List<Interest>.from(json["interests"].map((x) => Interest.fromJson(x))),
    userQuestions: json["user_questions"] == null ? null : List<UserQuestion>.from(json["user_questions"].map((x) => UserQuestion.fromJson(x))),
    languages: json["languages"] == null ? null : List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "age": age == null ? null : age,
    "is_ghost": is_ghost == null ? null : is_ghost,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
    "phone_code": phoneCode == null ? null : phoneCode,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "phone_verified_at": phoneVerifiedAt == null ? null : phoneVerifiedAt,
    "date_of_birth": dateOfBirth == null ? null : dateOfBirth,
    "gender": gender == null ? null : gender,
    "show_gender": showGender == null ? null : showGender,
    "date_with": dateWith == null ? null : dateWith,
    "marital_status": maritalStatus == null ? null : maritalStatus,
    "looking_for": lookingFor == null ? null : lookingFor,
    "biography": biography == null ? null : biography,
    "sexual_orientation": sexualOrientation == null ? null : sexualOrientation,
    "tall_are_you": tallAreYou == null ? null : tallAreYou,
    "school": school == null ? null :school,
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
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "live_status": liveStatus == null ? null : liveStatus,
    "live_at": liveAt == null ? null : liveAt,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "profile_image": profile_image == null ? null : profile_image,
    "subscription": subscription == null ? null : subscription,
    "deleted_at": deletedAt == null ? null : deletedAt,
    "hide_my_location": hide_my_location == null ? null : hide_my_location,
    "hide_my_age": hide_my_age == null ? null : hide_my_age,
    "looking_for_icon": looking_for_icon == null ? null : looking_for_icon,
    "swipe_count": swipe_count == null ? null : swipe_count,
    "latest_message_type": latestMessageType == null ? null : latestMessageType,
    "latest_message": latestMessage == null ? null : latestMessage,
    "latest_message_at": latestMessageAt == null ? null : latestMessageAt,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "interests": interests == null ? null : List<dynamic>.from(interests!.map((x) => x.toJson())),
    "user_questions": userQuestions == null ? null : List<dynamic>.from(userQuestions!.map((x) => x.toJson())),
    "languages": languages == null ? null : List<dynamic>.from(languages!.map((x) => x.toJson())),

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
    this.interestMatch,
  });

  dynamic id;
  dynamic name;
  bool? status;
  bool? interestMatch;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    interestMatch: json["intrestmatch"] == null ? null : json["intrestmatch"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "status": status == null ? null : status,
    "intrestmatch": interestMatch == null ? null : interestMatch,
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
