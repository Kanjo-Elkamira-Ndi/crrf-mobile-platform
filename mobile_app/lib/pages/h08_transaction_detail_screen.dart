import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-08 — Transaction Detail Screen
// ═════════════════════════════════════════════════════════════
class TransactionDetailScreen extends StatelessWidget {
  final String txId;
  const TransactionDetailScreen({super.key, required this.txId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real data from WalletBloc using txId
    final amount = 30;
    final desc = 'Plastic pickup confirmed';
    final date = 'Today, 9:14 AM';
    final balanceAfter = 340;
    final pickupRef = 'CRRF-2026-00130';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Transaction Detail'),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Amount hero ──────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.greenLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.forestGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.recycling_rounded,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '+$amount pts',
                    style: AppTextStyles.creditBalance.copyWith(
                      color: AppColors.forestGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Details card ─────────────────────────────────
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.schedule_rounded,
                    label: 'Date & Time',
                    value: date,
                  ),
                  const Divider(height: 20),
                  _DetailRow(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Balance After',
                    value: '$balanceAfter pts',
                  ),
                  const Divider(height: 20),
                  _DetailRow(
                    icon: Icons.tag_rounded,
                    label: 'Transaction ID',
                    value: txId,
                  ),
                  const Divider(height: 20),
                  _DetailRow(
                    icon: Icons.recycling_rounded,
                    label: 'Pickup Reference',
                    value: pickupRef,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── View linked pickup ───────────────────────────
            CrrfSecondaryButton(
              label: 'View Pickup Details',
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.pickupDetail,
                arguments: {'ref': pickupRef},
              ),
              leadingIcon: Icons.open_in_new_rounded,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: CrrfBottomNavBar(
        current: CrrfNavTab.history,
        onTap: (tab) {
          // handle nav tap
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.greenLighter,
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          child: Icon(icon, color: AppColors.forestGreen, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}