import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// D-05 — Confirmation Success Screen
// ═════════════════════════════════════════════════════════════
/// Shown immediately after driver submits a successful pickup.
/// Displays credits issued, actual weight, household notified banner.
/// Two CTAs: Next Stop (pop back to route) or View Route.
class ConfirmSuccessScreen extends StatelessWidget {
  final String taskId;
  final double plasticKg;
  final double organicKg;
  final int totalCredits;
  final String householdName;

  const ConfirmSuccessScreen({
    super.key,
    required this.taskId,
    required this.plasticKg,
    required this.organicKg,
    required this.totalCredits,
    required this.householdName,
  });

  // Factory constructor for testing/demo purposes
  factory ConfirmSuccessScreen.demo() {
    return const ConfirmSuccessScreen(
      taskId: 'P-001',
      plasticKg: 2.5,
      organicKg: 1.5,
      totalCredits: 45,
      householdName: 'Ama Mbarga',
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalKg = plasticKg + organicKg;

    return DriverScaffold(
      currentTab: DriverNavTab.myRoute,
      body: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),

                // ── Success animation placeholder ────────────────
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.5, end: 1.0),
                  duration: AppConstants.animSlow,
                  curve: Curves.elasticOut,
                  builder: (_, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: AppColors.successLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.successGreen,
                      size: 56,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  'Pickup Confirmed!',
                  style: AppTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '$householdName has been notified\nand their credits have been issued.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // ── Stats card ────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Credit issued — big green number
                      Text(
                        '$totalCredits',
                        style: AppTextStyles.creditBalance.copyWith(
                          color: AppColors.forestGreen,
                        ),
                      ),
                      Text(
                        'CRF Credits Issued',
                        style: AppTextStyles.creditUnit.copyWith(
                          color: AppColors.greenMid,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _SuccessStat(
                            label: 'Total Weight',
                            value: '${totalKg.toStringAsFixed(1)} kg',
                            icon: Icons.scale_rounded,
                          ),
                          if (plasticKg > 0) ...[
                            _vLine(),
                            _SuccessStat(
                              label: 'Plastic',
                              value: '${plasticKg.toStringAsFixed(1)} kg',
                              icon: Icons.recycling_rounded,
                            ),
                          ],
                          if (organicKg > 0) ...[
                            _vLine(),
                            _SuccessStat(
                              label: 'Organic',
                              value: '${organicKg.toStringAsFixed(1)} kg',
                              icon: Icons.eco_rounded,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const CalloutCard(
                  message:
                      'Great work! Credits have been added to the household wallet automatically.',
                  type: CalloutType.success,
                ),

                const Spacer(),

                // ── CTAs ─────────────────────────────────────────
                CrrfPrimaryButton(
                  label: 'Next Stop',
                  onPressed: () {
                    // Pop success → pop task detail → back on route list
                    Navigator.of(context)
                      ..pop() // pop success
                      ..pop() // pop task detail
                      ..pop(); // pop confirm screen (if pushed separately)
                  },
                  leadingIcon: Icons.arrow_forward_rounded,
                ),
                const SizedBox(height: 12),
                CrrfSecondaryButton(
                  label: 'View Full Route',
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.dailyRoute,
                        (r) => r.settings.name == AppRoutes.driverHome,
                      ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _vLine() => Container(
    width: 1,
    height: 40,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    color: AppColors.borderLighter,
  );
}

class _SuccessStat extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _SuccessStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.forestGreen, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
