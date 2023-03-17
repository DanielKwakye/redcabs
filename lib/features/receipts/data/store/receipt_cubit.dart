import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:redcabs_mobile/features/receipts/data/store/receipt_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';
import '../repository/receipt_repository.dart';


class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(const ReceiptState());

  final ReceiptRepository _receiptRepository = sl<ReceiptRepository>();

  void fetchReceipts({String? from, String? to}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either =
      await _receiptRepository.fetchReceipts(from:from,to:to);

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
  void uploadReceipt({required File file}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _receiptRepository.uploadReceipt(file: file);

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
