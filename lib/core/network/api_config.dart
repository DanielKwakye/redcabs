
import 'package:flutter/foundation.dart';

abstract class ApiConfig {
  static const localBaseUrl = "http://127.0.0.1:8000";
  static const _kaqAdminBaseUrl = "https://live.kaqadmin.com";
  // static const String baseUrl = kReleaseMode ? "$_kaqAdminBaseUrl/driver/api" : "$localBaseUrl/driver/api";
  static const String baseUrl = "$_kaqAdminBaseUrl/driver/api";
  static const String websiteUrl = '$baseUrl/auth/google';
  static const String aboutUrl = 'https://google.com';
  static String userProfile = '$baseUrl/user/profile';
  static String updateUser = '$baseUrl/update-user';
  static String checkDossierExist = '$baseUrl/check-dossier-number';
  static String verifyAccount = '$baseUrl/check-email-phone-at-registration';
  static String sendVerificationCode = '$baseUrl/send-verification-code-to-phone';
  static String verifyPhoneNumber = '$baseUrl/verify-phone-number';
  static String login = '$baseUrl/oauth/token';
  static String updateDriverInfo = '$baseUrl/settings/update-personal-details';
  static String updateDriverPassword = '$baseUrl/settings/change-driver-password';
  static String setDriverPasswordAtForgotPassword = '$baseUrl/reset-password';
  static String registerDriver = '$baseUrl/register-prospective-driver';
  static String fetchPayoutOverviewHistory = '$baseUrl/payout/fetch-summary';
  static String fetchReceipts = '$baseUrl/ext-data/get-files';
  static String uploadReceipt = '$baseUrl/ext-data/add-file';
  static String fetchTax = '$baseUrl/f-admin/tax-financial-statement';
  static String fetchInvoices = '$baseUrl/invoices/get';
  static String fetchAvailableCars = '$baseUrl/rentals/fetch-available-cars';
  static String fetchMyRentedCars = '$baseUrl/rentals/fetch-my-rented-cars';
  static String clientId = "93d300cb-a64f-423b-b6ab-6fbfbc6fdd06";

  static String apiKey = "JWJf2wseIikFpusSexwT0VwEOCOQ0AxlChY0gDqW";

  static String fetchNotifications = '$baseUrl/fetch-push-notifications';
  static String fetchNotificationsCount = '$baseUrl/fetch-push-notifications-count';
  static String setNotificationsRead = '$baseUrl/set-push-notifications-read';


 static String getUserById({required String userId}) => '$baseUrl/get-user-by-id/$userId';


}
