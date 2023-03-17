// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PayoutStateCWProxy {
  PayoutState status(BlocStatus status);

  PayoutState message(String message);

  PayoutState data(List<dynamic>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayoutState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayoutState(...).copyWith(id: 12, name: "My name")
  /// ````
  PayoutState call({
    BlocStatus? status,
    String? message,
    List<dynamic>? data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPayoutState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPayoutState.copyWith.fieldName(...)`
class _$PayoutStateCWProxyImpl implements _$PayoutStateCWProxy {
  const _$PayoutStateCWProxyImpl(this._value);

  final PayoutState _value;

  @override
  PayoutState status(BlocStatus status) => this(status: status);

  @override
  PayoutState message(String message) => this(message: message);

  @override
  PayoutState data(List<dynamic>? data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PayoutState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PayoutState(...).copyWith(id: 12, name: "My name")
  /// ````
  PayoutState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return PayoutState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BlocStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<dynamic>?,
    );
  }
}

extension $PayoutStateCopyWith on PayoutState {
  /// Returns a callable class that can be used as follows: `instanceOfPayoutState.copyWith(...)` or like so:`instanceOfPayoutState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PayoutStateCWProxy get copyWith => _$PayoutStateCWProxyImpl(this);
}
