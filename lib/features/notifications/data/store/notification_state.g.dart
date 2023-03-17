// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationStateCWProxy {
  NotificationState status(BlocStatus status);

  NotificationState message(String message);

  NotificationState notifications(List<NotificationModel> notifications);

  NotificationState notificationsCount(int notificationsCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationState call({
    BlocStatus? status,
    String? message,
    List<NotificationModel>? notifications,
    int? notificationsCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationState.copyWith.fieldName(...)`
class _$NotificationStateCWProxyImpl implements _$NotificationStateCWProxy {
  const _$NotificationStateCWProxyImpl(this._value);

  final NotificationState _value;

  @override
  NotificationState status(BlocStatus status) => this(status: status);

  @override
  NotificationState message(String message) => this(message: message);

  @override
  NotificationState notifications(List<NotificationModel> notifications) =>
      this(notifications: notifications);

  @override
  NotificationState notificationsCount(int notificationsCount) =>
      this(notificationsCount: notificationsCount);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? notifications = const $CopyWithPlaceholder(),
    Object? notificationsCount = const $CopyWithPlaceholder(),
  }) {
    return NotificationState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BlocStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      notifications:
          notifications == const $CopyWithPlaceholder() || notifications == null
              ? _value.notifications
              // ignore: cast_nullable_to_non_nullable
              : notifications as List<NotificationModel>,
      notificationsCount: notificationsCount == const $CopyWithPlaceholder() ||
              notificationsCount == null
          ? _value.notificationsCount
          // ignore: cast_nullable_to_non_nullable
          : notificationsCount as int,
    );
  }
}

extension $NotificationStateCopyWith on NotificationState {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationState.copyWith(...)` or like so:`instanceOfNotificationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationStateCWProxy get copyWith =>
      _$NotificationStateCWProxyImpl(this);
}
