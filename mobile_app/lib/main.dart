import 'package:flutter/material.dart';
import 'package:crrfapp/core/constants/app_constants.dart';
import 'package:crrfapp/pages/splash_screen.dart';
import 'package:crrfapp/pages/onboarding_screen.dart';
import 'package:crrfapp/pages/role_selection_screen.dart';
import 'package:crrfapp/pages/register_screen.dart';
import 'package:crrfapp/pages/otp_verification_screen.dart';
import 'package:crrfapp/pages/login_screen.dart';
import 'package:crrfapp/pages/forgot_password_screen.dart';
import 'package:crrfapp/pages/h01_dashboard_screen.dart';
import 'package:crrfapp/pages/h02_schedule_pickup_screen.dart';
import 'package:crrfapp/pages/h03_pickup_confirmation_screen.dart';
import 'package:crrfapp/pages/h04_pickup_history_screen.dart';
import 'package:crrfapp/pages/h05_pickup_detail_screen.dart';
import 'package:crrfapp/pages/h06_cancel_pickup_sheet.dart';
import 'package:crrfapp/pages/h07_voucher_wallet_screen.dart';
import 'package:crrfapp/pages/h08_transaction_detail_screen.dart';
import 'package:crrfapp/pages/h09_waste_separation_guide_screen.dart';
import 'package:crrfapp/pages/h10_credit_rates_screen.dart';
import 'package:crrfapp/pages/h11_impact_summary_screen.dart';
import 'package:crrfapp/pages/h12_support_screen.dart';
import 'package:crrfapp/pages/f01_dashboard_screen.dart';
import 'package:crrfapp/pages/f02_marketplace_catalog_screen.dart';
import 'package:crrfapp/pages/f03_product_detail_screen.dart';
import 'package:crrfapp/pages/f04_cart_screen.dart';
import 'package:crrfapp/pages/f05_delivery_details_screen.dart';
import 'package:crrfapp/pages/f06_order_confirmation_screen.dart';
import 'package:crrfapp/pages/f07_order_history_screen.dart';
import 'package:crrfapp/pages/f08_order_detail_screen.dart';
import 'package:crrfapp/pages/f09_micro_loan_info_screen.dart';
import 'package:crrfapp/pages/d01_driver_shell_dashboard.dart';
import 'package:crrfapp/pages/d02_daily_route_screen.dart';
import 'package:crrfapp/pages/d03_pickup_task_screen.dart';
import 'package:crrfapp/pages/d04_confirm_pickup_screen.dart';
import 'package:crrfapp/pages/d05_confirm_success_screen.dart';
import 'package:crrfapp/pages/d06_report_issue_screen.dart';
import 'package:crrfapp/pages/d07_history_screen.dart';
import 'package:crrfapp/pages/notifications_screen.dart';
import 'package:crrfapp/pages/profile_settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRRF Mobile App',
      home: const SplashScreen(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // ─── Auth & Onboarding Routes ─────────────────────────────
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case AppRoutes.register:
        if (args is Map && args.containsKey('role')) {
          return MaterialPageRoute(
            builder: (_) => RegisterScreen(role: args['role']),
          );
        }
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case AppRoutes.otpVerification:
        if (args is Map &&
            args.containsKey('role') &&
            args.containsKey('phone')) {
          return MaterialPageRoute(
            builder: (_) =>
                OtpVerificationScreen(role: args['role'], phone: args['phone']),
          );
        }
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileSettingsScreen());

      // ─── Household Routes (H-01 to H-12) ──────────────────────
      case AppRoutes.householdHome:
        return MaterialPageRoute(
          builder: (_) => const HouseholdDashboardScreen(),
        );

      case AppRoutes.schedulePickup:
        return MaterialPageRoute(builder: (_) => const SchedulePickupScreen());

      case AppRoutes.pickupConfirmation:
        return MaterialPageRoute(
          builder: (_) => const PickupConfirmationScreen(),
        );

      case AppRoutes.pickupHistory:
        return MaterialPageRoute(builder: (_) => const PickupHistoryScreen());

      case AppRoutes.pickupDetail:
        if (args is Map && args.containsKey('refNumber')) {
          return MaterialPageRoute(
            builder: (_) => PickupDetailScreen(refNumber: args['refNumber']),
          );
        }
        return MaterialPageRoute(builder: (_) => const PickupHistoryScreen());

      case AppRoutes.voucher:
        return MaterialPageRoute(builder: (_) => const VoucherWalletScreen());

      case AppRoutes.transactionDetail:
        if (args is Map && args.containsKey('txId')) {
          return MaterialPageRoute(
            builder: (_) => TransactionDetailScreen(txId: args['txId']),
          );
        }
        return MaterialPageRoute(builder: (_) => const VoucherWalletScreen());

      case AppRoutes.wasteGuide:
        return MaterialPageRoute(
          builder: (_) => const WasteSeparationGuideScreen(),
        );

      case AppRoutes.creditRates:
        return MaterialPageRoute(builder: (_) => const CreditRatesScreen());

      case AppRoutes.impactSummary:
        return MaterialPageRoute(builder: (_) => const ImpactSummaryScreen());

      case AppRoutes.support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());

      case AppRoutes.cancelPickup:
        if (args is Map && args.containsKey('ref')) {
          return MaterialPageRoute(
            builder: (_) => CancelPickupSheet(refNumber: args['ref']),
          );
        }
        return MaterialPageRoute(builder: (_) => const PickupHistoryScreen());

      // ─── Farmer Routes (F-01 to F-09) ─────────────────────────
      case AppRoutes.farmerHome:
        return MaterialPageRoute(builder: (_) => const FarmerDashboardScreen());

      case AppRoutes.marketplace:
        return MaterialPageRoute(
          builder: (_) => const MarketplaceCatalogScreen(),
        );

      case AppRoutes.productDetail:
        if (args is Map && args.containsKey('productId')) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailScreen(productId: args['productId']),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const MarketplaceCatalogScreen(),
        );

      case AppRoutes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case AppRoutes.deliveryDetails:
        return MaterialPageRoute(builder: (_) => const DeliveryDetailsScreen());

      case AppRoutes.orderConfirmation:
        return MaterialPageRoute(
          builder: (_) => const OrderConfirmationScreen(),
        );

      case AppRoutes.orderHistory:
        return MaterialPageRoute(builder: (_) => const OrderHistoryScreen());

      case AppRoutes.orderDetail:
        if (args is Map && args.containsKey('orderId')) {
          return MaterialPageRoute(
            builder: (_) => OrderDetailScreen(orderId: args['orderId']),
          );
        }
        return MaterialPageRoute(builder: (_) => const OrderHistoryScreen());

      case AppRoutes.microLoanInfo:
        return MaterialPageRoute(builder: (_) => const MicroLoanInfoScreen());

      // ─── Driver Routes (D-01 to D-07) ─────────────────────────
      case AppRoutes.driverHome:
        return MaterialPageRoute(builder: (_) => const DriverDashboardScreen());

      case AppRoutes.dailyRoute:
        return MaterialPageRoute(builder: (_) => const DailyRouteScreen());

      case AppRoutes.pickupTask:
        if (args is Map && args.containsKey('pickupId')) {
          return MaterialPageRoute(
            builder: (_) => PickupTaskScreen(pickupId: args['pickupId']),
          );
        }
        return MaterialPageRoute(builder: (_) => const DailyRouteScreen());

      case AppRoutes.confirmPickup:
        if (args is Map && args.containsKey('taskId')) {
          return MaterialPageRoute(
            builder: (_) => ConfirmPickupScreen(taskId: args['taskId']),
          );
        }
        return MaterialPageRoute(builder: (_) => const DailyRouteScreen());

      case AppRoutes.confirmSuccess:
        if (args is Map &&
            args.containsKey('taskId') &&
            args.containsKey('plasticKg') &&
            args.containsKey('organicKg') &&
            args.containsKey('totalCredits') &&
            args.containsKey('householdName')) {
          return MaterialPageRoute(
            builder: (_) => ConfirmSuccessScreen(
              taskId: args['taskId'],
              plasticKg: args['plasticKg'],
              organicKg: args['organicKg'],
              totalCredits: args['totalCredits'],
              householdName: args['householdName'],
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const DailyRouteScreen());

      case AppRoutes.reportIssue:
        if (args is Map && args.containsKey('taskId')) {
          return MaterialPageRoute(
            builder: (_) => ReportIssueScreen(taskId: args['taskId']),
          );
        }
        return MaterialPageRoute(builder: (_) => const DailyRouteScreen());

      case AppRoutes.driverHistory:
        return MaterialPageRoute(
          builder: (_) => const DriverHistoryListScreen(),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
