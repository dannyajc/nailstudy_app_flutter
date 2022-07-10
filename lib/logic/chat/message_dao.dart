import 'package:firebase_database/firebase_database.dart';
import 'package:nailstudy_app_flutter/logic/chat/message_model.dart';

class MessageDao {
  final DatabaseReference messagesRef = FirebaseDatabase.instance.ref();

  // Fire once after chatId has been retrieved from the API (after injection into chats array in user)
  void initiateChat(String userOne, String userTwo, String chatId) {
    messagesRef.child('chat/$chatId').update({
      "userOne": userOne,
      "userTwo": userTwo,
    });
  }

  void sendMessage(Message message, String chatId) {
    messagesRef.child('chat/$chatId/messages').push().set(message.toJson());
  }

  Query getMessageQuery(String chatId) {
    return messagesRef.child('chat/$chatId/messages');
  }

  DatabaseReference getChatObject(String chatId) {
    return messagesRef.child('chat/$chatId');
  }
}
