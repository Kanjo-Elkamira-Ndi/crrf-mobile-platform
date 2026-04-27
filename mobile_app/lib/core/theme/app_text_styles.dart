import 'package:flutter/material.dart';
import 'app_colors.dart';

/// CRRF Typography System
/// Primary font: DM Sans (clean, modern, highly legible)
/// Accent font: DM Serif Display (for hero numbers/credits)
abstract class AppTextStyles {
  AppTextStyles._();

  // ─── Display (Hero numbers, credit balances) ───────────────
  static const TextStyle displayXL = TextStyle(
    fontFamily: 'DMSerifDisplay',
    fontSize: 56,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.1,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'DMSerifDisplay',
    fontSize: 40,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'DMSerifDisplay',
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.25,
  );

  // ─── Headings (DM Sans) ────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.35,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
    height: 1.4,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ─── Body ─────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.2,
    height: 1.4,
  );

  // ─── Labels ────────────────────────────────────────────────
  static const TextStyle label = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
    height: 1.4,
  );

  static const TextStyle labelUppercase = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
    height: 1.4,
  );

  // ─── Buttons ───────────────────────────────────────────────
  static const TextStyle button = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.0,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // ─── Navigation ────────────────────────────────────────────
  static const TextStyle navLabel = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  static const TextStyle navLabelSelected = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.forestGreen,
  );

  // ─── AppBar ────────────────────────────────────────────────
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // ─── Input ────────────────────────────────────────────────
  static const TextStyle inputLabel = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.forestGreen,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  static const TextStyle inputError = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.errorRed,
  );

  // ─── Misc ──────────────────────────────────────────────────
  static const TextStyle chipLabel = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.forestGreen,
  );

  static const TextStyle snackbar = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle dialogTitle = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // ─── Credit/Wallet specific ────────────────────────────────
  static const TextStyle creditBalance = TextStyle(
    fontFamily: 'DMSerifDisplay',
    fontSize: 44,
    fontWeight: FontWeight.w400,
    color: AppColors.forestGreen,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static const TextStyle creditUnit = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.greenMid,
    letterSpacing: 0.5,
  );

  static const TextStyle transactionAmount = TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );
}
