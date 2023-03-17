import 'dart:async';
import 'dart:ui' as ui;

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/payouts/data/store/payout_cubit.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_sliver_app_bar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../app/routing/route_constants.dart';
import '../../../../core/storage/app_storage.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../shared/presentation/pages/select_date_range_page.dart';
import '../../../shared/presentation/widgets/loading_placeholder_widget.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';
import '../../data/store/payout_state.dart';

class WeeklyPayoutHomePage extends StatefulWidget {
  const WeeklyPayoutHomePage({Key? key}) : super(key: key);

  @override
  PayoutHomePageController createState() => PayoutHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _PayoutHomePageView
    extends WidgetView<WeeklyPayoutHomePage, PayoutHomePageController> {
  const _PayoutHomePageView(PayoutHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SharedSliverAppBar(
                  pageTitle: '',
                  backgroundColor: kAppRed,
                  pageTitleColor: kAppWhite,
                  centerTitle: false,
                  iconThemeColor: kAppWhite,
                  pinned: true,
                ),
                // const HomeAppBarWidget(),
              ];
            },
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 0, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<PayoutCubit, PayoutState>(
                          bloc: state._payoutCubit,
                          builder: (ctx, payOutState) {
                            if (payOutState.status == BlocStatus.success) {
                              return TextButton.icon(
                                onPressed: state.showPayoutsForGivenWeek,
                                label: Text(
                                  'Payout 1 out of ${state.payoutData.length == 0 ? 1 : state.payoutData.length}',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: theme.colorScheme.onBackground,
                                  size: 20,
                                ),
                              );
                            }
                            return TextButton.icon(
                              onPressed: () {},
                              label: Text(
                                'Payout 1 out of 1',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: theme.colorScheme.onBackground,
                                size: 20,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SharedTextFieldWidget(
                    label: 'Select week',
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
                BlocBuilder<PayoutCubit, PayoutState>(
                    bloc: state._payoutCubit,
                    builder: (ctx, payOutState) {
                      if (payOutState.status == BlocStatus.success) {
                        if (state.payoutData.length < 1) {
                          return Center(
                            child: Text(
                              'No payout at the moment...',
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                            ),
                          );
                        }
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
                                              state.payoutData[
                                                      state.payoutIndex]
                                                  ['selectedWeekBalance'],
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
                                              'To Bank',
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
                                          onTap: () {
                                            context.push(incomePreviewPageRoute,
                                                extra: {
                                                  'title': 'Income',
                                                  'total': state.payoutData[
                                                          state.payoutIndex][
                                                      'selectedWeekTotalIncome'],
                                                  'list': state.payoutData[
                                                          state.payoutIndex]
                                                      ['incomePayload'] as List
                                                });
                                          },
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
                                              Text(
                                                state.payoutData[
                                                        state.payoutIndex]
                                                    ['selectedWeekTotalIncome'],
                                                textAlign: TextAlign.right,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'Total income',
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(fontSize: 12),
                                              ),
                                              Text(
                                                'click for details',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 10,
                                                        color: kAppBlue),
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
                                          onTap: () {
                                            context.push(costPreviewPageRoute,extra: {
                                              'title':'Cost',
                                              'items':state.payoutData[state.payoutIndex]['costBreakDown'],
                                              'total':state.payoutData[state.payoutIndex]['selectedWeekTotalCost']
                                            });
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
                                              Text(
                                                state.payoutData[
                                                        state.payoutIndex]
                                                    ['selectedWeekTotalCost'],
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'Total cost',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(fontSize: 12),
                                              ),
                                              Text(
                                                'click for details',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                        fontSize: 10,
                                                        color: kAppBlue),
                                              )
                                            ],
                                          ),
                                        )),
                                        Container(
                                          width: 1,
                                          color: theme.colorScheme.outline,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '',
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              '',
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(),
                                            )
                                          ],
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
                      // return const LoadingPlaceholderWidget();
                      return const LoadingPlaceholderWidget();
                    }),
                BlocBuilder<PayoutCubit, PayoutState>(
                    bloc: state._payoutCubit,
                    builder: (ctx, payOutState) {
                      if (payOutState.status == BlocStatus.success) {
                        /// Arrears
                        if (state.payoutData.length > 0) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 20),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: theme.colorScheme.outline),
                                borderRadius: BorderRadius.circular(8),
                                // color: theme.colorScheme.surface.withOpacity(0.5)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 30, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Arrears',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: kAppRed),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(
                                                FeatherIcons.calendar,
                                                color: Colors.teal,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                state.payoutData[state
                                                                .payoutIndex][
                                                            'arrearsAfterPayout'] !=
                                                        null
                                                    ? toCurrencyFormat(state
                                                                    .payoutData[
                                                                state
                                                                    .payoutIndex]
                                                            [
                                                            'arrearsAfterPayout'])
                                                        .toString()
                                                    : 'N/A',
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'As at ${state.displayStartDate}',
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(fontSize: 12),
                                              )
                                            ],
                                          )),
                                          Container(
                                            width: 1,
                                            color: theme.colorScheme.outline,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                FeatherIcons.clock,
                                                color: Colors.orange,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                state.payoutData[state
                                                                .payoutIndex][
                                                            'arrearsBeforePayout'] !=
                                                        null
                                                    ? toCurrencyFormat(state
                                                                    .payoutData[
                                                                state
                                                                    .payoutIndex]
                                                            [
                                                            'arrearsBeforePayout'])
                                                        .toString()
                                                    : 'N/A',
                                                textAlign: TextAlign.right,
                                                style: theme
                                                    .textTheme.titleMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                'As at previous week',
                                                textAlign: TextAlign.right,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(fontSize: 12),
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }
                      return Container();
                    }),
              ],
            )));
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class PayoutHomePageController extends State<WeeklyPayoutHomePage> {
  late PayoutCubit _payoutCubit;
  late StreamSubscription<PayoutState> listener;

  String week = '';
  String displayStartDate = '';
  dynamic payoutData = [];
  Map<String, dynamic> payoutDetails = {};
  int payoutIndex = 0;

  final dateController = TextEditingController();
  String startDate = '';
  String endDate = '';
  String displayEndDate = '';

  // String transferToBank='';

  @override
  Widget build(BuildContext context) => _PayoutHomePageView(this);

  @override
  void initState() {
    super.initState();
    week = '2023-02-13';

    _payoutCubit = context.read<PayoutCubit>();
    listener = _payoutCubit.stream.listen((event) async {
      if (event.status == BlocStatus.error) {
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.success) {
        if (event.message != 'fetch_by_index') {
          payoutData.addAll(event.data?.toList());
          displayStartDate = event.message;
        }
      }
    });

    final user = AppStorage.currentUserSession!;
    startDate = user.startWeek!;
    displayStartDate =
        DateFormat('dd MMM, yyyy').format(DateTime.parse(user.startWeek!));
    endDate = user.endWeek!;
    displayEndDate =
        DateFormat('dd MMM, yyyy').format(DateTime.parse(user.endWeek!));
    dateController.text = "$displayStartDate - $displayEndDate";
    fetchPayoutSummary();
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
    dateController.dispose();
  }

  Future<void> fetchPayoutSummary() async {
    _payoutCubit.fetchPayout(week: startDate);
  }

  Widget _pageIconWidget({required Widget child}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(20)),
      child: Align(
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  void fetchPayoutByIndex() {
    _payoutCubit.fetchPayoutDataByIndex();
  }

  showPayoutsForGivenWeek() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.all(0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "There are ${payoutData.length} payout(s) for $displayStartDate",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(),
              // const SizedBox(height: 10,),
              ...payoutData.map((e) => ListTile(
                    leading: _pageIconWidget(
                        child: Text(
                      "${payoutData.indexOf(e) + 1}",
                      textAlign: TextAlign.center,
                    )),
                    title: Text("${e['dateCreated']}"),
                    subtitle: const Text(
                      "click to view",
                      style: TextStyle(color: primary),
                    ),
                    onTap: () {
                      payoutIndex = payoutData.indexOf(e);
                      fetchPayoutByIndex();
                      goBack(context);
                    },
                  ))
            ],
          ),
        );
      },
    );
  }

  void changeDateHandler() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (c) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.pop(),
        child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            // minChildSize: 0.9,
            maxChildSize: 0.9,
            builder: (_, controller) {
              return SelectDateRangePage(
                onDatePicked: onDateChanged,
                enforceWeekSelection: true,
              );
            }),
      ),
      // bounce: true
      // useRootNavigator: true,
      // expand: false
    );
  }

  // when another date is selected
  void onDateChanged(PickerDateRange? datePicked) {
    if (datePicked == null) return;

    startDate = DateFormat('yyyy-MM-dd').format(datePicked.startDate!);
    displayStartDate = DateFormat('dd MMM, yyyy').format(datePicked.startDate!);
    endDate = DateFormat('yyyy-MM-dd').format(datePicked.endDate!);
    displayEndDate = DateFormat('dd MMM, yyyy').format(datePicked.endDate!);

    dateController.text = "$displayStartDate - $displayEndDate";

    fetchPayoutSummary();
  }
}
