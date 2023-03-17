import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:redcabs_mobile/core/network/api_config.dart';
import 'package:redcabs_mobile/core/network/api_error.dart';
import 'package:redcabs_mobile/core/network/network_provider.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/core/utils/injector.dart';
import 'package:redcabs_mobile/features/users/data/models/user_model.dart';

class UserRepository {

  final networkProvider = sl<NetworkProvider>();

  Future<void> saveUserToLocalStorage(UserModel userModel, { String? key }) async {
    final json = userModel.toJson();
    json.remove('stories');
    AppStorage.save(key: key ?? userModel.id!, jsonValue: json);
  }

  Future<UserModel?> getUserFromLocalStorage({required String key}) async {
    final json = await AppStorage.get(key: key);
    if(json == null) return null;
    return UserModel.fromJson(json);
  }

  // api to connect to server for user profile
  Future<Either<ApiError, UserModel?>> _getUserProfileFromServer({String? userId}) async {

    try {

      final path = userId == null ? ApiConfig.userProfile : ApiConfig.getUserById(userId: userId);

      var response = await networkProvider.call(
          path: path,
          method: RequestMethod.get
      );

      if (response!.statusCode == 200) {

        if(!(response.data["success"] as bool)){
          return Left(ApiError(errorDescription: kDefaultErrorText));
        }

        final data = response.data["data"];

        final user = UserModel.fromJson(data);

        return Right(user);

      } else {
        return Left(ApiError(errorDescription: kDefaultErrorText));
      }


    }  on DioError catch (e) {
      return Left(ApiError(errorDescription: e.toString()));
    }


  }

  // fetch and update the current loggedIn user
  Future<Either<ApiError, UserModel?>> getCurrentLoggedInUserProfile() async {

    final either = await _getUserProfileFromServer();

    if(either.isRight()){
      // save user for future use, thus when user closes and reopens the app
      final user = either.getOrElse(() => null)!;
      saveUserToLocalStorage(user, key: kAuthUserKey);

      // keep user in current session
      AppStorage.currentUserSession = user;
      return Right(user);
    }

    // if results wasn't right, return left
    return Left(ApiError(errorDescription: kDefaultErrorText));
  }


  // method here to get another user's profile
  Future<Either<ApiError, UserModel?>> getSomeonesUserProfile({required String userId}) async {
    return _getUserProfileFromServer(userId: userId);
  }


}