
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/features/rentals/data/store/rental_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/injector.dart';
import '../repository/rental_repository.dart';

class RentalCubit extends Cubit<RentalState> {
  RentalCubit() : super(const RentalState());

  final RentalRepository _rentalRepository = sl<RentalRepository>();


  void fetchAvailableCars() async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _rentalRepository.fetchAvailableCars();

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
  void fetchMyRentedCars() async {
    try {
      emit(state.copyWith(status: BlocStatus.loading));

      final either = await _rentalRepository.fetchMyRentedCars();

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
