// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InvoiceStateCWProxy {
  InvoiceState status(BlocStatus status);

  InvoiceState message(String message);

  InvoiceState data(dynamic data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InvoiceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InvoiceState(...).copyWith(id: 12, name: "My name")
  /// ````
  InvoiceState call({
    BlocStatus? status,
    String? message,
    dynamic data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInvoiceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInvoiceState.copyWith.fieldName(...)`
class _$InvoiceStateCWProxyImpl implements _$InvoiceStateCWProxy {
  const _$InvoiceStateCWProxyImpl(this._value);

  final InvoiceState _value;

  @override
  InvoiceState status(BlocStatus status) => this(status: status);

  @override
  InvoiceState message(String message) => this(message: message);

  @override
  InvoiceState data(dynamic data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InvoiceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InvoiceState(...).copyWith(id: 12, name: "My name")
  /// ````
  InvoiceState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return InvoiceState(
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as BlocStatus,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as dynamic,
    );
  }
}

extension $InvoiceStateCopyWith on InvoiceState {
  /// Returns a callable class that can be used as follows: `instanceOfInvoiceState.copyWith(...)` or like so:`instanceOfInvoiceState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InvoiceStateCWProxy get copyWith => _$InvoiceStateCWProxyImpl(this);
}
