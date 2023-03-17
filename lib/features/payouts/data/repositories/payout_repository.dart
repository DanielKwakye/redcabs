
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';

class PayoutRepository extends UserRepository {

  Future<Either<ApiError, dynamic>> fetchPayout(String week) async {
    try{

      final path = ApiConfig.fetchPayoutOverviewHistory;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: {
            'week': week
          }
      );

      if(response!.statusCode == 200){

        if(!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        return Right(response.data);

      }else {

        return Left(ApiError(errorDescription: kDefaultErrorText));

     }



    }catch(e){
      return Left(ApiError(errorDescription: e.toString()));
    }


  }

}