import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// D-01 — Driver Dashboard Screen
// ═════════════════════════════════════════════════════════════
/// Home screen for the driver.
/// Shows:
///   • Greeting + shift status toggle (On Duty / Off Duty)
///   • Today's summary: total assigned / completed / remaining
///   • Progress bar across today's pickups
///   • "Start Route" CTA → navigates to D-02
///   • Quick stats: total weight collected today, skip rate
///   • Alert banner if there are pending unconfirmed pickups
class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  bool _isOnDuty = true;

  // TODO: Replace with DriverBloc data
  final String _driverName = 'Didier';
  final int _totalToday = 8;
  final int _completed = 3;
  final int _skipped = 1;

  int get _remaining => _totalToday - _completed - _skipped;
  double get _progress => _totalToday > 0 ? _completed / _totalToday : 0;

  @override
  Widget build(BuildContext context) {
    return DriverScaffold(
      currentTab: DriverNavTab.home,
      body: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // ── App bar ──────────────────────────────────────────
            SliverAppBar(
              backgroundColor: AppColors.infoBlue,
              floating: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning, $_driverName 🚛',
                    style: AppTextStyles.h4.copyWith(color: AppColors.white),
                  ),
                  Text(
                    "Today's shift",
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ),
              actions: [
                // Shift toggle
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      Text(
                        _isOnDuty ? 'On Duty' : 'Off Duty',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => setState(() => _isOnDuty = !_isOnDuty),
                        child: AnimatedContainer(
                          duration: AppConstants.animFast,
                          width: 44,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _isOnDuty
                                ? AppColors.successGreen
                                : AppColors.textHint,
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusPill,
                            ),
                          ),
                          child: AnimatedAlign(
                            duration: AppConstants.animFast,
                            alignment: _isOnDuty
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Not on duty warning ──────────────────────
                    if (!_isOnDuty) ...[
                      const CalloutCard(
                        message:
                            'You are currently Off Duty. Toggle to On Duty to start completing pickups.',
                        type: CalloutType.warning,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // ── Today's progress card ────────────────────
                    _ProgressCard(
                      total: _totalToday,
                      completed: _completed,
                      skipped: _skipped,
                      remaining: _remaining,
                      progress: _progress,
                    ),

                    const SizedBox(height: 20),

                    // ── Start Route CTA ─────────────────────────
                    if (_isOnDuty && _remaining > 0)
                      _StartRouteButton(
                        remaining: _remaining,
                        onTap: () {
                          // Switch to Route tab (index 1)
                          // In real app: DriverShell._onTabTapped(1) via callback
                          Navigator.of(context).pushNamed(AppRoutes.dailyRoute);
                        },
                      ),

                    if (_remaining == 0 && _isOnDuty) ...[
                      const CalloutCard(
                        message:
                            '🎉 All pickups completed for today! Great work.',
                        type: CalloutType.success,
                      ),
                    ],

                    const SizedBox(height: 20),

                    // ── Stats row ────────────────────────────────
                    Row(
                      children: [
                        _DashStat(
                          value: '12.4 kg',
                          label: 'Collected Today',
                          icon: Icons.scale_rounded,
                          color: AppColors.forestGreen,
                          bg: AppColors.greenLighter,
                        ),
                        const SizedBox(width: 12),
                        _DashStat(
                          value: '$_skipped',
                          label: 'Skipped Today',
                          icon: Icons.warning_amber_rounded,
                          color: AppColors.warningAmber,
                          bg: AppColors.warningLight,
                        ),
                        const SizedBox(width: 12),
                        _DashStat(
                          value: '87%',
                          label: 'Completion Rate',
                          icon: Icons.insights_rounded,
                          color: AppColors.infoBlue,
                          bg: AppColors.infoLight,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ── Pending unconfirmed alert ─────────────────
                    if (_completed < _totalToday && _isOnDuty)
                      _PendingAlert(
                        remaining: _remaining,
                        onViewRoute: () {
                          Navigator.of(context).pushNamed(AppRoutes.dailyRoute);
                        },
                      ),

                    const SizedBox(height: 24),

                    // ── Next pickup preview ──────────────────────
                    if (_remaining > 0) ...[
                      SectionHeader(title: 'Next Pickup'),
                      const SizedBox(height: 12),
                      _NextPickupCard(
                        onTap: () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.pickupTask),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Progress card ────────────────────────────────────────────
class _ProgressCard extends StatelessWidget {
  final int total, completed, skipped, remaining;
  final double progress;

  const _ProgressCard({
    required this.total,
    required this.completed,
    required this.skipped,
    required this.remaining,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.infoBlue, Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.infoBlue.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's Route",
                style: AppTextStyles.labelUppercase.copyWith(
                  color: AppColors.white.withValues(alpha: 0.75),
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% done',
                style: AppTextStyles.label.copyWith(color: AppColors.white),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Big numbers row
          Row(
            children: [
              _ProgressStat(
                value: '$completed',
                label: 'Done',
                color: AppColors.successGreen,
              ),
              _vDivider(),
              _ProgressStat(
                value: '$skipped',
                label: 'Skipped',
                color: AppColors.creditGold,
              ),
              _vDivider(),
              _ProgressStat(
                value: '$remaining',
                label: 'Left',
                color: AppColors.white,
              ),
              _vDivider(),
              _ProgressStat(
                value: '$total',
                label: 'Total',
                color: AppColors.white.withValues(alpha: 0.6),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusPill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.successGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vDivider() => Container(
    width: 1,
    height: 36,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    color: AppColors.white.withValues(alpha: 0.2),
  );
}

class _ProgressStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _ProgressStat({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(color: color)),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

// ─── Start route button ───────────────────────────────────────
class _StartRouteButton extends StatelessWidget {
  final int remaining;
  final VoidCallback onTap;
  const _StartRouteButton({required this.remaining, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.forestGreen,
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.forestGreen.withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.route_rounded,
                color: AppColors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Continue Route',
                    style: AppTextStyles.h4.copyWith(color: AppColors.white),
                  ),
                  Text(
                    '$remaining pickups remaining today',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Dashboard stat tile ──────────────────────────────────────
class _DashStat extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color, bg;
  const _DashStat({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
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
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(icon, color: color, size: 17),
            ),
            const SizedBox(height: 8),
            Text(value, style: AppTextStyles.h4.copyWith(color: color)),
            Text(
              label,
              style: AppTextStyles.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Pending alert ────────────────────────────────────────────
class _PendingAlert extends StatelessWidget {
  final int remaining;
  final VoidCallback onViewRoute;
  const _PendingAlert({required this.remaining, required this.onViewRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewRoute,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.infoLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.infoBlue.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info_outline_rounded,
              color: AppColors.infoBlue,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$remaining pickups pending',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.infoBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Tap to view your route',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.infoBlue,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.infoBlue,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Next pickup card ─────────────────────────────────────────
class _NextPickupCard extends StatelessWidget {
  final VoidCallback onTap;
  const _NextPickupCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          border: Border.all(color: AppColors.borderGreen),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.greenLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.person_pin_circle_rounded,
                color: AppColors.forestGreen,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ama Mbarga',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Quartier Bastos · 7:00 – 10:00 AM',
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      _WasteChip(label: 'Plastic'),
                      SizedBox(width: 6),
                      _WasteChip(label: 'Organic'),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}

class _WasteChip extends StatelessWidget {
  final String label;
  const _WasteChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.greenLighter,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.forestGreen,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
