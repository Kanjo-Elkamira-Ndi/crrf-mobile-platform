import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-11 — Impact Summary Screen
// ═════════════════════════════════════════════════════════════
class ImpactSummaryScreen extends StatelessWidget {
  const ImpactSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CrrfScaffold(
      currentTab: CrrfNavTab.history,
      appBar: AppBar(
        backgroundColor: AppColors.forestGreen,
        foregroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: const Text('My Impact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Hero banner ───────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.forestGreen, AppColors.greenMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            ),
            child: Column(
              children: [
                const Text('🌍', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(
                  'Your Contribution Matters',
                  style: AppTextStyles.h2.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Every kilogram you sort keeps waste out of landfills and\nnourishes Cameroonian farms.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Stats grid ────────────────────────────────────────
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.3,
            children: const [
              _ImpactCard(
                emoji: '♻️',
                value: '12.5 kg',
                label: 'Plastic Recycled',
              ),
              _ImpactCard(
                emoji: '🌿',
                value: '8.0 kg',
                label: 'Organic Sorted',
              ),
              _ImpactCard(
                emoji: '🌱',
                value: '≈ 4 kg',
                label: 'Manure Produced',
              ),
              _ImpactCard(emoji: '💨', value: '≈ 18 kg', label: 'CO₂ Avoided'),
            ],
          ),

          const SizedBox(height: 24),

          // ── Pickups timeline ──────────────────────────────────
          SectionHeader(
            title: 'Pickup Milestones',
            actionLabel: 'All Pickups',
            onAction: () =>
                Navigator.of(context).pushNamed(AppRoutes.pickupHistory),
          ),
          const SizedBox(height: 12),

          _MilestoneRow(
            milestone: '12 pickups',
            label: 'Total collections completed',
            icon: Icons.recycling_rounded,
            done: true,
          ),
          _MilestoneRow(
            milestone: '15 pickups',
            label: 'Next milestone — 3 more to go!',
            icon: Icons.emoji_events_rounded,
            done: false,
          ),
          _MilestoneRow(
            milestone: '25 pickups',
            label: 'CRRF Champion badge',
            icon: Icons.workspace_premium_rounded,
            done: false,
          ),

          const SizedBox(height: 24),

          // ── Neighbourhood rank (placeholder) ─────────────────
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.goldLighter,
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
              border: Border.all(color: AppColors.goldSoft),
            ),
            child: Row(
              children: [
                const Text('🏅', style: TextStyle(fontSize: 36)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Neighbourhood Rank',
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.goldDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '#3 in Mfoundi District this month',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.goldDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class _ImpactCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  const _ImpactCard({
    required this.emoji,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(color: AppColors.forestGreen),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  final String milestone;
  final String label;
  final IconData icon;
  final bool done;
  const _MilestoneRow({
    required this.milestone,
    required this.label,
    required this.icon,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: done ? AppColors.greenLighter : AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: done ? AppColors.borderGreen : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: done ? AppColors.forestGreen : AppColors.surfaceGray,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Icon(
              icon,
              color: done ? AppColors.white : AppColors.textHint,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  milestone,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: done ? AppColors.forestGreen : AppColors.textPrimary,
                  ),
                ),
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (done)
            const Icon(
              Icons.check_circle_rounded,
              color: AppColors.successGreen,
              size: 20,
            )
          else
            const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.textHint,
              size: 18,
            ),
        ],
      ),
    );
  }
}
