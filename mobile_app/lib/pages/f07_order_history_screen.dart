import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// F-07 — Order History Screen
// ═════════════════════════════════════════════════════════════
/// Chronological list of all farmer orders.
/// Filterable by status. Each row taps to F-08 Order Detail.
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderStatus? _filterStatus;

  // TODO: Replace with OrderBloc data
  final List<_OrderEntry> _orders = [
    _OrderEntry(
      id: 'ORD-2026-00042',
      summary: 'Premium Organic Manure × 1 + Liquid Bio-Fertiliser × 2',
      date: 'Today',
      status: OrderStatus.ordered,
      totalCredits: 200,
      totalCash: 0,
    ),
    _OrderEntry(
      id: 'ORD-2026-00041',
      summary: 'Premium Organic Manure · 25 kg',
      date: 'Yesterday',
      status: OrderStatus.outForDelivery,
      totalCredits: 80,
      totalCash: 0,
    ),
    _OrderEntry(
      id: 'ORD-2026-00028',
      summary: 'Standard Compost Mix · 10 kg',
      date: '10 Apr 2026',
      status: OrderStatus.delivered,
      totalCredits: 35,
      totalCash: 0,
    ),
    _OrderEntry(
      id: 'ORD-2026-00019',
      summary: 'Premium Organic Manure · 50 kg',
      date: '28 Mar 2026',
      status: OrderStatus.delivered,
      totalCredits: 0,
      totalCash: 4500,
    ),
    _OrderEntry(
      id: 'ORD-2026-00011',
      summary: 'Vermicompost · 5 kg',
      date: '15 Mar 2026',
      status: OrderStatus.cancelled,
      totalCredits: 45,
      totalCash: 0,
    ),
  ];

  List<_OrderEntry> get _filtered => _filterStatus == null
      ? _orders
      : _orders.where((o) => o.status == _filterStatus).toList();

  @override
  Widget build(BuildContext context) {
    return FarmerScaffold(
      currentTab: FarmerNavTab.orders,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('My Orders'),
          leading: const BackButton(),
        ),
        body: Column(
          children: [
            // ── Filter chips ───────────────────────────────────
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  _FilterChip(
                    label: 'All',
                    isActive: _filterStatus == null,
                    onTap: () => setState(() => _filterStatus = null),
                  ),
                  _FilterChip(
                    label: 'Active',
                    isActive: _filterStatus == OrderStatus.ordered,
                    onTap: () =>
                        setState(() => _filterStatus = OrderStatus.ordered),
                  ),
                  _FilterChip(
                    label: 'Out for Delivery',
                    isActive: _filterStatus == OrderStatus.outForDelivery,
                    onTap: () => setState(
                      () => _filterStatus = OrderStatus.outForDelivery,
                    ),
                  ),
                  _FilterChip(
                    label: 'Delivered',
                    isActive: _filterStatus == OrderStatus.delivered,
                    onTap: () =>
                        setState(() => _filterStatus = OrderStatus.delivered),
                  ),
                  _FilterChip(
                    label: 'Cancelled',
                    isActive: _filterStatus == OrderStatus.cancelled,
                    onTap: () =>
                        setState(() => _filterStatus = OrderStatus.cancelled),
                  ),
                ],
              ),
            ),

            // ── List ──────────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.receipt_long_outlined,
                      title: 'No orders found',
                      subtitle: 'Place your first order from the marketplace.',
                      actionLabel: 'Browse Products',
                      onAction: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.marketplace),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _OrderCard(
                        order: _filtered[i],
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.orderDetail,
                          arguments: {'orderId': _filtered[i].id},
                        ),
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoutes.marketplace),
          backgroundColor: AppColors.earthBrown,
          foregroundColor: AppColors.white,
          icon: const Icon(Icons.add_shopping_cart_rounded),
          label: const Text('New Order'),
        ),
      ),
    );
  }
}

class _OrderEntry {
  final String id, summary, date;
  final OrderStatus status;
  final int totalCredits;
  final double totalCash;

  const _OrderEntry({
    required this.id,
    required this.summary,
    required this.date,
    required this.status,
    required this.totalCredits,
    required this.totalCash,
  });

  String get priceDisplay => totalCredits > 0
      ? '$totalCredits pts'
      : 'XAF ${totalCash.toStringAsFixed(0)}';
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animFast,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.earthBrown : AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
          border: Border.all(
            color: isActive ? AppColors.earthBrown : AppColors.borderLight,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.buttonSmall.copyWith(
              color: isActive ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final _OrderEntry order;
  final VoidCallback onTap;
  const _OrderCard({required this.order, required this.onTap});

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
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    order.summary,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.date, style: AppTextStyles.caption),
                      Text(
                        order.priceDisplay,
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
