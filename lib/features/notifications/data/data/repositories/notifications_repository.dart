import 'package:dartz/dartz.dart';
import 'package:redcabs_mobile/features/notifications/data/data/models/notification_model.dart';

import '../../../../../core/network/api_config.dart';
import '../../../../../core/network/api_error.dart';
import '../../../../../core/network/network_provider.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/injector.dart';

class NotificationsRepository {

  final networkProvider = sl<NetworkProvider>();

  Future<Either<ApiError, List<NotificationModel>>> fetchNotifications() async {
    try {

      final path = ApiConfig.fetchNotifications;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.get);

      if (response!.statusCode == 200) {

        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        final notificationListResponse = List<NotificationModel>.from(response.data['extra'].map((x) => NotificationModel.fromJson(x)));
        return Right(notificationListResponse);


      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, int>> fetchNotificationsCount() async {

    try {

      final path = ApiConfig.fetchNotificationsCount;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.get,);

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        final notificationCountResponse = response.data['extra'] as int;
        return Right(notificationCountResponse);


      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, void>> markNotificationsAsRead({String type = "campaign", String id = ""}) async {
    try {

      final path = ApiConfig.setNotificationsRead;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: {
            'type': type,
            'id': id
          });

      if (response!.statusCode == 200) {

        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        return const Right(null);


      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

}