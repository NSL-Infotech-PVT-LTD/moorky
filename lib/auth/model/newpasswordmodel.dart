class NewpasswordModel{
  dynamic statuscode;
  dynamic message;
  NewpasswordModel({required this.message,required this.statuscode});
  NewpasswordModel.fromJson(Map<String,dynamic> json){
    message=json['message'];
    statuscode=json['statusCode'];
  }
}