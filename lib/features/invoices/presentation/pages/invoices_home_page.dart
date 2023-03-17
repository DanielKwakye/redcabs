import 'dart:async';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/invoices/data/models/invoice_purpose.dart';
import 'package:redcabs_mobile/features/invoices/data/models/invoice_status.dart';
import 'package:redcabs_mobile/features/invoices/data/store/invoice_cubit.dart';
import 'package:redcabs_mobile/features/invoices/data/store/invoice_state.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/loading_placeholder_widget.dart';
import '../../../shared/presentation/widgets/shared_border_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';

class InvoicesHomePage extends StatefulWidget {
  const InvoicesHomePage({Key? key}) : super(key: key);

  @override
  InvoicesHomePageController createState() => InvoicesHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _InvoicesHomePageView
    extends WidgetView<InvoicesHomePage, InvoicesHomePageController> {
  const _InvoicesHomePageView(InvoicesHomePageController state) : super(state);

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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 0, left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Invoices',
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        ValueListenableBuilder<InvoicePurpose>(valueListenable: state.purpose, builder: (_, purpose, __) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              onPressed: () {
                                displayPurposeOptions(context);
                              },
                              label: Text(
                                purpose.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700, color: kAppBlue),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: kAppBlue,
                                size: 20,
                              ),
                            ),
                          );
                        }),
                        ValueListenableBuilder<InvoiceStatus>(valueListenable: state.status, builder: (_, status, __) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextButton.icon(
                              onPressed: () {
                                displayStatusOptions(context);
                              },
                              label: Text(
                                status.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700, color: kAppBlue),
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: kAppBlue,
                                size: 20,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                )
              ];
            },
            body: BlocBuilder<InvoiceCubit, InvoiceState>(
                bloc: state._invoiceCubit,
                builder: (ctx, invoiceState) {
                  if (invoiceState.status == BlocStatus.success) {
                    if(invoiceState.data.length ==0) {
                      return const Center(child: Text( "There are no invoices..."));
                    }
                    return ListView.separated(
                      itemBuilder: (ctx, i) {
                        final invoice = state.invoiceList[i];
                        return ListTile(
                          leading:  CircleAvatar(
                            backgroundColor: invoice['status'] == 'open' ? Colors.amber:invoice['status'] == 'void'? kAppRed: kAppGreen,
                            child:  Icon(
                              invoice['status'] == 'open' ? FeatherIcons.alertTriangle:invoice['status'] == 'void'?FeatherIcons.x: FeatherIcons.check,
                              size: 20,
                              color: kAppWhite,
                            ),
                          ),
                          title:  Text("Invoice generated from ${state.purpose.value.title.toLowerCase()}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if(invoice['status'] == 'open'){
                                    state.payForInvoice(invoice['hostedUrl']);
                                  }
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: invoice['createdAt'],
                                      style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                                      children: const [
                                        // TextSpan(text: ' - '),
                                        // TextSpan(text: 'Sat, Feb 12th'),
                                      ]),
                                ),
                              ),

                              if(invoice['status'] == 'open')
                               Text('Pay now',style: theme.textTheme.bodyMedium?.copyWith(color: kAppRed,fontWeight: FontWeight.bold,height: 1.6),)
                              else
                                Text(invoice['status'] =='void'?'Cancelled':invoice['status'],style: theme.textTheme.bodyMedium?.copyWith(color: kAppRed,fontWeight: FontWeight.bold,height: 1.6),)
                            ],
                          ),
                          trailing: Text(
                            invoice['amountToPay'] != null ? toCurrencyFormat(invoice['amountToPay'].toString()) : "N/A",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        );
                      },
                      separatorBuilder: (ct, i) {
                        return const SizedBox(
                          height: 0,
                        );
                      },
                      itemCount: state.invoiceList.length,
                      padding: EdgeInsets.zero,
                    );
                  }
                  return const LoadingPlaceholderWidget();
                })));
  }

