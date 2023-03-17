import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';

part "payout_state.g.dart";

@CopyWith()
class PayoutState extends Equatable {

  final BlocStatus status;
  final String message;
  final List<dynamic>? data;

  const PayoutState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.data,
  });

  @override
  List<Object?> get props => [status, message,data];

}
