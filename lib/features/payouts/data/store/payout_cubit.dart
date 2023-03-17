import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:redcabs_mobile/features/payouts/data/store/payout_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';
import '../repositories/payout_repository.dart';


class PayoutCubit extends Cubit<PayoutState> {
  final PayoutRepository _payoutRepository = sl<PayoutRepository>();
  PayoutCubit() : super(const PayoutState());

  void fetchPayout({required String week}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either =
      await _payoutRepository.fetchPayout(week);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.error, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(
            status: BlocStatus.success, data: r['extra'], message: r['message']));
      });
    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.error, message: e.toString()));
    }
  }

  void fetchPayoutDataByIndex() async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      emit(state.copyWith(
          status: BlocStatus.success,message: 'fetch_by_index'));


    } catch (e) {
      emit(state.copyWith(
          status: BlocStatus.error, message: e.toString()));
    }
  }


}
