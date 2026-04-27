/// CRRF App Constants
abstract class AppConstants {
  AppConstants._();

  // ─── App Info ──────────────────────────────────────────────
  static const String appName = 'CRRF';
  static const String appFullName = 'Cam Recycle Roads & Farms';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Waste to Value. Crops to Markets.';

  // ─── Credit System ────────────────────────────────────────
  static const int creditsPerKgPlastic = 10;
  static const int creditsPerKgOrganic = 5;
  static const double minWeightKg = 0.5; // min weight for credit
  static const double weightRoundingStep = 0.5; // round down to nearest 0.5kg
  static const int creditExpiryMonths = 12;
  static const int expiryWarningDays = 30;

  // ─── OTP ─────────────────────────────────────────────────
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 10;
  static const int otpResendCooldownSec = 60;

  // ─── Pagination ───────────────────────────────────────────
  static const int defaultPageSize = 20;

  // ─── Time Windows (for pickups) ───────────────────────────
  static const List<Map<String, String>> pickupTimeWindows = [
    {'key': 'morning_7_10', 'label': '7:00 AM – 10:00 AM'},
    {'key': 'midday_10_14', 'label': '10:00 AM – 2:00 PM'},
    {'key': 'afternoon_14_18', 'label': '2:00 PM – 6:00 PM'},
  ];

  // ─── Waste Types ─────────────────────────────────────────
  static const List<Map<String, dynamic>> wasteTypes = [
    {'key': 'plastic', 'label': 'Plastic', 'emoji': '♳', 'credits': 10},
    {'key': 'organic', 'label': 'Organic', 'emoji': '🌿', 'credits': 5},
  ];

  // ─── Districts (Cameroon - Yaoundé area) ─────────────────
  static const List<String> districts = [
    'Mfoundi',
    'Mefou-et-Akono',
    'Mefou-et-Afamba',
    'Lekié',
    'Nyong-et-So\'o',
    'Haute-Sanaga',
    'Mbam-et-Kim',
    'Mbam-et-Inoubou',
  ];

  // ─── Issue / Skip Reasons (Driver) ───────────────────────
  static const List<String> skipReasons = [
    'Household absent',
    'No waste ready',
    'Access blocked',
    'Incorrect address',
    'Other',
  ];

  // ─── Storage Keys ────────────────────────────────────────
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserData = 'user_data';
  static const String keyUserRole = 'user_role';
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyLanguage = 'app_language';

  // ─── Supported Locales ───────────────────────────────────
  static const List<String> supportedLocales = ['en', 'fr'];

  // ─── Animation Durations ─────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 350);
  static const Duration animSlow = Duration(milliseconds: 500);
  static const Duration animVerySlow = Duration(milliseconds: 800);

  // ─── Spacing ─────────────────────────────────────────────
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // ─── Border Radius ───────────────────────────────────────
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusPill = 999.0;
}

/// App-wide route names (used in GoRouter)
abstract class AppRoutes {
  AppRoutes._();

  // ─── Shared / Auth ───────────────────────────────────────
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/role-select';
  static const String register = '/register';
  static const String otpVerification = '/otp';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // ─── Shared (authenticated) ───────────────────────────────
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String support = '/support';

  // ─── Household ────────────────────────────────────────────
  static const String householdHome = '/household';
  static const String schedulePickup = '/household/schedule-pickup';
  static const String pickupConfirmation = '/household/pickup-confirmation';
  static const String pickupHistory = '/household/pickup-history';
  static const String pickupDetail = '/household/pickup-detail';
  static const String cancelPickup = '/household/cancel-pickup';
  static const String voucher = '/household/voucher';
  static const String transactionDetail = '/household/transaction-detail';
  static const String wasteGuide = '/household/waste-guide';
  static const String creditRates = '/household/credit-rates';
  static const String impactSummary = '/household/impact';

  // ─── Farmer ───────────────────────────────────────────────
  static const String farmerHome = '/farmer';
  static const String marketplace = '/farmer/marketplace';
  static const String productDetail = '/farmer/product-detail';
  static const String cart = '/farmer/cart';
  static const String deliveryDetails = '/farmer/delivery-details';
  static const String orderConfirmation = '/farmer/order-confirmation';
  static const String orderHistory = '/farmer/order-history';
  static const String orderDetail = '/farmer/order-detail';
  static const String microLoanInfo = '/farmer/micro-loan';

  // ─── Driver ───────────────────────────────────────────────
  static const String driverHome = '/driver';
  static const String dailyRoute = '/driver/route';
  static const String pickupTask = '/driver/pickup-task';
  static const String confirmPickup = '/driver/confirm-pickup';
  static const String confirmSuccess = '/driver/confirm-success';
  static const String reportIssue = '/driver/report-issue';
  static const String driverHistory = '/driver/history';

  // ─── Admin ────────────────────────────────────────────────
  static const String adminHome = '/admin';
  static const String userManagement = '/admin/users';
  static const String userDetailAdmin = '/admin/users/detail';
  static const String pickupsAdmin = '/admin/pickups';
  static const String driverManagement = '/admin/drivers';
  static const String productsAdmin = '/admin/products';
  static const String ordersAdmin = '/admin/orders';
  static const String creditsLedger = '/admin/credits';
  static const String creditRateSettings = '/admin/credit-rates';
  static const String analytics = '/admin/analytics';
}

/// User roles
enum UserRole { household, farmer, driver, admin }

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.household:
        return 'household';
      case UserRole.farmer:
        return 'farmer';
      case UserRole.driver:
        return 'driver';
      case UserRole.admin:
        return 'admin';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.household:
        return 'Household';
      case UserRole.farmer:
        return 'Farmer';
      case UserRole.driver:
        return 'Driver';
      case UserRole.admin:
        return 'Admin';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'household':
        return UserRole.household;
      case 'farmer':
        return UserRole.farmer;
      case 'driver':
        return UserRole.driver;
      case 'admin':
        return UserRole.admin;
      default:
        return UserRole.household;
    }
  }
}

/// Pickup status
enum PickupStatus { pending, assigned, confirmed, cancelled, completed }

extension PickupStatusExtension on PickupStatus {
  String get label {
    switch (this) {
      case PickupStatus.pending:
        return 'Pending';
      case PickupStatus.assigned:
        return 'Assigned';
      case PickupStatus.confirmed:
        return 'Confirmed';
      case PickupStatus.cancelled:
        return 'Cancelled';
      case PickupStatus.completed:
        return 'Completed';
    }
  }
}

/// Order status
enum OrderStatus { ordered, processing, outForDelivery, delivered, cancelled }

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.ordered:
        return 'Ordered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
