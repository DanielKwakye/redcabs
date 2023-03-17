import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/rentals/data/models/car_model.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';

class RentalRepository extends UserRepository {

  Future<Either<ApiError, List<CarModel>>> fetchAvailableCars() async {
    try {
      final path = ApiConfig.fetchAvailableCars;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.get,
         );

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }
        final rentalResponse = List<CarModel>.from(response.data['extra'].map((x) => CarModel.fromJson(x)));
        return Right(rentalResponse);

      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }
  Future<Either<ApiError, List<CarModel>>> fetchMyRentedCars() async {
    try {
      final path = ApiConfig.fetchMyRentedCars;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.get,
         );

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }
        final rentalResponse = List<CarModel>.from(response.data['extra'].map((x) => CarModel.fromJson(x)));
        return Right(rentalResponse);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }
}
