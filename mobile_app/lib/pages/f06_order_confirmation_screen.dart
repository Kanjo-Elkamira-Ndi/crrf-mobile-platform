import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// F-06 — Order Confirmation Screen
// ═════════════════════════════════════════════════════════════
/// Success screen after order is placed.
/// Displays order ID, credits deducted, expected delivery, CTAs.
class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Receive real data via route args / OrderBloc state
    const orderId = 'ORD-2026-00042';
    const creditsDeducted = 200;
    const deliveryWindow = 'Tomorrow, Morning (7:00 AM – 12:00 PM)';
    const address = 'Quartier Bastos, Yaounde';

    return FarmerScaffold(
      currentTab: FarmerNavTab.orders,
      body: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // ── Success icon ──────────────────────────────────
                Container(
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

                const SizedBox(height: 24),
                Text(
                  'Order Placed!',
                  style: AppTextStyles.h1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Your manure order has been confirmed.\nDelivery is on its way.',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // ── Details card ──────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      _ConfirmRow(
                        icon: Icons.tag_rounded,
                        label: 'Order ID',
                        value: orderId,
                      ),
                      const Divider(height: 20),
                      _ConfirmRow(
                        icon: Icons.stars_rounded,
                        label: 'Credits Deducted',
                        value: '$creditsDeducted pts',
                        valueColor: AppColors.forestGreen,
                      ),
                      const Divider(height: 20),
                      _ConfirmRow(
                        icon: Icons.local_shipping_rounded,
                        label: 'Expected Delivery',
                        value: deliveryWindow,
                      ),
                      const Divider(height: 20),
                      _ConfirmRow(
                        icon: Icons.location_on_outlined,
                        label: 'Delivery Address',
                        value: address,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const CalloutCard(
                  message:
                      'Our driver will call you before arriving. Keep your phone reachable.',
                  type: CalloutType.info,
                ),

                const Spacer(),

                // ── CTAs ─────────────────────────────────────────
                CrrfPrimaryButton(
                  label: 'Track My Order',
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.orderHistory,
                        (r) => r.settings.name == AppRoutes.farmerHome,
                      ),
                  leadingIcon: Icons.local_shipping_rounded,
                ),
                const SizedBox(height: 12),
                CrrfSecondaryButton(
                  label: 'Back to Home',
                  onPressed: () => Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(AppRoutes.farmerHome, (_) => false),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color? valueColor;
  const _ConfirmRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.brownLighter,
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          child: Icon(icon, color: AppColors.earthBrown, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
