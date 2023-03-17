import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/core/utils/injector.dart';
import 'package:redcabs_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:redcabs_mobile/features/auth/data/store/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = sl<AuthRepository>();

  AuthCubit() : super(const AuthState());

  void login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loginProgress));

      final either =
          await _authRepository.login(email: email, password: password);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.loginFailed, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.loginSuccessful, message: "Login successful."));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.loginFailed, message: e.toString()));
    }
  }

  void registerDriver(
      {required String firstName,
      required String otherNames,
      required String phone,
      required String email,
      required String password}) async {
    try {
      emit(state.copyWith(status: BlocStatus.registrationInProgress));

      final either = await _authRepository.registerDriver(
          firstName: firstName,
          otherNames: otherNames,
          phone: phone,
          email: email,
          password: password);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.registrationFailure,
            message: l.errorDescription));
      }, (r) {
        emit(
            state.copyWith(status: BlocStatus.registrationSuccess, message: r));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.registrationFailure, message: e.toString()));
    }
  }

  void updateDriverInfo(
      {required String firstName,
      required String lastName,
      required String phone,
      required String email}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _authRepository.updateDriverInfo(
          firstName: firstName, lastName: lastName, phone: phone, email: email);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.error, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.success,
            message: "Your profile has been updated successfully.."));
      });
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, message: e.toString()));
    }
  }

  void setDriverPasswordAtForgotPassword(
      {required String dossier, required String phone, required String password}) async {
    try {
      emit(state.copyWith(status: BlocStatus.setDriverPasswordInProgress));

      final either = await _authRepository.setDriverPasswordAtForgotPassword(
          dossier: dossier, phone: phone, password: password);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.setDriverPasswordError, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.setDriverPasswordSuccessful,
            message: r));
      });
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.setDriverPasswordError, message: e.toString()));
    }
  }

  void updateDriverPassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _authRepository.updateDriverPassword(
          currentPassword: currentPassword, newPassword: newPassword);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.error, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.success,
            message: r));
      });
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, message: e.toString()));
    }
  }

  void checkIfDriverExist(
      {required String email, required String phone}) async {
    try {
      emit(state.copyWith(status: BlocStatus.checkDriverExistProgress));

      final either =
          await _authRepository.checkIfDriverExist(email: email, phone: phone);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.checkDriverExistFailure,
            message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(status: BlocStatus.checkDriverExistSuccess));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.checkDriverExistFailure, message: e.toString()));
    }
  }

  void sendVerificationCode({required String phone, bool resend = false}) async {
    try {
      emit(state.copyWith(status: resend ? BlocStatus.resendVerificationInProgress : BlocStatus.verificationInProgress));

      final either = await _authRepository.sendVerificationCode(phone: phone);

      either.fold((l) {
        emit(state.copyWith(
            status: resend ? BlocStatus.resendVerificationError : BlocStatus.verificationError, message: l.errorDescription));
      }, (r) {
        emit(
            state.copyWith(
                status: resend ? BlocStatus.resendVerificationSuccess : BlocStatus.verificationSuccess,
                message: r
            ));
      });
    } catch (e) {
      emit(state.copyWith(
          status: resend ? BlocStatus.resendVerificationError : BlocStatus.verificationError, message: e.toString()));
    }
  }

  void verifyAuthCode({required String code, required String token}) async {
    try {
      emit(state.copyWith(status: BlocStatus.otpVerificationInProgress));

      final either =
          await _authRepository.verifyAuthCode(code: code, token: token);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.otpVerificationInError, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.otpVerificationInSuccessful,
            message: 'Verification successful'));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.otpVerificationInError, message: e.toString()));
    }
  }

  void logout() {
    emit(state.copyWith(status: BlocStatus.logOutInProgress));
    _authRepository.logout();
    emit(state.copyWith(status: BlocStatus.logOutUser));
  }

  void checkIfDossierExist({required String dossier}) async {
    try {

      emit(state.copyWith(status: BlocStatus.checkingDossierInProgress));

      final either =
      await _authRepository.checkIfDossierExists(dossier: dossier);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.checkingDossierError, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.checkingDossierSuccessful, message: r));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.checkingDossierError, message: e.toString()));
    }
  }

}
