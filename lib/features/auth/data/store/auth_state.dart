import 'package:equatable/equatable.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_state.g.dart';

@CopyWith()
class AuthState extends Equatable {

  final BlocStatus status;
  final String message;

  const AuthState({
    this.status = BlocStatus.initial,
    this.message = ''
  });

  @override
  List<Object?> get props => [status];

}
