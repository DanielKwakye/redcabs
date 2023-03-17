import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/features/chat/data/repositories/chat_repository.dart';
import 'package:redcabs_mobile/features/chat/data/store/chat_state.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';

class ChatCubit extends Cubit<ChatState> {

  final chatRepository = sl<ChatRepository>();
  late StreamSubscription<DatabaseEvent> chatStreamSubscription;

  ChatCubit() : super(const ChatState());

  void listenToChatMessages({ChatType chatType = ChatType.support, String? chatId}) {
    // Subscribe to the stream!

    final user = AppStorage.currentUserSession!;
    Stream<DatabaseEvent> chatStream = chatRepository.connectToChatStream(chatId: chatId, chatType: chatType);
    final type = chatType == ChatType.receipt ? "receipt" : "support";

    emit(state.copyWith(
      status: BlocStatus.chatMessagesLoadInProgress,
    ));

    chatStreamSubscription = chatStream.listen((DatabaseEvent event) {
       // print(event.snapshot.value); // { "name": "John" }
       if (!event.snapshot.exists || event.snapshot.value == null) {
         emit(state.copyWith(
             status: BlocStatus.chatMessagesLoaded,
             chats: []
         ));
         return;
       }

       final map = event.snapshot.value as Map;
       final chats = [];
       map.forEach((key, value) async {
         //  Load  receipt  messages ================
         if (chatType == ChatType.receipt) {
           if (value['type'] == "receipt" &&
               value['payload'] == chatId) {
             chats.add(value);
           }
         }

         //  Load support messages  messages ================
         if (chatType == ChatType.support) {
           if (value['type'] == "support") {
             chats.add(value);
           }
         }

         // mark messages as read ==================
         if (value['sentTo'] == 'driver' && value['type'] == type) {
           if (chatType == ChatType.receipt) {
             if (value['payload'] == chatId) {
               final newRef =
               FirebaseDatabase.instance.ref("chats/${user.id}/$key");
               await newRef.update({
                 "read": true,
               });
             }
           }

           if (chatType == ChatType.support) {
             final newRef =
             FirebaseDatabase.instance.ref("chats/${user.id}/$key");
             await newRef.update({
               "read": true,
             });
           }
         }
       });

       chats.sort((b, a) => a['sentAt'].compareTo(b['sentAt']));

         emit(state.copyWith(
           status: BlocStatus.chatMessagesLoaded,
           chats: chats
         ));


     });

  }

  void sendMessage({required String message, ChatType chatType = ChatType.support, String? chatId}) {
    chatRepository.sendMessage(message: message, chatType: chatType, chatId: chatId);
  }

  dispose() {
    chatStreamSubscription.cancel();
  }
}