import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/receipts/data/models/receipt_model.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';
import 'package:path/path.dart' as p;

class ReceiptRepository extends UserRepository {

  Future<Either<ApiError, List<ReceiptModel>>> fetchReceipts({String? from, String? to}) async {
    try{

      final path = ApiConfig.fetchReceipts;

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: {
            'start_date': from,
            'end_date': to
          }
      );

      if(response!.statusCode == 200){

        if(!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        final receiptsResponse = List<ReceiptModel>.from(response.data['extra'].map((x) => ReceiptModel.fromJson(x)));
        return Right(receiptsResponse);

      }else {

        return Left(ApiError(errorDescription: kDefaultErrorText));

     }



    }catch(e){
      return Left(ApiError(errorDescription: e.toString()));
    }


  }
  Future<Either<ApiError, dynamic>> uploadReceipt({required File file}) async {
    try{

      final path = ApiConfig.uploadReceipt;

      Map<String,dynamic> uploadData = {
        "file_type": 'cost',
        "file_title": 'Receipt',
        "file": await MultipartFile.fromFile(file.path),
      };

      FormData formData = FormData.fromMap(uploadData);

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.post,
          body: formData
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