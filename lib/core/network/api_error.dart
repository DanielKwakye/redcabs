import 'package:dio/dio.dart';
import 'package:redcabs_mobile/core/network/api_error_model.dart';

import 'api_error_model.dart';

class ApiError {
  late String errorDescription;
  ApiErrorModel? apiErrorModel;
  int? errorCode;

  ApiError({required this.errorDescription, this.errorCode});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  void _handleError(Object error) {
    if (error is DioError) {
      var dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = "Request was cancelled";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection";
          break;
        case DioErrorType.unknown:
          if (dioError.response!.statusCode == 401) {
            errorDescription = 'Session timeout';
          } else if (dioError.response!.statusCode == 400 || dioError.response!.statusCode! <= 409) {

            errorDescription = extractDescriptionFromResponse(error.response);
          }else if(dioError.response!.statusCode == 500){
            errorDescription = 'A Server Error Occurred';
          } else {
            errorDescription = 'Something went wrong, please check your internet connection..';
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection";
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = "Connection timeout";
          break;
        case DioErrorType.badCertificate:
          errorDescription = "Bad certificate";
          break;
        case DioErrorType.badResponse:
          errorDescription = "Bad response";
          break;
        case DioErrorType.connectionError:
          errorDescription = "Unable to connect";
          break;
      }
    } else {
      errorDescription = "An unexpected error occurred";
    }
  }

  String extractDescriptionFromResponse(Response? response) {
    var message = '';

    var decodeResponse = response!.data;
    try {
      if (response.data != null ) {
        if(decodeResponse is String ){
          message = decodeResponse;
        }else{
          message = decodeResponse['error'];
        }

      } else {
        message = response.statusMessage!;
      }
    } catch (error) {
      message = response.statusMessage ?? error.toString();
    }
    return message;
  }

  @override
  String toString() => errorDescription;
}
