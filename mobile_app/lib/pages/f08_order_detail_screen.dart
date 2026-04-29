import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// F-08 — Order Detail Screen
// ═════════════════════════════════════════════════════════════
/// Full order view with:
///   • Status timeline (Ordered → Processing → Out for Delivery → Delivered)
///   • Items list
///   • Payment breakdown
///   • Driver contact + delivery address
class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // TODO: Fetch real data via OrderBloc using orderId
    const status = OrderStatus.outForDelivery;

    return FarmerScaffold(
      currentTab: FarmerNavTab.orders,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Order Detail'),
          leading: const BackButton(),
          actions: [
            TextButton.icon(
              onPressed: () {}, // TODO: share/download receipt
              icon: const Icon(Icons.share_outlined, size: 18),
              label: const Text('Share'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.forestGreen,
              ),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── Status timeline ────────────────────────────────
            _StatusTimeline(currentStatus: status),

            const SizedBox(height: 20),

            // ── Items card ────────────────────────────────────
            _SectionCard(
              title: 'Items Ordered',
              child: Column(
                children: [
                  _ItemRow(
                    emoji: '🌿',
                    name: 'Premium Organic Manure',
                    unit: '25 kg bag',
                    qty: 1,
                    price: '80 pts',
                  ),
                  const Divider(height: 16),
                  _ItemRow(
                    emoji: '💧',
                    name: 'Liquid Bio-Fertiliser',
                    unit: '5 litre bottle',
                    qty: 2,
                    price: '120 pts',
                  ),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.h4),
                      Text(
                        '200 pts',
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.forestGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Delivery info ─────────────────────────────────
            _SectionCard(
              title: 'Delivery Information',
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value:
                        'Quartier Bastos, Yaounde\nNear the blue water tower',
                  ),
                  const Divider(height: 16),
                  _DetailRow(
                    icon: Icons.schedule_rounded,
                    label: 'Window',
                    value: 'Tomorrow · Morning (7–12 PM)',
                  ),
                  const Divider(height: 16),
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Driver',
                    value: 'Didier T. · +237 6XX XXX XXX',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Payment card ──────────────────────────────────
            _SectionCard(
              title: 'Payment',
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.stars_rounded,
                    label: 'CRF Credits used',
                    value: '200 pts',
                  ),
                  const Divider(height: 16),
                  _DetailRow(
                    icon: Icons.payments_outlined,
                    label: 'Cash on delivery',
                    value: 'None',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Cancel option (only if ordered/processing) ────
            if (status == OrderStatus.ordered ||
                status == OrderStatus.processing)
              CrrfSecondaryButton(
                label: 'Cancel Order',
                onPressed: () => _showCancelDialog(context),
                leadingIcon: Icons.cancel_outlined,
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel Order?'),
        content: const Text(
          'Credits will be refunded to your wallet within a few minutes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Order'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: OrderBloc.cancelOrder(orderId)
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.errorRed),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

// ─── Status timeline ──────────────────────────────────────────
class _StatusTimeline extends StatelessWidget {
  final OrderStatus currentStatus;
  const _StatusTimeline({required this.currentStatus});

  static const _steps = [
    _TimelineStep(
      status: OrderStatus.ordered,
      label: 'Ordered',
      icon: Icons.check_circle_outline_rounded,
    ),
    _TimelineStep(
      status: OrderStatus.processing,
      label: 'Processing',
      icon: Icons.inventory_2_outlined,
    ),
    _TimelineStep(
      status: OrderStatus.outForDelivery,
      label: 'Out for Delivery',
      icon: Icons.local_shipping_outlined,
    ),
    _TimelineStep(
      status: OrderStatus.delivered,
      label: 'Delivered',
      icon: Icons.home_outlined,
    ),
  ];

  int get _currentIndex {
    switch (currentStatus) {
      case OrderStatus.ordered:
        return 0;
      case OrderStatus.processing:
        return 1;
      case OrderStatus.outForDelivery:
        return 2;
      case OrderStatus.delivered:
        return 3;
      case OrderStatus.cancelled:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentStatus == OrderStatus.cancelled) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.cancel_rounded,
              color: AppColors.errorRed,
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              'This order was cancelled.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.errorRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
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
        children: List.generate(_steps.length, (i) {
          final isDone = i <= _currentIndex;
          final isCurrent = i == _currentIndex;
          final isLast = i == _steps.length - 1;

          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // Circle
                      AnimatedContainer(
                        duration: AppConstants.animNormal,
                        width: isCurrent ? 32 : 26,
                        height: isCurrent ? 32 : 26,
                        decoration: BoxDecoration(
                          color: isDone
                              ? AppColors.forestGreen
                              : AppColors.surfaceGray,
                          shape: BoxShape.circle,
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: AppColors.forestGreen.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          _steps[i].icon,
                          color: isDone ? AppColors.white : AppColors.textHint,
                          size: isCurrent ? 18 : 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _steps[i].label,
                        style: AppTextStyles.caption.copyWith(
                          color: isDone
                              ? AppColors.forestGreen
                              : AppColors.textHint,
                          fontWeight: isCurrent
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                // Connector line
                if (!isLast)
                  Container(
                    width: 16,
                    height: 2,
                    color: i < _currentIndex
                        ? AppColors.forestGreen
                        : AppColors.borderLight,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _TimelineStep {
  final OrderStatus status;
  final String label;
  final IconData icon;
  const _TimelineStep({
    required this.status,
    required this.label,
    required this.icon,
  });
}

// ─── Item row ─────────────────────────────────────────────────
class _ItemRow extends StatelessWidget {
  final String emoji, name, unit, price;
  final int qty;
  const _ItemRow({
    required this.emoji,
    required this.name,
    required this.unit,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('$unit · Qty: $qty', style: AppTextStyles.caption),
            ],
          ),
        ),
        Text(
          price,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ─── Section card ─────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

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
          child,
        ],
      ),
    );
  }
}

// ─── Detail row ───────────────────────────────────────────────
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
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
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
