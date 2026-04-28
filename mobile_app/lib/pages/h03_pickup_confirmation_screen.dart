import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// H-03 — Pickup Confirmation (Success screen)
class PickupConfirmationScreen extends StatelessWidget {
  const PickupConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const refNumber = 'CRRF-2026-00142';
    const pickupDate = 'Wednesday, 30 Apr 2026';
    const timeWindow = '7:00 AM – 10:00 AM';
    const wasteTypes = 'Plastic + Organic';
    const estimatedCredits = 30;

    return CrrfScaffold(
      currentTab: CrrfNavTab.pickup,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL),
        child: Column(
          children: [
            const SizedBox(height: AppConstants.spacingXL),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.successLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: AppColors.successGreen, size: 56),
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text('Pickup Requested!', style: AppTextStyles.h1, textAlign: TextAlign.center),
            const SizedBox(height: AppConstants.spacingS),
            Text('Your collection has been scheduled.\nA driver will be assigned shortly.',
              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.6), textAlign: TextAlign.center),
            const SizedBox(height: AppConstants.spacingXL),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Column(
                children: [
                  _DetailRow(icon: Icons.tag_rounded, label: 'Reference', value: refNumber),
                  const Divider(height: 20),
                  _DetailRow(icon: Icons.calendar_today_rounded, label: 'Date', value: pickupDate),
                  const Divider(height: 20),
                  _DetailRow(icon: Icons.access_time_rounded, label: 'Time Window', value: timeWindow),
                  const Divider(height: 20),
                  _DetailRow(icon: Icons.recycling_rounded, label: 'Waste Types', value: wasteTypes),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(color: AppColors.goldLighter, borderRadius: BorderRadius.circular(AppConstants.radiusM)),
                        child: const Icon(Icons.stars_rounded, color: AppColors.creditGold, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Estimated Credits', style: AppTextStyles.bodySmall)),
                      const CreditChip(amount: estimatedCredits, isEarned: true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingL),
            const CalloutCard(message: 'Credits are issued once your driver confirms the actual weight at pickup.', type: CalloutType.info),
            const Spacer(),
            CrrfPrimaryButton(
              label: 'View Pickup History',
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.pickupHistory, (r) => r.settings.name == AppRoutes.householdHome),
            ),
            const SizedBox(height: AppConstants.spacingS),
            CrrfSecondaryButton(
              label: 'Back to Home',
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.householdHome, (_) => false),
            ),
            const SizedBox(height: AppConstants.spacingXL),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: AppColors.greenLighter, borderRadius: BorderRadius.circular(AppConstants.radiusM)),
          child: Icon(icon, color: AppColors.forestGreen, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
