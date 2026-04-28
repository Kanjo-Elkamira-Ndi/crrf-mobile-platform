import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// H-05 — Pickup Detail Screen
class PickupDetailScreen extends StatelessWidget {
  final String refNumber;
  const PickupDetailScreen({super.key, required this.refNumber});

  @override
  Widget build(BuildContext context) {
    const status = PickupStatus.completed;

    return CrrfScaffold(
      currentTab: CrrfNavTab.history,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text(
          'Pickup Detail',
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (status == PickupStatus.pending)
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.cancelPickup,
                arguments: {'ref': refNumber},
              ),
              child: Text(
                'Cancel',
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.errorRed,
                ),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.greenLighter,
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.successLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.successGreen,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 12),
                StatusBadge.fromPickupStatus(status),
                const SizedBox(height: 6),
                Text(
                  'CRRF-2026-00130',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingM),
          _SectionCard(
            title: 'Pickup Details',
            children: [
              _DetailRow(
                icon: Icons.calendar_today_rounded,
                label: 'Date',
                value: '25 Apr 2026',
              ),
              const Divider(height: 20),
              _DetailRow(
                icon: Icons.access_time_rounded,
                label: 'Time Window',
                value: '10:00 AM – 2:00 PM',
              ),
              const Divider(height: 20),
              _DetailRow(
                icon: Icons.recycling_rounded,
                label: 'Waste Type',
                value: 'Plastic',
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingM),
          _SectionCard(
            title: 'Driver Confirmation',
            children: [
              _DetailRow(
                icon: Icons.person_outline_rounded,
                label: 'Driver',
                value: 'Didier T.',
              ),
              const Divider(height: 20),
              _DetailRow(
                icon: Icons.scale_rounded,
                label: 'Actual Weight',
                value: '3.0 kg',
              ),
              const Divider(height: 20),
              _DetailRow(
                icon: Icons.schedule_rounded,
                label: 'Confirmed At',
                value: '9:14 AM',
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingM),
          _SectionCard(
            title: 'Credits Issued',
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '3.0 kg plastic × 10 pts',
                    style: AppTextStyles.bodySmall,
                  ),
                  const CreditChip(amount: 30, isEarned: true),
                ],
              ),
            ],
          ),
        ],
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

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h4),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}
