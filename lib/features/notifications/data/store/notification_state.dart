import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import '../data/models/notification_model.dart';

part 'notification_state.g.dart';

@CopyWith()
class NotificationState extends Equatable {

  final BlocStatus status;
  final String message;
  final List<NotificationModel> notifications;
  final int notificationsCount;

  const NotificationState({
    this.status = BlocStatus.initial,
    this.message = '',
    this.notifications = const [],
    this.notificationsCount = 0,
  });

  @override
  List<Object?> get props => [status];

}
