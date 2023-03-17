import 'package:firebase_database/firebase_database.dart';
import 'package:redcabs_mobile/app/app.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';

class ChatRepository {


  void sendMessage({required String message, ChatType chatType = ChatType.support, String? chatId}) async {

    final user = AppStorage.currentUserSession!;
    final userFullName = "${user.name} ${user.otherNames}";

    const timeStamp = ServerValue.timestamp;
    final payload = {
      'message': message,
      'senderId': user.id,
      'senderName': userFullName,
      'recipientId': "",
      'recipientName': "Admin",
      'sentBy': 'driver',
      'sentTo': 'admin',
      'hasFile': false,
      'filePath': '',
      'sentAt': timeStamp,
      'read': false,
      'type': chatType == ChatType.receipt ? "receipt" : "support",
      // 'payload': chatType == ChatType.receipt ? widget.data['chat_id'] : ""
      'payload': chatId
    };

    // register chat -----------
    final ref = FirebaseDatabase.instance.ref('chats/${user.id}');
    final newMessage = ref.push();
    await newMessage.set(payload);

    // get user and update ------

    final userRef = FirebaseDatabase.instance.ref('users/${user.id}');
    DatabaseEvent event = await userRef.once();
    if (event.snapshot.exists) {
      final map = event.snapshot.value as Map;
      int pendingSupportMessagesForAdmin =
      map['pendingSupportMessagesForAdmin'];
      int pendingReceiptMessagesForAdmin =
      map['pendingReceiptMessagesForAdmin'];

      // if user exists update lastMessage
      if (chatType == ChatType.support) {
        pendingSupportMessagesForAdmin = pendingSupportMessagesForAdmin + 1;
      }

      if (chatType == ChatType.receipt) {
        pendingReceiptMessagesForAdmin = pendingReceiptMessagesForAdmin + 1;
      }

      final toUpdate = {
        'lastMessage': message,
        'lastMessageTime': timeStamp,
        'pendingSupportMessagesForAdmin': pendingSupportMessagesForAdmin,
        'pendingReceiptMessagesForAdmin': pendingReceiptMessagesForAdmin,
      };
      await userRef.update(toUpdate);
    } else {
      // register the message as last message for user ---------
      final userLastMessage = {
        'name': "${user.name} ${user.otherNames}",
        'lastMessage': message,
        'lastMessageTime': timeStamp,
        'id': user.id,
        'phone': user.phone,
        'status': 'online',
        "pendingSupportMessagesForAdmin":
        chatType == ChatType.support ? 1 : 0,
        "pendingReceiptMessagesForAdmin":
        chatType == ChatType.receipt ? 1 : 0,
        "pendingSupportMessagesForDriver": 0,
        "pendingReceiptMessagesForDriver": 0,
      };

      userRef.set(userLastMessage);
    }

  }

  Stream<DatabaseEvent> connectToChatStream({ChatType chatType = ChatType.support, String? chatId}) {
    final user = AppStorage.currentUserSession!;
    DatabaseReference messageRef =
    FirebaseDatabase.instance.ref("chats/${user.id}");
    // Only update the name, leave the age and address!
    // Print the data of the snapshot
    // Get the data once
    final type = chatType == ChatType.receipt ? "receipt" : "support";

// Get the Stream
    Stream<DatabaseEvent> stream = messageRef.onValue;

    return stream;

  }

}