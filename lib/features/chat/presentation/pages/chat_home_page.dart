import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/chat/data/store/chat_cubit.dart';
import 'package:redcabs_mobile/features/chat/data/store/chat_state.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_circular_loader.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_network_image_widget.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';
import '../../../notifications/data/store/notification_cubit.dart';
import '../../../shared/presentation/widgets/loading_placeholder_widget.dart';
import '../../../shared/presentation/widgets/shared_send_chat_button_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  ChatHomePageController createState() => ChatHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _ChatHomePageView
    extends WidgetView<ChatHomePage, ChatHomePageController> {
  const _ChatHomePageView(ChatHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: theme.colorScheme.background,
          child: Container(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10, right: 10, bottom: 10.0),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: theme.colorScheme.outline))),
            child: Row(
              children: [
                /// Pick file from gallery here
                // Container(
                //   decoration: BoxDecoration(
                //       color: kAppRed,
                //       borderRadius: BorderRadius.circular(100)
                //   ),
                //   width: 40,
                //   height: 40,
                //   padding: const EdgeInsets.all(5),
                //   child: const Icon(FeatherIcons.camera, color: kAppWhite, size: 18,),
                // ),
                //
                // const SizedBox(width: 10,),

                /// Chat message box here  ---
                Expanded(
                    child: CupertinoTextField(
                  focusNode: state.focusNode,
                  cursorColor: theme.colorScheme.onSurface,
                  controller: state._messageController,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: state.chatEditorTextChangeHandler,
                  style: TextStyle(color: theme.colorScheme.onBackground),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.colorScheme.outline),
                      color: theme.colorScheme.outline),
                  cursorWidth: 1,
                  maxLines: null,
                  // cursorHeight: 14,
                  placeholder: 'Type your message here ...',
                  keyboardAppearance: theme.brightness,
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, bottom: 10, right: 10),
                  textAlign: TextAlign.start,
                )),

                /// Send button here ---
                /// Send button here ---
                ValueListenableBuilder<bool>(
                  valueListenable: state.showSubmitButton,
                  builder: (_, show, ch) {
                    if (show) return ch!;
                    return const SizedBox.shrink();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SharedSendChatButtonWidget(
                      onTap: state.sendMessage,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SharedSliverAppBar(
                pageTitle: 'Redcabs admin support',
                backgroundColor: kAppRed,
                pageTitleColor: kAppWhite,
                centerTitle: true,
                iconThemeColor: kAppWhite,
                pinned: true,
              ),
              // SharedNetworkImageWidget(imageUrl: imageUrl)
            ];
          },
          body: BlocBuilder<ChatCubit, ChatState>(
            buildWhen: (_, next) {
            return
              next.status == BlocStatus.chatMessagesLoaded
                || next.status == BlocStatus.chatMessagesLoadInProgress;
            },
            bloc: state.chatCubit,
            builder: (context, chatState) {

              if(chatState.status == BlocStatus.chatMessagesLoadInProgress) {
                return const SharedCircularLoader();
              }

              if (chatState.status == BlocStatus.chatMessagesLoaded) {

                if(chatState.chats.isEmpty) {
                  return  Center(
                    child: Text('No messages found...',style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),),
                  );
                }

            return ListView.separated(
              controller: state._chatScrollController,
              padding: const EdgeInsets.only(bottom: 20),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              reverse: true,
              itemBuilder: (ctx, index) {
                final item = chatState.chats[index];
                final DateTime dateTimeFromServerTimeStamp =
                DateTime.fromMillisecondsSinceEpoch(item['sentAt']);
                DateTime now = dateTimeFromServerTimeStamp;
                String formattedDate =
                DateFormat('MMM d, y  hh:mm a').format(now);
                return Column(
                   mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: item['sentBy'] == "driver" ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                   children: [
                     BubbleSpecialThree(
                       text: item['message'] as String,
                       color: item['sentBy'] == "driver" ? const Color(0xFF1B97F3) : const Color(0xFFE8E8EE),
                          tail: true,
                          textStyle: TextStyle(
                              color: item['sentBy'] == "driver"
                                  ? Colors.white
                                  : kAppBlack,
                              fontSize: 16),
                          isSender: item['sentBy'] == "driver",
                        ),
                        const SizedBox(
                          height: 0,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  formattedDate,
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(fontSize: 10),
                                ),
                                if (item['sentBy'] == "driver") ...{
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (item['read'] as bool) ...{
                                    const Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: kAppGreen,
                                    )
                                  } else ...{
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 12,
                                      color: theme.textTheme.bodySmall?.color,
                                    )
                                  }
                                }
                              ],
                            )),
                      ],
                    );
                  },
                  itemCount: chatState.chats.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                );
              }


              return const SizedBox.shrink();
            },
          ),
        ));
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class ChatHomePageController extends State<ChatHomePage> {
  final focusNode = FocusNode();
  final _messageController = TextEditingController();
  final ValueNotifier<bool> showSubmitButton = ValueNotifier(false);
  final _chatScrollController = ScrollController();
  late ChatCubit chatCubit;
  late NotificationCubit notificationCubit;

  @override
  Widget build(BuildContext context) => _ChatHomePageView(this);

  @override
  void initState() {
    super.initState();
    // focusNode.requestFocus();

    chatCubit = context.read<ChatCubit>();
    chatCubit.listenToChatMessages();

    notificationCubit = context.read<NotificationCubit>();
    notificationCubit.markNotificationsAsRead();

  }

  void chatEditorTextChangeHandler(String value) {
    if (value.isNotEmpty && !showSubmitButton.value) {
      showSubmitButton.value = true;
    }

    if (value.isEmpty && showSubmitButton.value) {
      showSubmitButton.value = false;
    }
  }

  void sendMessage() async {
    debugPrint("send message pressed");

    final message = _messageController.text;
    if (message.isEmpty) {
      return;
    }

    _messageController.text = "";

    chatCubit.sendMessage(message: message);
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
    _messageController.dispose();
  }
}
