import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

/// F-01 — Farmer Dashboard
///
/// Home screen for farmer users. Sections:
///   • Greeting + notification bell + profile avatar
///   • Seasonal promo banner (scrollable)
///   • Quick stats row: CRF Balance / Active Orders / Total Purchases
///   • "Shop Now" primary CTA
///   • Recent orders (last 3)
///   • Quick-action grid (Shop, Orders, Micro-Loan, Support)
class FarmerDashboardScreen extends StatefulWidget {
  const FarmerDashboardScreen({super.key});

  @override
  State<FarmerDashboardScreen> createState() => _FarmerDashboardScreenState();
}

class _FarmerDashboardScreenState extends State<FarmerDashboardScreen> {
  // TODO: Replace with FarmerBloc / Riverpod provider data
  final String _userName = 'Emmanuel';
  final int _creditBalance = 120;
  final int _activeOrders = 1;
  final int _totalPurchases = 5;

  final List<_RecentOrder> _recentOrders = [
    _RecentOrder(
      id: 'ORD-2026-00041',
      product: 'Premium Organic Manure · 25 kg',
      date: 'Yesterday',
      status: OrderStatus.outForDelivery,
      total: '80 pts',
    ),
    _RecentOrder(
      id: 'ORD-2026-00028',
      product: 'Standard Compost · 10 kg',
      date: '10 Apr',
      status: OrderStatus.delivered,
      total: '35 pts',
    ),
    _RecentOrder(
      id: 'ORD-2026-00019',
      product: 'Premium Organic Manure · 50 kg',
      date: '28 Mar',
      status: OrderStatus.delivered,
      total: '150 pts',
    ),
  ];

  final List<_PromoBanner> _promos = [
    _PromoBanner(
      title: 'Planting Season Special',
      subtitle: 'Get 20% more manure for the same credits — April only.',
      emoji: '🌱',
      color: AppColors.forestGreen,
      bg: AppColors.greenLighter,
    ),
    _PromoBanner(
      title: 'New: Liquid Bio-Fertiliser',
      subtitle: 'Now available in the marketplace. Try it today.',
      emoji: '💧',
      color: AppColors.infoBlue,
      bg: AppColors.infoLight,
    ),
    _PromoBanner(
      title: 'Earn Credits Too!',
      subtitle: 'Refer a household neighbour and earn 50 bonus credits.',
      emoji: '🎁',
      color: AppColors.creditGold,
      bg: AppColors.goldLighter,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // ─────────────────────────────────────────────────────────
    // CHANGE: Wrap with FarmerScaffold instead of plain Scaffold.
    // Pass currentTab: FarmerNavTab.home so the Home icon is active.
    // The body is exactly the same CustomScrollView as before —
    // nothing inside it changes at all.
    // ─────────────────────────────────────────────────────────
    return FarmerScaffold(
      currentTab: FarmerNavTab.home,
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
                Text('Welcome, $_userName 🌾', style: AppTextStyles.h4),
                Text('CRRF Farmer Portal', style: AppTextStyles.caption),
              ],
            ),
            actions: [
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
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.profile),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.brownLight,
                    child: Text(
                      _userName[0],
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.earthBrown,
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

                  // ── Promo banners ─────────────────────────────
                  SizedBox(
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _promos.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) =>
                          _PromoBannerCard(promo: _promos[i]),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Stats row ────────────────────────────────
                  _StatsRow(
                    credits: _creditBalance,
                    activeOrders: _activeOrders,
                    totalPurchases: _totalPurchases,
                  ),

                  const SizedBox(height: 20),

                  // ── Shop Now CTA ──────────────────────────────
                  _ShopNowButton(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.marketplace),
                  ),

                  const SizedBox(height: 24),

                  // ── Quick actions ────────────────────────────
                  const _FarmerQuickActions(),

                  const SizedBox(height: 24),

                  // ── Recent orders ────────────────────────────
                  SectionHeader(
                    title: 'Recent Orders',
                    actionLabel: 'See All',
                    onAction: () =>
                        Navigator.of(context).pushNamed(AppRoutes.orderHistory),
                  ),

                  const SizedBox(height: 12),

                  if (_recentOrders.isEmpty)
                    EmptyStateWidget(
                      icon: Icons.shopping_bag_outlined,
                      title: 'No orders yet',
                      subtitle:
                          'Browse the marketplace and place your first manure order.',
                      actionLabel: 'Browse Products',
                      onAction: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.marketplace),
                    )
                  else
                    ..._recentOrders.map(
                      (o) => _RecentOrderCard(
                        order: o,
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.orderDetail,
                          arguments: {'orderId': o.id},
                        ),
                      ),
                    ),

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

