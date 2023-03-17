import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/forgot_password_set_password_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/forgot_password_verify_otp_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/landing_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/login_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/signup_page.dart';
import 'package:redcabs_mobile/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:redcabs_mobile/features/chat/presentation/pages/chat_home_page.dart';
import 'package:redcabs_mobile/features/home/presentation/pages/home_page.dart';
import 'package:redcabs_mobile/features/invoices/presentation/pages/invoices_home_page.dart';
import 'package:redcabs_mobile/features/notifications/presentation/pages/notifications_home_page.dart';
import 'package:redcabs_mobile/features/payouts/presentation/pages/cost_preview_page.dart';
import 'package:redcabs_mobile/features/payouts/presentation/pages/income_preview_page.dart';
import 'package:redcabs_mobile/features/payouts/presentation/pages/weekly_payout_home_page.dart';
import 'package:redcabs_mobile/features/receipts/data/models/receipt_model.dart';
import 'package:redcabs_mobile/features/receipts/presentation/pages/receipts_home_page.dart';
import 'package:redcabs_mobile/features/receipts/presentation/pages/receipts_preview_page.dart';
import 'package:redcabs_mobile/features/rentals/data/models/car_model.dart';
import 'package:redcabs_mobile/features/rentals/presentation/pages/rentals_home_page.dart';
import 'package:redcabs_mobile/features/rentals/presentation/pages/rentals_preview_page.dart';
import 'package:redcabs_mobile/features/settings/presentation/pages/change_password.dart';
import 'package:redcabs_mobile/features/settings/presentation/pages/edit_personal_info_page.dart';
import 'package:redcabs_mobile/features/settings/presentation/pages/settings_home_page.dart';
import 'package:redcabs_mobile/features/shared/presentation/pages/browser_page.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/presentation/pages/tax_financial_statement_home_page.dart';

import '../../core/utils/injector.dart';
import '../../features/f_admin/presentation/pages/f_admin_home_page.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'root');
GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

// GoRouter configuration
final router = GoRouter(
  // initialLocation: homePageRoute,
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigator,
  redirect: (BuildContext context, state) async {
    final List<String> guestRoutes = [
      landingPageRoute,
      verifyOtpPageRoute,
      logInPageRoute,
      signUpPageRoute,
      forgotPasswordPageRoute,
      forgotPasswordVerifyOtpPageRoute,
      forgotPasswordResetPasswordPageRoute
    ];
    // check if user has loggedIn
    final AuthRepository authRepository = sl<AuthRepository>();
    final loggedIn = await authRepository.getCurrentLoggedInUser();

    if (!guestRoutes.contains(state.subloc) && !loggedIn) {
      // if user is not logged in and user is not navigating to a guest route
      return landingPageRoute;
    } else {
      return null;
    }
  },
  initialLocation: fAdminPageRoute,
  routes: [
    GoRoute(
      path: landingPageRoute,
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: logInPageRoute,
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: forgotPasswordPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordPage();
      },
    ),

    GoRoute(
      path: forgotPasswordVerifyOtpPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, String?>;
        return  ForgotPasswordVerifyOtpPage(
          phone: extra['phone']!,
          token: extra['token']!,
          dossier: extra['dossier']!,
        );
      },
    ),
    //
    GoRoute(
      path: forgotPasswordResetPasswordPageRoute,
      builder: (BuildContext context, GoRouterState state) {

        final extra = state.extra as Map<String, String?>;

        return  ForgotPasswordSetPasswordPage(
          phone: extra['phone']!,
          dossier: extra['dossier']!,
        );
      },
    ),

    GoRoute(
      path: signUpPageRoute,
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: verifyOtpPageRoute,
      builder: (context, GoRouterState state) => VerifyOtpPage(
          firstName: state.queryParams['firstName']!,
          otherNames: state.queryParams['otherNames']!,
          phone: state.queryParams['phone']!,
          email: state.queryParams['email']!,
          password: state.queryParams['password']!,
          token: state.queryParams['token']!),
      name: verifyOtpPageRoute,
    ),

    GoRoute(
      path: notificationsPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationsHomePage();
      },
    ),
    GoRoute(
      path: editProfilePageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfile();
      },
    ),

    // GoRoute(
    //   path: incomePreviewPageRoute,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const IncomePreviewPage();
    //   },
    // ),

    GoRoute(
      path: incomePreviewPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        final data = state.extra as Map<String, dynamic>;
        return IncomePreviewPage(
          title: data['title'],
          list: data['list'] as List<dynamic>,
          total: data['total'],
        );
      },

    ),


    GoRoute(
      path: costPreviewPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        final data = state.extra as Map<String, dynamic>;
        if (kDebugMode) {
          print(data);
        }
        return  CostPreviewPage(
          title: data['title'],
          items: data['items'] as List<dynamic>,
          total: data['total'],
        );
      },
    ),

    GoRoute(
      path: changePasswordPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const ChangePasswordPage();
      },
    ),

    GoRoute(
      path: receiptDetailsPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as ReceiptModel;
        return ReceiptsPreviewPage(
          receipt: extra,
        );
      },
    ),

    GoRoute(
      path: rentalsDetailsPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        return RentalsPreviewPage(
          list: extra['list'] as List<CarModel>,
          initialPageIndex: extra['initialPageIndex'] as int,
        );
      },
    ),

    GoRoute(
      path: settingsPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsHomePage();
      },
    ),

    GoRoute(
      path: browserPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return BrowserPage(url: state.queryParams['url']!);
      },
    ),

    GoRoute(
      path: weeklyPayoutPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const WeeklyPayoutHomePage();
      },
    ),
    GoRoute(
      path: taxFinancialStatementPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const TaxFinancialStatementHomePage();
      },
    ),
    GoRoute(
      path: receiptsPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const ReceiptsHomePage();
      },
    ),
    GoRoute(
      path: invoicesPageRoute,
      builder: (BuildContext context, GoRouterState state) {
        return const InvoicesHomePage();
      },
    ),

    /// Home page shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomePage(
          child: child,
        );
      },
      routes: <RouteBase>[
        /// The first screen to display in the bottom navigation bar.
        GoRoute(
          path: fAdminPageRoute,
          pageBuilder: (ctx, state) =>
              const NoTransitionPage(child: FAdminHomePage()),
        ),

        /// Displayed when the second item in the the bottom navigation bar is
        /// selected.
        GoRoute(
            path: chatPageRoute,
            pageBuilder: (ctx, state) =>
                const NoTransitionPage(child: ChatHomePage())),

        /// The third screen to display in the bottom navigation bar.
        GoRoute(
            path: rentalsPageRoute,
            pageBuilder: (ctx, state) =>
                const NoTransitionPage(child: RentalsHomePage())),
      ],
    ),
  ],
);
