// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TaxStateCWProxy {
  TaxState status(BlocStatus status);

  TaxState message(String message);

  TaxState data(dynamic data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaxState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaxState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaxState call({
    BlocStatus? status,
    String? message,
    dynamic data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTaxState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTaxState.copyWith.fieldName(...)`
class _$TaxStateCWProxyImpl implements _$TaxStateCWProxy {
  const _$TaxStateCWProxyImpl(this._value);

  final TaxState _value;

  @override
  TaxState status(BlocStatus status) => this(status: status);

  @override
  TaxState message(String message) => this(message: message);

  @override
  TaxState data(dynamic data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TaxState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TaxState(...).copyWith(id: 12, name: "My name")
  /// ````
  TaxState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return TaxState(
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

extension $TaxStateCopyWith on TaxState {
  /// Returns a callable class that can be used as follows: `instanceOfTaxState.copyWith(...)` or like so:`instanceOfTaxState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TaxStateCWProxy get copyWith => _$TaxStateCWProxyImpl(this);
}
