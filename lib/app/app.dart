import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redcabs_mobile/core/lang/lang.al.dart';
import 'package:redcabs_mobile/features/invoices/data/store/invoice_cubit.dart';
import 'package:redcabs_mobile/features/payouts/data/store/payout_cubit.dart';
import 'package:redcabs_mobile/features/receipts/data/store/receipt_cubit.dart';
import 'package:redcabs_mobile/features/rentals/data/store/rental_cubit.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/data/store/tax_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../core/utils/functions.dart';
import '../core/utils/theme.dart';
import '../core/utils/timeago_messages.dart';
import '../features/auth/data/store/auth_cubit.dart';
import '../features/chat/data/store/chat_cubit.dart';
import '../features/notifications/data/store/notification_cubit.dart';
import 'routing/routes.dart';



class App extends StatelessWidget {

  final AdaptiveThemeMode? savedThemeMode;

  const App({this.savedThemeMode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(

      light: lightTheme(context),
      dark: darkTheme(context),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (ThemeData theme, ThemeData darkTheme) {
        return MultiBlocProvider(
          providers: [
            /// Register global providers
            BlocProvider(create: (context) => AuthCubit()),
            BlocProvider(create: (context) => PayoutCubit()),
            BlocProvider(create: (context) => ReceiptCubit()),
            BlocProvider(create: (context) => ChatCubit()),
            BlocProvider(create: (context) => TaxCubit()),
            BlocProvider(create: (context) => InvoiceCubit()),
            BlocProvider(create: (context) => RentalCubit()),
            BlocProvider(create: (context) => NotificationCubit()),
          ],
          child: AutoLocalizedApp(
            child: MaterialApp.router(
              title: 'Redcabs',
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              theme: theme,
              routerConfig: router,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationsDelegates,
              builder: (ctx, widget) {
                timeago.setLocaleMessages('en', TimeagoMessages());

                // all initializations of app status bar, app navigation bar setup

                setAppSystemOverlay(theme: theme, useThemeOverlays: true);

                return widget!;
              },
            ),
          )
        );
      },
    );
  }
}
