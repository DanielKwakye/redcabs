// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReceiptStateCWProxy {
  ReceiptState status(BlocStatus status);

  ReceiptState message(String message);

  ReceiptState data(List<ReceiptModel>? data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptState call({
    BlocStatus? status,
    String? message,
    List<ReceiptModel>? data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReceiptState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReceiptState.copyWith.fieldName(...)`
class _$ReceiptStateCWProxyImpl implements _$ReceiptStateCWProxy {
  const _$ReceiptStateCWProxyImpl(this._value);

  final ReceiptState _value;

  @override
  ReceiptState status(BlocStatus status) => this(status: status);

  @override
  ReceiptState message(String message) => this(message: message);

  @override
  ReceiptState data(List<ReceiptModel>? data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiptState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiptState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiptState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return ReceiptState(
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
          : data as List<ReceiptModel>?,
    );
  }
}

extension $ReceiptStateCopyWith on ReceiptState {
  /// Returns a callable class that can be used as follows: `instanceOfReceiptState.copyWith(...)` or like so:`instanceOfReceiptState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReceiptStateCWProxy get copyWith => _$ReceiptStateCWProxyImpl(this);
}
