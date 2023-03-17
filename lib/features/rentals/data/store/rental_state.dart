
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:redcabs_mobile/features/rentals/data/models/car_model.dart';

import '../../../../core/utils/enums.dart';

part "rental_state.g.dart";

@CopyWith()
class RentalState extends Equatable {

  final BlocStatus status;
  final String message;
  final List<CarModel> data;

  const RentalState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.data = const [],
  });

  @override
  List<Object?> get props => [status, message,data];
}
