import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/data/store/tax_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';
import '../repository/tax_repository.dart';

class TaxCubit extends Cubit<TaxState> {
  TaxCubit() : super(const TaxState());
  final TaxRepository _taxRepository = sl<TaxRepository>();
  final user = AppStorage.currentUserSession;

  void fetchTax({required String driver, required String startDate, required String endDate}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either =
      await _taxRepository.fetchTax(driver: user, startDate: startDate, endDate: endDate);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.error, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.success, data: r));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.error, message: e.toString()));
    }
  }


}
