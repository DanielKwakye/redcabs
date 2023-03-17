// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rental_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RentalStateCWProxy {
  RentalState status(BlocStatus status);

  RentalState message(String message);

  RentalState data(List<CarModel> data);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RentalState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RentalState(...).copyWith(id: 12, name: "My name")
  /// ````
  RentalState call({
    BlocStatus? status,
    String? message,
    List<CarModel>? data,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRentalState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRentalState.copyWith.fieldName(...)`
class _$RentalStateCWProxyImpl implements _$RentalStateCWProxy {
  const _$RentalStateCWProxyImpl(this._value);

  final RentalState _value;

  @override
  RentalState status(BlocStatus status) => this(status: status);

  @override
  RentalState message(String message) => this(message: message);

  @override
  RentalState data(List<CarModel> data) => this(data: data);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RentalState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RentalState(...).copyWith(id: 12, name: "My name")
  /// ````
  RentalState call({
    Object? status = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
  }) {
    return RentalState(
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
          : data as List<CarModel>,
    );
  }
}

extension $RentalStateCopyWith on RentalState {
  /// Returns a callable class that can be used as follows: `instanceOfRentalState.copyWith(...)` or like so:`instanceOfRentalState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RentalStateCWProxy get copyWith => _$RentalStateCWProxyImpl(this);
}
