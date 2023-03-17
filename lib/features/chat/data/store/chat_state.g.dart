// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatStateCWProxy {
  ChatState status(BlocStatus status);

  ChatState message(String message);

  ChatState chats(List<dynamic> chats);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatState(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatState call({
    BlocStatus? status,
    String? message,
    List<dynamic>? chats,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChatState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChatState.copyWith.fieldName(...)`
class _$ChatStateCWProxyImpl implements _$ChatStateCWProxy {
  const _$ChatStateCWProxyImpl(this._value);

  final ChatState _value;

  @override
  ChatState status(BlocStatus status) => this(status: status);

  @override
  ChatState message(String message) => this(message: message);

  @override
  ChatState chats(List<dynamic> chats) => this(chats: chats);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChatState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChatState(...).copyWith(id: 12, name: "My name")
  /// ````
  ChatState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? chats = const $CopyWithPlaceholder(),
  }) {
    return ChatState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BlocStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      chats: chats == const $CopyWithPlaceholder() || chats == null
          ? _value.chats
          // ignore: cast_nullable_to_non_nullable
          : chats as List<dynamic>,
    );
  }
}

extension $ChatStateCopyWith on ChatState {
  /// Returns a callable class that can be used as follows: `instanceOfChatState.copyWith(...)` or like so:`instanceOfChatState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatStateCWProxy get copyWith => _$ChatStateCWProxyImpl(this);
}
