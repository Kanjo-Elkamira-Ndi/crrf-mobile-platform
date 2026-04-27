import 'package:flutter/material.dart';

/// CRRF Brand Color System
/// Forest Green + Earthy Brown + Credit Gold
abstract class AppColors {
  AppColors._();

  // ─── Primary: Forest Green ─────────────────────────────────
  static const Color forestGreen = Color(0xFF1B6B3A);
  static const Color greenDark = Color(0xFF134D29);
  static const Color greenDeep = Color(0xFF0D3B1E);
  static const Color greenMid = Color(0xFF2E8B57);
  static const Color greenSoft = Color(0xFF4CAF73);
  static const Color greenLight = Color(0xFFD6F0E0);
  static const Color greenLighter = Color(0xFFEEF8F2);

  // ─── Secondary: Earthy Brown ──────────────────────────────
  static const Color earthBrown = Color(0xFF6D4C41);
  static const Color brownDark = Color(0xFF4E342E);
  static const Color brownDeep = Color(0xFF3E2723);
  static const Color brownMid = Color(0xFF8D6E63);
  static const Color brownSoft = Color(0xFFBCAAA4);
  static const Color brownLight = Color(0xFFF5EDE9);
  static const Color brownLighter = Color(0xFFFBF7F5);

  // ─── Tertiary: Credit Gold ────────────────────────────────
  static const Color creditGold = Color(0xFFF59E0B);
  static const Color goldDark = Color(0xFFB45309);
  static const Color goldDeep = Color(0xFF92400E);
  static const Color goldMid = Color(0xFFFBBF24);
  static const Color goldSoft = Color(0xFFFDE68A);
  static const Color goldLight = Color(0xFFFEF3C7);
  static const Color goldLighter = Color(0xFFFFFBEB);

  // ─── Semantic ─────────────────────────────────────────────
  static const Color successGreen = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warningAmber = Color(0xFFD97706);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFF991B1B);
  static const Color infoBlue = Color(0xFF2563EB);
  static const Color infoLight = Color(0xFFDBEAFE);

  // ─── Neutrals ─────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(
    0xFFF7F9F7,
  ); // very slightly green-tinted
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGray = Color(0xFFF3F4F6);
  static const Color inputBackground = Color(0xFFF9FAF9);

  // ─── Text ─────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textHint = Color(0xFFD1D5DB);

  // ─── Borders ──────────────────────────────────────────────
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderLighter = Color(0xFFF3F4F6);
  static const Color borderGreen = Color(0xFFBBDDCA);
  static const Color borderBrown = Color(0xFFD9C4BC);

  // ─── Shadow ───────────────────────────────────────────────
  static const Color shadow = Color(0x1A000000);
  static const Color shadowStrong = Color(0x33000000);

  // ─── Status Colors (for badges) ───────────────────────────
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusPendingBg = Color(0xFFFEF3C7);
  static const Color statusActive = Color(0xFF16A34A);
  static const Color statusActiveBg = Color(0xFFDCFCE7);
  static const Color statusDone = Color(0xFF2563EB);
  static const Color statusDoneBg = Color(0xFFDBEAFE);
  static const Color statusCancelled = Color(0xFFDC2626);
  static const Color statusCancelBg = Color(0xFFFEE2E2);
}
