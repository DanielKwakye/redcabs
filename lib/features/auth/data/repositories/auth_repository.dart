import 'package:dartz/dartz.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/features/users/data/models/user_model.dart';
import 'package:redcabs_mobile/features/users/data/repositories/user_repository.dart';

class AuthRepository extends UserRepository {

  Future<Either<ApiError, String>> checkIfDossierExists(
      {required String dossier}) async {
    try {
      final path = ApiConfig.checkDossierExist;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {'dossier': dossier});

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        final enumValue = response.data['extra']['enum'];
        final phone = response.data['extra']['phone'];

        if(enumValue  == "PASSWORD_NOT_SET"){
          // password is not set ... user should start the process afresh
          return  Left(ApiError(errorDescription: "No password associated with dossier $dossier . Kindly contact admin"));
        }

        return Right(phone);


      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  /// this method gets information about the current user
  /// and saves to local storage

  Future<Either<ApiError, UserModel>> login(
      {required String email, required String password}) async {
    try {
      // set the token in local storage for subsequent requests
      final path = ApiConfig.login;
      final clientId = ApiConfig.clientId;
      final apiKey = ApiConfig.apiKey;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "grant_type": "password",
        "client_id": clientId,
        "client_secret": apiKey,
        "username": email,
        "password": password,
        "scope": ""
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        final data = response.data["extra"] as Map<String, dynamic>;

        final user = UserModel.fromJson(data);
        AppStorage.save(key: 'user-info', jsonValue: user.toJson());
        AppStorage.setAuthTokenVal(response.data["extra"]['access_token']);
        AppStorage.currentUserSession = user;

        return Right(user);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, String>> updateDriverInfo(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email}) async {
    try {
      final path = ApiConfig.updateDriverInfo;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }
        Map<String, dynamic>? data = {
          ...?AppStorage.currentUserSession?.toJson(),
          'email': email,
          'phone': phone,
          'name': firstName,
          'other_names':lastName,
        };

        final user = UserModel.fromJson(data);
        AppStorage.save(key: 'user-info', jsonValue: user.toJson());

        AppStorage.currentUserSession = user;

        return const Right('Successfully updated profile info');
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }


  Future<Either<ApiError, String?>> setDriverPasswordAtForgotPassword(
      {required String phone, required String dossier, required String password}) async {
    try {
      final path = ApiConfig.setDriverPasswordAtForgotPassword;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
            'phone': phone,
            'dossier': dossier,
            'password': password
      });

      if (response!.statusCode == 200) {

        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return  Right(response.data["message"]);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }


  Future<Either<ApiError, String?>> updateDriverPassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      final path = ApiConfig.updateDriverPassword;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "current_password": currentPassword,
        "new_password": newPassword
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return  Right(response.data["message"]);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, String?>> registerDriver(
      {required String firstName,
      required String otherNames,
      required String phone,
      required String email,
      required String password}) async {
    try {
      // register prospective driver
      final path = ApiConfig.registerDriver;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "name": firstName,
        "otherNames": otherNames,
        "phone": phone,
        "email": email,
        "password": password
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return const Right("Registration successful");
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, String?>> checkIfDriverExist(
      {required String email, required String phone}) async {
    try {
      // set the token in local storage for subsequent requests
      final path = ApiConfig.verifyAccount;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "email": email,
        "phone": phone,
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return const Right("done");
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, String?>> sendVerificationCode(
      {required String phone}) async {
    try {
      // set the token in local storage for subsequent requests
      final path = ApiConfig.sendVerificationCode;

      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "phone": phone,
      });

      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return Right(response.data["extra"]['token']);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<Either<ApiError, dynamic>> verifyAuthCode(
      {required String code, required String token}) async {
    try {
      // set the token in local storage for subsequent requests
      final path = ApiConfig.verifyPhoneNumber;
      var response = await networkProvider
          .call(path: path, method: RequestMethod.post, body: {
        "token": token,
        "code": code,
      });
      if (response!.statusCode == 200) {
        if (!(response.data["status"] as bool)) {
          return Left(ApiError(errorDescription: response.data["message"]));
        }

        return Right(response.data["extra"]);
      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }
    } catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }
  }

  Future<bool> getCurrentLoggedInUser() async {
    final user = AppStorage.currentUserSession;
    if (user == null) {
      final Map<String, dynamic>? userInfo =
          await AppStorage.get(key: 'user-info');
      if (userInfo == null) {
        return false;
      }
      AppStorage.currentUserSession = UserModel.fromJson(userInfo);
      return true;
    }
    return true;
  }

  Future<void> logout() async {
    // remove user from session
    AppStorage.currentUserSession = null;

    // remove token
    await AppStorage.storage.deleteAll();

    // clear user details
    AppStorage.remove(key: kAuthUserKey);
  }
}
