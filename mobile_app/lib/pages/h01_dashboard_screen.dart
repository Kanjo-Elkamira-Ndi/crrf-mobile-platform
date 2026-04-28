import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

/// H-01 — Household Dashboard
///
/// Primary home screen for household users.
/// Sections:
///   • Greeting + notification bell
///   • CRF Credit balance hero card
///   • "Request Collection" primary CTA
///   • Upcoming pickup banner (if any)
///   • Recent activity feed (last 3 transactions)
///   • Quick-action grid (Wallet, History, Guide, Impact)
class HouseholdDashboardScreen extends StatefulWidget {
  const HouseholdDashboardScreen({super.key});

  @override
  State<HouseholdDashboardScreen> createState() =>
      _HouseholdDashboardScreenState();
}

class _HouseholdDashboardScreenState extends State<HouseholdDashboardScreen> {
  // TODO: Replace with real data from HouseholdBloc / Riverpod provider
  final String _userName = 'Ama';
  final int _creditBalance = 340;
  final bool _hasUpcomingPickup = true;
  final String _pickupDate = 'Tomorrow, 7:00 – 10:00 AM';
  final String _pickupStatus = 'Confirmed';

  final List<_ActivityItem> _recentActivity = [
    _ActivityItem(
      label: 'Plastic pickup confirmed',
      date: 'Today, 9:14 AM',
      amount: 30,
      icon: Icons.recycling_rounded,
    ),
    _ActivityItem(
      label: 'Manure purchase — 25 kg bag',
      date: 'Yesterday, 3:40 PM',
      amount: -80,
      icon: Icons.shopping_bag_outlined,
    ),
    _ActivityItem(
      label: 'Organic pickup confirmed',
      date: '12 Apr, 8:02 AM',
      amount: 15,
      icon: Icons.eco_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ─────────────────────────────────────────
          SliverAppBar(
            backgroundColor: AppColors.white,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 1,
            shadowColor: AppColors.shadow,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good morning, $_userName 👋', style: AppTextStyles.h4),
                Text(AppConstants.appFullName, style: AppTextStyles.caption),
              ],
            ),
            actions: [
              // Notifications
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    color: AppColors.textPrimary,
                    onPressed: () => Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.notifications),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.errorRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              // Profile
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.profile),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.greenLight,
                    child: Text(
                      _userName[0],
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.forestGreen,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ── Credit Balance Hero Card ────────────────
                  _CreditBalanceCard(
                    balance: _creditBalance,
                    onWalletTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.voucher),
                  ),

                  const SizedBox(height: 20),

                  // ── Primary CTA — Request Collection ─────────
                  _RequestCollectionButton(
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.schedulePickup),
                  ),

                  const SizedBox(height: 20),

                  // ── Upcoming Pickup Banner ────────────────────
                  if (_hasUpcomingPickup)
                    _UpcomingPickupBanner(
                      date: _pickupDate,
                      status: _pickupStatus,
                      onTap: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.pickupHistory),
                    ),

                  if (_hasUpcomingPickup) const SizedBox(height: 20),

                  // ── Quick Actions ─────────────────────────────
                  const _QuickActionGrid(),

                  const SizedBox(height: 24),

                  // ── Recent Activity ───────────────────────────
                  SectionHeader(
                    title: 'Recent Activity',
                    actionLabel: 'See All',
                    onAction: () =>
                        Navigator.of(context).pushNamed(AppRoutes.voucher),
                  ),

                  const SizedBox(height: 12),

                  ..._recentActivity.map((item) => _ActivityRow(item: item)),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Credit Balance Hero Card
// ─────────────────────────────────────────────────────────────
class _CreditBalanceCard extends StatelessWidget {
  final int balance;
  final VoidCallback onWalletTap;

