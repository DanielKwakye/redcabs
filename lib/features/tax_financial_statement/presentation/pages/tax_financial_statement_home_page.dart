import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/loading_placeholder_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_sliver_app_bar.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/data/store/tax_cubit.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/data/store/tax_state.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/storage/app_storage.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/pages/select_date_range_page.dart';
import '../../../shared/presentation/widgets/shared_border_widget.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';

class TaxFinancialStatementHomePage extends StatefulWidget {
  const TaxFinancialStatementHomePage({Key? key}) : super(key: key);

  @override
  TaxFinancialStatementHomePageController createState() =>
      TaxFinancialStatementHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _TaxFinancialStatementHomePageView extends WidgetView<
    TaxFinancialStatementHomePage, TaxFinancialStatementHomePageController> {
  const _TaxFinancialStatementHomePageView(
      TaxFinancialStatementHomePageController state)
      : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SharedSliverAppBar(
          pageTitle: 'Tax financial statement',
          backgroundColor: kAppRed,
          pageTitleColor: kAppWhite,
          centerTitle: false,
          iconThemeColor: kAppWhite,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0, left: 5),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Summary',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SharedTextFieldWidget(
                  label: 'Select date range',
                  placeHolder: '',
                  controller: state.dateController,
                  readOnly: true,
                  onTap: state.changeDateHandler,
                  suffix: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              BlocBuilder<TaxCubit, TaxState>(
                  bloc: state._taxCubit,
                  builder: (ctx, taxState) {
                    if (taxState.status == BlocStatus.success) {
                      // if (state.taxData['output']['bSort']['b17sTotal'] > 0) {
                      //   return Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 15, right: 15, top: 10, bottom: 10),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Icon(
                      //           FeatherIcons.creditCard,
                      //           color: Colors.blueAccent,
                      //           size: 20,
                      //         ),
                      //         const SizedBox(
                      //           height: 15,
                      //         ),
                      //         Text(
                      //           toCurrencyFormat(state.taxData['output']['bSort']
                      //                       ['b17sTotal']
                      //                   .toString())
                      //               .toString(),
                      //           textAlign: TextAlign.right,
                      //           style: theme.textTheme.titleMedium
                      //               ?.copyWith(fontWeight: FontWeight.w700),
                      //         ),
                      //         const SizedBox(
                      //           height: 2,
                      //         ),
                      //         Text(
                      //           'B Soort',
                      //           style: theme.textTheme.bodyMedium
                      //               ?.copyWith(fontSize: 12),
                      //         )
                      //       ],
                      //     ),
                      //   );
                      // }
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: theme.colorScheme.outline),
                            borderRadius: BorderRadius.circular(8),
                            // color: theme.colorScheme.surface.withOpacity(0.5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            FeatherIcons.creditCard,
                                            color: Colors.blueAccent,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            toCurrencyFormat(state
                                                    .taxData['output']['bSort']
                                                        ['b17sTotal']
                                                    .toString())
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'B Soort',
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(fontSize: 12),
                                          )
                                        ],
                                      )),
                                      Container(
                                        width: 1,
                                        color: theme.colorScheme.outline,
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: ()=>state.checkIfOwing('R Soort overige bedrijfskosten'),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            const Icon(
                                              FeatherIcons.download,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(state.taxData['output']['bSort']['b17sTotal'] <0?'xxxx':
                                              toCurrencyFormat(state
                                                      .taxData['output']
                                                          ['rSort']
                                                          ['costSubTotal']
                                                      .toString())
                                                  .toString(),
                                              textAlign: TextAlign.right,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'R Soort',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(fontSize: 12),
                                            ),
                                            Text(
                                              'overige bedrijfskosten',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                const SharedBorderWidget(
                                  paddingTop: 20,
                                  paddingBottom: 20,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: (){
                                          state.checkIfOwing('R Soort Omzet');
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FeatherIcons.upload,
                                              color: Color(0xffe15b5f),
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(state.taxData['output']['bSort']['b17sTotal'] <0 ?'xxxx':
                                              toCurrencyFormat(state
                                                      .taxData['output']
                                                          ['rSort']
                                                          ['incomeSubTotal']
                                                      .toString())
                                                  .toString(),
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'R Soort',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 12),
                                            ),
                                            Text(
                                              'Omzet',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      )),
                                      Container(
                                        width: 1,
                                        color: theme.colorScheme.outline,
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: ()=>state.checkIfOwing('Grand Total'),
                                            child: Column(
                                        crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                        children: [
                                            const Icon(
                                              FeatherIcons.creditCard,
                                              color: Color(0xffe15b5f),
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(state.taxData['output']['bSort']['b17sTotal'] <0 ?'xxxx':
                                              toCurrencyFormat(state
                                                      .taxData['output']
                                                          ['grandTotal']
                                                      .toString())
                                                  .toString(),
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Grand Total',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(),
                                            )
                                        ],
                                      ),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return const LoadingPlaceholderWidget();
                  }),
            ],
          ),
        )
      ],
    ));
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class TaxFinancialStatementHomePageController
    extends State<TaxFinancialStatementHomePage> {
  late TaxCubit _taxCubit;
  late StreamSubscription<TaxState> listener;

  String driver = '';
  dynamic taxData;

  final dateController = TextEditingController();
  String startDate = '';
  String displayStartDate = '';
  String endDate = '';
  String displayEndDate = '';

  @override
  Widget build(BuildContext context) =>
      _TaxFinancialStatementHomePageView(this);

  @override
  void initState() {
    super.initState();

    final user = AppStorage.currentUserSession!;
    startDate = user.startWeek!;
    displayStartDate = DateFormat('dd MMM, yyyy').format(DateTime.parse(user.startWeek!));
    endDate = user.endWeek!;
    displayEndDate = DateFormat('dd MMM, yyyy').format(DateTime.parse(user.endWeek!));
    dateController.text = "$displayStartDate - $displayEndDate";

    _taxCubit = context.read<TaxCubit>();
    listener = _taxCubit.stream.listen((event) async {
      if (event.status == BlocStatus.error) {
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.success) {
        taxData = event.data;
      }
    });
    fetchTax();
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
    dateController.dispose();
  }

  Future<void> fetchTax() async {
    _taxCubit.fetchTax(driver: driver, startDate: startDate, endDate: endDate);
  }

  void changeDateHandler() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor:  Colors.transparent,
      builder: (c) =>  GestureDetector(
        onTap: () => context.pop(),
        behavior: HitTestBehavior.opaque,
        child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            // minChildSize: 0.9,
            maxChildSize: 0.9,
            builder: (_ , controller) {
              return  SelectDateRangePage(onDatePicked: onDateChanged,);
            }
        ),
      ),
      // bounce: true
      // useRootNavigator: true,
      // expand: false
    );
  }

  // when another date is selected
  void onDateChanged(PickerDateRange? datePicked) {
    if(datePicked == null) return;

    startDate = DateFormat('yyyy-MM-dd').format(datePicked.startDate!);
    displayStartDate =
        DateFormat('dd MMM, yyyy').format(datePicked.startDate!);
    endDate = DateFormat('yyyy-MM-dd').format(datePicked.endDate!);
    displayEndDate = DateFormat('dd MMM, yyyy').format(datePicked.endDate!);

    dateController.text = "$displayStartDate - $displayEndDate";

    fetchTax();

  }


   checkIfOwing(type){
    if(taxData['output']['bSort']['b17sTotal']< 0){
      showSnackBar(context, 'The value of $type cannot be displayed because your B Soort is negative',appearance: Appearance.error);
    }

  }
}
