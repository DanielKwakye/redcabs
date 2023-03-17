import 'package:dartz/dartz.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';

class InvoiceRepository extends UserRepository {
  Future<Either<ApiError, dynamic>> fetchInvoices(
      {String? status, required String? purpose}) async {
    try {
      final user = AppStorage.currentUserSession;
      final path = ApiConfig.fetchInvoices;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: {
            "status": status,
            "purpose": purpose,
            "driverUserId": user?.id
          });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        return Right(response.data['extra']);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }
}
