import 'package:get_it/get_it.dart';
import 'package:redcabs_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:redcabs_mobile/features/chat/data/repositories/chat_repository.dart';
import 'package:redcabs_mobile/features/invoices/data/repository/invoice_repository.dart';
import 'package:redcabs_mobile/features/payouts/data/repositories/payout_repository.dart';
import 'package:redcabs_mobile/features/receipts/data/repository/receipt_repository.dart';
import 'package:redcabs_mobile/features/rentals/data/repository/rental_repository.dart';
import 'package:redcabs_mobile/features/tax_financial_statement/data/repository/tax_repository.dart';
import '../../features/notifications/data/data/repositories/notifications_repository.dart';
import '../network/network_provider.dart';

/// Using Get It as the service locator -> for dependency injections
final sl = GetIt.instance;

/// Initializes all dependencies.
/// We register as lazy singletons to boost performance
/// meaning, Get It would instantiate objects on demand
Future<void> init() async {

  //! State managements
  // eg: sl.registerFactory(() => ExampleBloc());
  // sl.registerLazySingleton(() => BaseLayoutRepository());
  // sl.registerLazySingleton(() => ExampleRepository());


  //! Repositories
  //  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => PayoutRepository());
  sl.registerLazySingleton(() => ReceiptRepository());
  sl.registerLazySingleton(() => TaxRepository());
  sl.registerLazySingleton(() => InvoiceRepository());
  sl.registerLazySingleton(() => ChatRepository());
  sl.registerLazySingleton(() => RentalRepository());
  sl.registerLazySingleton(() => NotificationsRepository());



  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  //! Data sources
  //eg: sl.registerLazySingleton<ICacheDataSource>(() => CacheDataSourceImpl(sl()));

  //! Core
  //eg: sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  //eg: sl.registerLazySingleton(() => http.Client());
   sl.registerLazySingleton(() => NetworkProvider());

}