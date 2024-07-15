import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:moorky/dashboardscreen/model/message_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseFirestore, required this.firebaseStorage});

  String? getPref(String key) {}

  UploadTask uploadFile(File image, String fileName) {
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    print(docPath);
    print(collectionPath);
    print("collectionPath");
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    print('groupChatIdgroupChatId$groupChatId');
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  getCHatList({String? groupChatId,String?localId}) async {
    final CollectionReference _products =
        FirebaseFirestore.instance.collection('messages');
List<String>?groupId=groupChatId?.split("-");

    var datass = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId!)
        .get();
    List<MessageChat> mess = [];
    datass.then((value) {
      //  value.docs.map((e) {
      //    print("data!.length");
      //    print(e);
      //  });
      //
      for (int i = 0; i < value.docs.length; i++) {
        var firstDelete;
        var secondDelete;
        print("data!.length");
        if(groupId?[0]==localId){
          firstDelete=1;

        }
        else{
          secondDelete=1;

        }
        print("isssss${groupId?[1]==localId}");
        MessageChat messageChat = MessageChat(
            content: value.docs[i]['content'],
            idTo: value.docs[i]['idTo'],
            idFrom: value.docs[i]['idFrom'],
            timestamp: value.docs[i]['timestamp'],
            type: value.docs[i]['type'],
            isDelete:value.docs[i]['is_delete']==1?1: groupId?[0]==localId?1:0,
            isDeleteSecond:value.docs[i]['is_delete_second']==1?1: groupId?[1]==localId?1:0);

        //print(messageChat.toJson());
        updateUserData(messageChat.toJson(), groupChatId, value.docs[i].id);
      }
    });
  }

  Future<String>getUserCHatList({String?localId}) async {
    print("hfjdfjf");
    final QuerySnapshot? _products =  await FirebaseFirestore.instance.collection('messages').get();
    print(_products?.docs.length);
    //List<String>?groupId=groupChatId?.split("-");

     var datass = firebaseFirestore
         .collection("users").doc(localId).delete();
    FirebaseAuth.instance.currentUser?.delete();

    return "success";

  }

  Future<String> updateUserData(
      dynamic data, String groupChatid, String timeStamp) async {
    final db = FirebaseFirestore.instance;
    try {

      if(data['is_delete']==1&&data['is_delete_second']==1){
        await firebaseFirestore
            .collection(FirestoreConstants.pathMessageCollection)
            .doc(groupChatid)
            .collection(groupChatid)
            .doc(timeStamp).delete();
        return "Updated";
      }
      else{
      await firebaseFirestore
          .collection(FirestoreConstants.pathMessageCollection)
          .doc(groupChatid)
          .collection(groupChatid)
          .doc(timeStamp)
          .update(data);
      print("ghhjjvghkhl");
      return "Updated";
    }} on FirebaseException catch (error) {
      return error.toString();
    }
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type,
        isDelete: 0,
        isDeleteSecond: 0);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  void sendTypingEvent(bool typing,{required String userId}){
     firebaseFirestore
        .collection("users")
        .doc(userId).get().then((value) {

          Map<String,dynamic> data= {"isTyping":typing};
          Map<String,dynamic> oldData=  value.data()!;
         var newValues= oldData.addAll(data);

          updateTypingValue(userId: userId,value:oldData);

     });

  }

  Stream<DocumentSnapshot> userDetail({ String ?userId}){
  return   firebaseFirestore
        .collection("users")
        .doc("$userId").snapshots();



  }

  updateTypingValue({required String userId,required Map<String,dynamic>value})async{
try{
  await firebaseFirestore
      .collection("users")
      .doc(userId)
      .update(value);
}
    catch(e){
  print("nott Updated");
    }
  }
}

class TypeMessage {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
