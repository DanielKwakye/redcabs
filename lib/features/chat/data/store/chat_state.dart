import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';

part "chat_state.g.dart";

@CopyWith()
class ChatState extends Equatable {
  final BlocStatus status;
  final String message;
  final List<dynamic> chats;

  const ChatState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.chats = const []
  });

  @override
  List<Object?> get props => [status];

}