import 'package:redcabs_mobile/features/invoices/data/repository/invoice_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';
import 'package:redcabs_mobile/features/invoices/data/store/invoice_state.dart';


class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(const InvoiceState());

  final InvoiceRepository _invoiceRepository = sl<InvoiceRepository>();

  void fetchInvoices({String? status, required String purpose}) async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _invoiceRepository.fetchInvoices(
          status: status, purpose: purpose);

      either.fold((l) {
        emit(state.copyWith(
            status: BlocStatus.error, message: l.errorDescription));
      }, (r) {
        emit(state.copyWith(status: BlocStatus.success, data: r));
      });
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.error, message: e.toString()));
    }
  }
}
