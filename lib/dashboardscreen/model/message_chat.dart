import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;
  final int isDelete;
  final int isDeleteSecond;

  const MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
    required this.isDelete,
    required this.isDeleteSecond,
  });

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: this.idFrom,
      FirestoreConstants.idTo: this.idTo,
      FirestoreConstants.timestamp: this.timestamp,
      FirestoreConstants.content: this.content,
      FirestoreConstants.type: this.type,
      FirestoreConstants.isDelete: this.isDelete,
      FirestoreConstants.isDeleteSecond: this.isDeleteSecond,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get(FirestoreConstants.idFrom);
    String idTo = doc.get(FirestoreConstants.idTo);
    String timestamp = doc.get(FirestoreConstants.timestamp);
    String content = doc.get(FirestoreConstants.content);
    int type = doc.get(FirestoreConstants.type);
    int isDelete = doc.get(FirestoreConstants.isDelete);
    int isDeleteSecond = doc.get(FirestoreConstants.isDeleteSecond);
    return MessageChat(idFrom: idFrom, idTo: idTo, timestamp: timestamp, content: content, type: type,isDelete: isDelete,isDeleteSecond:isDeleteSecond);
  }
}

class FirestoreConstants {
  static const pathUserCollection = "users";
  static const pathMessageCollection = "messages";
  static const nickname = "nickname";
  static const aboutMe = "aboutMe";
  static const photoUrl = "photoUrl";
  static const id = "id";
  static const chattingWith = "chattingWith";
  static const idFrom = "idFrom";
  static const idTo = "idTo";
  static const timestamp = "timestamp";
  static const content = "content";
  static const type = "type";
  static const isDelete = "is_delete";
  static const isDeleteSecond = "is_delete_second";
}