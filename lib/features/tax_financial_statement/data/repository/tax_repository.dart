
import 'package:dartz/dartz.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/users/data/models/user_model.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';

class TaxRepository extends UserRepository {

  Future<Either<ApiError, dynamic>> fetchTax({required UserModel? driver, required String startDate, required String endDate}) async {
    try{

      final path = ApiConfig.fetchTax;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: {
            'drivers': [driver],
            'date_range': [startDate, endDate],
            'usePeriods': false
          }
      );

      if(response!.statusCode == 200){

        if(!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        return Right(response.data['extra']);

      }else {

        return Left(ApiError(errorDescription: kDefaultErrorText));

     }



    }catch(e){
      return Left(ApiError(errorDescription: e.toString()));
    }


  }

}