// ─── Promo Banner ─────────────────────────────────────────────
class _PromoBanner {
  final String title, subtitle, emoji;
  final Color color, bg;
  const _PromoBanner({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.bg,
  });
}

class _PromoBannerCard extends StatelessWidget {
  final _PromoBanner promo;
  const _PromoBannerCard({required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: promo.bg,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: promo.color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(promo.emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  promo.title,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: promo.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  promo.subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final int credits, activeOrders, totalPurchases;
  const _StatsRow({
    required this.credits,
    required this.activeOrders,
    required this.totalPurchases,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          value: '$credits pts',
          label: 'CRF Credits',
          icon: Icons.stars_rounded,
          color: AppColors.creditGold,
          bg: AppColors.goldLighter,
        ),
        const SizedBox(width: 10),
        _StatCard(
          value: '$activeOrders',
          label: 'Active Orders',
          icon: Icons.local_shipping_rounded,
          color: AppColors.infoBlue,
          bg: AppColors.infoLight,
        ),
        const SizedBox(width: 10),
        _StatCard(
          value: '$totalPurchases',
          label: 'Purchases',
          icon: Icons.shopping_bag_rounded,
          color: AppColors.forestGreen,
          bg: AppColors.greenLighter,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color, bg;
  const _StatCard({
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
            const SizedBox(height: 10),
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

// ─── Shop Now CTA ─────────────────────────────────────────────
class _ShopNowButton extends StatelessWidget {
  final VoidCallback onTap;
  const _ShopNowButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.earthBrown, AppColors.brownMid],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.earthBrown.withValues(alpha: 0.35),
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
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.agriculture_rounded,
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
                    'Shop Manure Products',
                    style: AppTextStyles.h4.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Pay with CRF Credits or cash on delivery',
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

// ─── Quick Actions ────────────────────────────────────────────
class _FarmerQuickActions extends StatelessWidget {
  const _FarmerQuickActions();

  static const _actions = [
    _QuickAction(
      icon: Icons.store_rounded,
      label: 'Marketplace',
      route: AppRoutes.marketplace,
      color: AppColors.earthBrown,
      bg: AppColors.brownLighter,
    ),
    _QuickAction(
      icon: Icons.receipt_long_rounded,
      label: 'My Orders',
      route: AppRoutes.orderHistory,
      color: AppColors.forestGreen,
      bg: AppColors.greenLighter,
    ),
    _QuickAction(
      icon: Icons.account_balance_rounded,
      label: 'Micro-Loan',
      route: AppRoutes.microLoanInfo,
      color: AppColors.creditGold,
      bg: AppColors.goldLighter,
    ),
    _QuickAction(
      icon: Icons.help_outline_rounded,
      label: 'Support',
      route: AppRoutes.support,
      color: AppColors.infoBlue,
      bg: AppColors.infoLight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      childAspectRatio: 0.85,
      children: _actions.map((a) => _QuickActionTile(action: a)).toList(),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label, route;
  final Color color, bg;
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

// ─── Recent Order Card ────────────────────────────────────────
class _RecentOrder {
  final String id, product, date, total;
  final OrderStatus status;
  const _RecentOrder({
    required this.id,
    required this.product,
    required this.date,
    required this.status,
    required this.total,
  });
}

class _RecentOrderCard extends StatelessWidget {
  final _RecentOrder order;
  final VoidCallback onTap;
  const _RecentOrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.brownLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: const Icon(
                Icons.agriculture_rounded,
                color: AppColors.earthBrown,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.id,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      StatusBadge.fromOrderStatus(order.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order.product,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.date, style: AppTextStyles.caption),
                      Text(
                        order.total,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.forestGreen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
