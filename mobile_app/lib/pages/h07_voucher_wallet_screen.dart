import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-07 — Voucher Wallet Screen
// ═════════════════════════════════════════════════════════════
/// Full wallet view with:
///   • Balance hero + expiry warning
///   • Filter tabs: All / Earned / Spent
///   • Chronological transaction ledger
class VoucherWalletScreen extends StatefulWidget {
  const VoucherWalletScreen({super.key});

  @override
  State<VoucherWalletScreen> createState() => _VoucherWalletScreenState();
}

class _VoucherWalletScreenState extends State<VoucherWalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // TODO: Replace with WalletBloc data
  final int _balance = 340;
  final int _expiringAmount = 80;
  final int _daysToExpiry = 18;

  final List<_TxEntry> _transactions = [
    _TxEntry(
      id: 'tx-001',
      desc: 'Plastic pickup · 3.0 kg',
      date: 'Today, 9:14 AM',
      amount: 30,
      type: TxType.earned,
      pickupRef: 'CRRF-2026-00130',
    ),
    _TxEntry(
      id: 'tx-002',
      desc: 'Manure purchase · 25 kg bag',
      date: 'Yesterday, 3:40 PM',
      amount: -80,
      type: TxType.spent,
      orderId: 'ORD-2026-00041',
    ),
    _TxEntry(
      id: 'tx-003',
      desc: 'Organic pickup · 1.5 kg',
      date: '12 Apr, 8:02 AM',
      amount: 8,
      type: TxType.earned,
      pickupRef: 'CRRF-2026-00118',
    ),
    _TxEntry(
      id: 'tx-004',
      desc: 'Plastic pickup · 2.0 kg',
      date: '3 Apr, 10:20 AM',
      amount: 20,
      type: TxType.earned,
      pickupRef: 'CRRF-2026-00089',
    ),
    _TxEntry(
      id: 'tx-005',
      desc: 'Credits expired',
      date: '1 Apr',
      amount: -40,
      type: TxType.expired,
      pickupRef: null,
    ),
  ];

  List<_TxEntry> get _filtered {
    final tab = _tabController.index;
    if (tab == 1)
      return _transactions.where((t) => t.type == TxType.earned).toList();
    if (tab == 2)
      return _transactions.where((t) => t.type == TxType.spent).toList();
    return _transactions;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar with balance hero ───────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: const BackButton(color: AppColors.white),
            backgroundColor: AppColors.forestGreen,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: _WalletHero(
                balance: _balance,
                expiringAmount: _expiringAmount,
                daysToExpiry: _daysToExpiry,
              ),
            ),
          ),

          // ── Expiry warning ───────────────────────────────────
          if (_daysToExpiry <= 30)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: CalloutCard(
                  message:
                      '$_expiringAmount pts expire in $_daysToExpiry days. Use them in the marketplace!',
                  type: CalloutType.warning,
                  icon: Icons.timer_outlined,
                ),
              ),
            ),

          // ── Tab bar ──────────────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabHeaderDelegate(
              TabBar(
                controller: _tabController,
                labelColor: AppColors.forestGreen,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.forestGreen,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: AppTextStyles.buttonSmall,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Earned'),
                  Tab(text: 'Spent'),
                ],
              ),
            ),
          ),

          // ── Transaction list ─────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
            sliver: _filtered.isEmpty
                ? SliverFillRemaining(
                    child: EmptyStateWidget(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'No transactions',
                      subtitle: 'Schedule a pickup to start earning credits.',
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _TxRow(
                        entry: _filtered[i],
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.transactionDetail,
                          arguments: {'txId': _filtered[i].id},
                        ),
                      ),
                      childCount: _filtered.length,
                    ),
                  ),
          ),
        ],
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

// ─── Wallet hero (inside FlexibleSpaceBar) ────────────────────
class _WalletHero extends StatelessWidget {
  final int balance;
  final int expiringAmount;
  final int daysToExpiry;

  const _WalletHero({
    required this.balance,
    required this.expiringAmount,
    required this.daysToExpiry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.forestGreen, AppColors.greenMid],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My CRF Wallet',
            style: AppTextStyles.labelUppercase.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$balance',
                style: AppTextStyles.creditBalance.copyWith(
                  color: AppColors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                child: Text(
                  'pts',
                  style: AppTextStyles.creditUnit.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _WalletStat(
                icon: Icons.north_east_rounded,
                label: 'Earned',
                value: '${balance + 80} pts total',
                color: AppColors.goldSoft,
              ),
              const SizedBox(width: 20),
              _WalletStat(
                icon: Icons.south_west_rounded,
                label: 'Spent',
                value: '80 pts',
                color: Colors.white70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _WalletStat({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ─── Tab header delegate ──────────────────────────────────────
class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  const _TabHeaderDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height + 1;
  @override
  double get maxExtent => tabBar.preferredSize.height + 1;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.white,
      child: Column(children: [tabBar, const Divider(height: 1)]),
    );
  }

  @override
  bool shouldRebuild(_TabHeaderDelegate old) => false;
}

// ─── Enums and models ─────────────────────────────────────────
enum TxType { earned, spent, expired }

class _TxEntry {
  final String id;
  final String desc;
  final String date;
  final int amount;
  final TxType type;
  final String? pickupRef;
  final String? orderId;

  const _TxEntry({
    required this.id,
    required this.desc,
    required this.date,
    required this.amount,
    required this.type,
    this.pickupRef,
    this.orderId,
  });
}

// ─── Transaction row ──────────────────────────────────────────
class _TxRow extends StatelessWidget {
  final _TxEntry entry;
  final VoidCallback onTap;
  const _TxRow({required this.entry, required this.onTap});

  IconData get _icon => switch (entry.type) {
        TxType.earned => Icons.recycling_rounded,
        TxType.spent => Icons.shopping_bag_outlined,
        TxType.expired => Icons.timer_off_outlined,
      };

  Color get _iconColor => switch (entry.type) {
        TxType.earned => AppColors.forestGreen,
        TxType.spent => AppColors.earthBrown,
        TxType.expired => AppColors.textTertiary,
      };

  Color get _iconBg => switch (entry.type) {
        TxType.earned => AppColors.greenLighter,
        TxType.spent => AppColors.brownLighter,
        TxType.expired => AppColors.surfaceGray,
      };

  @override
  Widget build(BuildContext context) {
    final isCredit = entry.amount > 0;
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
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _iconBg,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: Icon(_icon, color: _iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.desc,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(entry.date, style: AppTextStyles.caption),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isCredit ? "+" : ""}${entry.amount} pts',
                  style: AppTextStyles.transactionAmount.copyWith(
                    color: entry.type == TxType.expired
                        ? AppColors.textTertiary
                        : isCredit
                            ? AppColors.forestGreen
                            : AppColors.errorRed,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: AppColors.textHint,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}