  const _CreditBalanceCard({required this.balance, required this.onWalletTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.forestGreen, AppColors.greenMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'CRF Credit Balance',
                    style: AppTextStyles.labelUppercase.copyWith(
                      color: AppColors.white.withValues(alpha: 0.8),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onWalletTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(
                      AppConstants.radiusPill,
                    ),
                  ),
                  child: Text(
                    'View Wallet',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Balance amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$balance',
                style: AppTextStyles.creditBalance.copyWith(
                  color: AppColors.white,
                  fontSize: 52,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                child: Text(
                  'pts',
                  style: AppTextStyles.creditUnit.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stats row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Row(
              children: [
                _StatPill(icon: Icons.recycling_rounded, label: '12 pickups'),
                Container(
                  width: 1,
                  height: 18,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: AppColors.white.withValues(alpha: 0.3),
                ),
                _StatPill(
                  icon: Icons.schedule_rounded,
                  label: 'Expires Dec 2026',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.white.withValues(alpha: 0.8), size: 14),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Request Collection CTA Button
// ─────────────────────────────────────────────────────────────
class _RequestCollectionButton extends StatelessWidget {
  final VoidCallback onTap;
  const _RequestCollectionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.creditGold,
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.creditGold.withValues(alpha: 0.4),
              blurRadius: 16,
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
                color: AppColors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.local_shipping_rounded,
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
                    'Request Collection',
                    style: AppTextStyles.h4.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Schedule a free waste pickup today',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
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

// ─────────────────────────────────────────────────────────────
// Upcoming Pickup Banner
// ─────────────────────────────────────────────────────────────
class _UpcomingPickupBanner extends StatelessWidget {
  final String date;
  final String status;
  final VoidCallback onTap;

  const _UpcomingPickupBanner({
    required this.date,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greenLighter,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.borderGreen),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.forestGreen,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.event_rounded,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Pickup',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.forestGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            StatusBadge(
              label: status,
              color: AppColors.successGreen,
              backgroundColor: AppColors.successLight,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Quick Action Grid (2x2)
// ─────────────────────────────────────────────────────────────
class _QuickActionGrid extends StatelessWidget {
  const _QuickActionGrid();

  static const _actions = [
    _QuickAction(
      icon: Icons.account_balance_wallet_rounded,
      label: 'My Wallet',
      route: AppRoutes.voucher,
      color: AppColors.forestGreen,
      bg: AppColors.greenLighter,
    ),
    _QuickAction(
      icon: Icons.history_rounded,
      label: 'Pickups',
      route: AppRoutes.pickupHistory,
      color: AppColors.earthBrown,
      bg: AppColors.brownLighter,
    ),
    _QuickAction(
      icon: Icons.menu_book_rounded,
      label: 'Waste Guide',
      route: AppRoutes.wasteGuide,
      color: AppColors.infoBlue,
      bg: AppColors.infoLight,
    ),
    _QuickAction(
      icon: Icons.insights_rounded,
      label: 'My Impact',
      route: AppRoutes.impactSummary,
      color: AppColors.creditGold,
      bg: AppColors.goldLighter,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 0,
      childAspectRatio: 0.85,
      children: _actions.map((a) => _QuickActionTile(action: a)).toList(),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final String route;
  final Color color;
  final Color bg;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
    required this.color,
    required this.bg,
  });
}

class _QuickActionTile extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(action.route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: action.bg,
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Icon(action.icon, color: action.color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            action.label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Recent Activity Row
// ─────────────────────────────────────────────────────────────
class _ActivityItem {
  final String label;
  final String date;
  final int amount;
  final IconData icon;
  const _ActivityItem({
    required this.label,
    required this.date,
    required this.amount,
    required this.icon,
  });
}

class _ActivityRow extends StatelessWidget {
  final _ActivityItem item;
  const _ActivityRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final isCredit = item.amount > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCredit ? AppColors.greenLighter : AppColors.brownLighter,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Icon(
              item.icon,
              color: isCredit ? AppColors.forestGreen : AppColors.earthBrown,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(item.date, style: AppTextStyles.caption),
              ],
            ),
          ),
          CreditChip(amount: item.amount.abs(), isEarned: isCredit),
        ],
      ),
    );
  }
}