///  FILTER BY STATUS
  Future<void> displayStatusOptions(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.only(bottom: 30),
          child: ValueListenableBuilder<InvoiceStatus>(
            valueListenable: state.status,
            builder: (_, status, __ ) {
              return Column(
                children: <Widget>[
                  const ListTile(title: Text("Filters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
                  // const SizedBox(height: 10,),
                  ListTile(
                    onTap: () async {
                      state.status.value = InvoiceStatus(title: 'Show All', slug: null);
                      state.fetchInvoices();
                      context.pop();
                    },
                    trailing: status.slug == null  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show All"),
                  ),
                  const SharedBorderWidget(),
                  ListTile(
                    onTap: () async {
                      state.status.value = InvoiceStatus(title: 'Show Pending', slug: 'open');
                      state.fetchInvoices();
                      context.pop();
                    },
                    trailing: status.slug == "open"  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show Pending"),
                  ),
                  const SharedBorderWidget(),
                  ListTile(
                    onTap: () async {
                      state.status.value = InvoiceStatus(title: 'Show Paid', slug: 'paid');
                      state.fetchInvoices();
                      context.pop();
                    },
                    trailing: status.slug == "paid"  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show Paid"),
                  ),
                  const SharedBorderWidget(),
                  ListTile(
                    trailing: status.slug == "void"  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show Cancelled"),
                    onTap: () async {
                      state.status.value = InvoiceStatus(title: 'Show Cancelled', slug: 'void');
                      state.fetchInvoices();
                      context.pop();
                    },
                  )

                ],
              );
            }
          ),
        );
      },
    );
  }

  ///  FILTER BY PURPOSE
  Future<void> displayPurposeOptions(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: 200,
          padding: const EdgeInsets.only(bottom: 30),
          child: ValueListenableBuilder<InvoicePurpose>(
            valueListenable: state.purpose,
            builder: (_, purpose, __) {
              return Column(
                children: <Widget>[
                  const ListTile(title: Text("Type of invoice", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),),
                  // const SizedBox(height: 10,),
                  ListTile(
                    onTap: () async {
                      state.purpose.value = InvoicePurpose(title: 'Rentals', slug: 'rentals');
                      state.fetchInvoices();
                      context.pop();
                    },
                    trailing: purpose.slug == "rentals"  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show rentals"),
                  ),
                  ListTile(
                    onTap: () async {
                      state.purpose.value = InvoicePurpose(title: 'Extra', slug: 'extra');
                      state.fetchInvoices();
                      context.pop();
                    },
                    trailing: purpose.slug == "extra"  ? const Icon(Icons.check, color: kAppGreen, size: 20,) : null,
                    title: const Text("Show extra"),
                  ),

                ],
              );
            }
          ),
        );
      },
    );
  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class InvoicesHomePageController extends State<InvoicesHomePage> {
  late InvoiceCubit _invoiceCubit;
  late StreamSubscription<InvoiceState> listener;
  dynamic invoiceList = List.generate(10, (index) => index);
  // String status = 'open';
  ValueNotifier<InvoiceStatus> status = ValueNotifier(InvoiceStatus(title: 'Show Pending', slug: 'open'));
  ValueNotifier<InvoicePurpose> purpose = ValueNotifier(InvoicePurpose(title: 'Rentals', slug: 'rentals'));


  @override
  Widget build(BuildContext context) => _InvoicesHomePageView(this);

  @override
  void initState() {
    super.initState();
    _invoiceCubit = context.read<InvoiceCubit>();
    listener = _invoiceCubit.stream.listen((event) async {
      if (event.status == BlocStatus.error) {
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.success) {
        invoiceList = event.data;
      }
    });
    fetchInvoices();
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  Future<void> fetchInvoices() async {
    _invoiceCubit.fetchInvoices(status: status.value.slug, purpose: purpose.value.slug);
  }

  payForInvoice(invoiceUrl){
    context.push(Uri(path: browserPageRoute, queryParameters: {
      'url': invoiceUrl
    }).toString());
  }


}
