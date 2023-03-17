import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

part 'tax_state.g.dart';

@CopyWith()
class TaxState extends Equatable {
  final BlocStatus status;
  final String message;
  final dynamic data;

  const TaxState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.data,
  });

  @override
  List<Object?> get props => [status, message,data];
}
