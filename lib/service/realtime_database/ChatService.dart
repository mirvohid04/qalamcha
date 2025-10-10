import 'package:firebase_database/firebase_database.dart';

class ChatService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  final databaseReference = FirebaseDatabase.instance.ref("messages");

  void sendMessage(String messageContent, String userId) {
    databaseReference
        .push()
        .set({
          'text': messageContent,
          'userId': userId,
          'timestamp': ServerValue.timestamp,
        })
        .then((_) {
          print("Message sent successfully!");
        })
        .catchError((error) {
          print("Failed to send message: $error");
        });
  }

  Stream<Map<dynamic, dynamic>> getMessages() {
    return _db
        .child('messages')
        .orderByChild('timestamp')
        .limitToLast(50)
        .onValue
        .map((DatabaseEvent event) {
          print(event.snapshot.value);
          return event.snapshot.value as Map<dynamic, dynamic>? ?? {};
        });
  }

  Future<void> deleteMessage(String messageId) async {
    await _db.child('messages').child(messageId).remove();
  }

  //ikki kishi uchun chat
  String getChatId(String uid1, String uid2) {
    final ids = [uid1, uid2];
    ids.sort(); // tartiblab qo‘yish
    return ids.join("_");
  }

  Future<void> sendMessageId(
    String chatId,
    String text,
    String senderId,
  ) async {
    final newMessageRef = _db.child("chats/$chatId/messages").push();

    await newMessageRef.set({
      "text": text,
      "userId": senderId,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "status": "sending",
    });
    await newMessageRef.update({"status": "delivered"});
  }

  Stream<Map<dynamic, dynamic>> getMessagesId(String chatId) {
    return _db.child("chats/$chatId/messages").onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return data;
    });
  }

  Future<void> deleteMessageId(String chatId, String messageId) async {
    await _db.child("chats/$chatId/messages/$messageId").remove();
  }

  Future<void> markAsSeen(String chatId, String currentUserId) async {
    final snapshot = await _db.child("chats/$chatId/messages").get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      data.forEach((key, value) {
        if (value["userId"] != currentUserId && value["status"] != "seen") {
          _db.child("chats/$chatId/messages/$key/status").set("seen");
        }
      });
    }
  }
}
