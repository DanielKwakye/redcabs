import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/rentals/data/store/rental_cubit.dart';
import 'package:redcabs_mobile/features/rentals/data/store/rental_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/shared_network_image_widget.dart';

class AllCarsWidget extends StatefulWidget {
  const AllCarsWidget({Key? key}) : super(key: key);

  @override
  AvailableCarsWidgetController createState() =>
      AvailableCarsWidgetController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _AvailableCarsWidgetView
    extends WidgetView<AllCarsWidget, AvailableCarsWidgetController> {
  const _AvailableCarsWidgetView(AvailableCarsWidgetController state)
      : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return BlocBuilder<RentalCubit, RentalState>(
        bloc: state._rentalCubit,
        builder: (ctx, rentalState) {
          if (rentalState.status == BlocStatus.success) {
            final pairsCount =( rentalState.data.length / 2).ceil();
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline),
                    // borderRadius: BorderRadius.circular(8),
                    color: theme.colorScheme.outline),
                child: LayoutGrid(
                  // set some flexible track sizes based on the crossAxisCount
                  columnSizes: [1.fr, 1.fr],
                  // set all the row sizes to auto (self-sizing height)
                  rowSizes: List.generate(pairsCount, (index) => auto),
                  rowGap: 5,
                  // equivalent to mainAxisSpacing
                  columnGap: 5,
                  // equivalent to crossAxisSpacing
                  // note: there's no childAspectRatio
                  children: [
                    // render all the cards with *automatic child placement*
                    ...rentalState.data.map((car) {
                      return GestureDetector(
                        onTap: () {
                          context.push(rentalsDetailsPageRoute, extra: {
                            'list': rentalState.data,
                            'initialPageIndex': rentalState.data.indexOf(car)
                          });
                        },
                        child:
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              // borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SharedNetworkImageWidget(imageUrl: car.mainImage ?? "",fit: BoxFit.fill),
                              Align(
                                alignment: Alignment.center,
                                  child: Text(car.name ?? '')),
                               Chip(label:  Text(car.status == "available" ? "Available" : "Not Available",style: theme.textTheme.bodySmall
                                   ?.copyWith(fontSize: 11,color: Colors.white)),
                                 backgroundColor: car.status== "available" ? Colors.green : const Color(0xff000000))
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            );
          }
          return LayoutGrid(
            // set some flexible track sizes based on the crossAxisCount
            columnSizes: [1.fr, 1.fr],
            // set all the row sizes to auto (self-sizing height)
            rowSizes: const [auto, auto, auto],
            rowGap: 2,
            // equivalent to mainAxisSpacing
            columnGap: 2,
            // equivalent to crossAxisSpacing
            // note: there's no childAspectRatio
            children: [
              // render all the cards with *automatic child placement*
              ...state.carDetails.map((feature) {
                return Shimmer.fromColors(
                  baseColor: theme.colorScheme.outline,
                  highlightColor: theme.colorScheme.outline.withOpacity(0.5),
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: theme.colorScheme.outline),
                        // borderRadius: BorderRadius.circular(8),
                        color: theme.colorScheme.outline),
                  ),
                );
              })
            ],
          );
        });
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class AvailableCarsWidgetController extends State<AllCarsWidget> with AutomaticKeepAliveClientMixin {
  late RentalCubit _rentalCubit;
  late StreamSubscription<RentalState> listener;
  dynamic carDetails = List.generate(4, (index) => index);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _AvailableCarsWidgetView(this);
  }

  @override
  void initState() {
    super.initState();
    _rentalCubit = RentalCubit();
    listener = _rentalCubit.stream.listen((event) async {
      if (event.status == BlocStatus.error) {
        showSnackBar(context, event.message);
      }
    });
    fetchAllAvailableCars();
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  Future<void> fetchAllAvailableCars() async {
    _rentalCubit.fetchAvailableCars();
  }

  @override
  bool get wantKeepAlive => true;
}
