import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/features/notifications/data/data/repositories/notifications_repository.dart';
import '../../../../core/utils/injector.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {

  final notificationsRepository = sl<NotificationsRepository>();

  NotificationCubit() : super(const NotificationState());

  Future<void> fetchNotificationList() async {

    try{

      emit(state.copyWith(
        status: BlocStatus.fetchNotificationsInProgress
      ));

      final either = await notificationsRepository.fetchNotifications();

      either.fold((l) {
        emit(state.copyWith(
          status: BlocStatus.fetchNotificationsError,
          message: l.errorDescription
        ));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.fetchNotificationsSuccess,
            notifications: r
        ));
       }
      );


    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
          status: BlocStatus.fetchNotificationsError,
      ));
    }

  }

  void fetchNotificationCount() async {

    try{

      emit(state.copyWith(
          status: BlocStatus.fetchNotificationsCountInProgress
      ));

      final either = await notificationsRepository.fetchNotificationsCount();

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.fetchNotificationsCountError,
            message: l.errorDescription
        ));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.fetchNotificationsCountSuccess,
            notificationsCount: r
        ));
      }
      );


    }catch(e){
      emit(state.copyWith(
          message: e.toString(),
          status: BlocStatus.fetchNotificationsCountError,
      ));
    }

  }

  void markNotificationsAsRead({String type = "campaign", String id = ""}) async {

    try{

      emit(state.copyWith(
          status: BlocStatus.markNotificationsAsReadInProgress
      ));

      final either = await notificationsRepository.markNotificationsAsRead(type: type, id: id);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.markNotificationsAsReadError,
            message: l.errorDescription
        ));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.markNotificationsAsReadSuccess,
            notificationsCount: 0
        ));
      }
      );

    }catch(e){
      emit(state.copyWith(
          message: e.toString(),
          status: BlocStatus.markNotificationsAsReadError,
      ));
    }

  }

}
