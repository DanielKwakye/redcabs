import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:redcabs_mobile/features/receipts/data/models/receipt_model.dart';
import '../../../../core/utils/enums.dart';

part "receipt_state.g.dart";

@CopyWith()
class ReceiptState extends Equatable {
  final BlocStatus status;
  final String message;
  final List<ReceiptModel>? data;

  const ReceiptState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.data,
  });

  @override
  List<Object?> get props => [status];
}
