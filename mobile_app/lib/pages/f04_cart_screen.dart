import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import 'f02_marketplace_catalog_screen.dart' show kDemoProducts, ManureProduct;

// ─── Shared cart item model ────────────────────────────────────
class CartItem {
  final ManureProduct product;
  final int quantity;
  final String paymentMethod; // 'credits' | 'cash'

  const CartItem({
    required this.product,
    required this.quantity,
    required this.paymentMethod,
  });

  int get totalCredits => product.creditPrice * quantity;
  double get totalCash => product.cashPriceXaf * quantity;
}

// ─── Demo cart state (replace with CartBloc) ──────────────────
final List<CartItem> kDemoCart = [
  CartItem(product: kDemoProducts[0], quantity: 1, paymentMethod: 'credits'),
  CartItem(product: kDemoProducts[2], quantity: 2, paymentMethod: 'credits'),
];

// ═════════════════════════════════════════════════════════════
// F-04 — Cart / Order Review Screen
// ═════════════════════════════════════════════════════════════
/// Shows all cart items, subtotals, and payment breakdown.
/// Farmer can edit quantity or remove items.
/// CTA → Delivery Details (F-05).
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // TODO: Replace with CartBloc state
  List<CartItem> _items = List.from(kDemoCart);

  // TODO: Replace with WalletBloc — current balance
  final int _availableCredits = 340;

  int get _totalCredits => _items
      .where((i) => i.paymentMethod == 'credits')
      .fold(0, (sum, i) => sum + i.totalCredits);

  double get _totalCash => _items
      .where((i) => i.paymentMethod == 'cash')
      .fold(0.0, (sum, i) => sum + i.totalCash);

  bool get _hasEnoughCredits => _availableCredits >= _totalCredits;

  void _removeItem(int index) => setState(() => _items.removeAt(index));

  void _updateQty(int index, int qty) {
    setState(() {
      _items[index] = CartItem(
        product: _items[index].product,
        quantity: qty,
        paymentMethod: _items[index].paymentMethod,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FarmerScaffold(
      currentTab: FarmerNavTab.orders,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Review Order'),
          leading: const BackButton(),
          actions: [
            if (_items.isNotEmpty)
              TextButton(
                onPressed: () => setState(() => _items.clear()),
                child: Text(
                  'Clear',
                  style: AppTextStyles.buttonSmall.copyWith(
                    color: AppColors.errorRed,
                  ),
                ),
              ),
          ],
        ),
        body: _items.isEmpty
            ? EmptyStateWidget(
                icon: Icons.shopping_cart_outlined,
                title: 'Your cart is empty',
                subtitle:
                    'Browse the marketplace and add products to your order.',
                actionLabel: 'Browse Products',
                onAction: () =>
                    Navigator.of(context).pushNamed(AppRoutes.marketplace),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // ── Cart items ──────────────────────────
                        ...List.generate(
                          _items.length,
                          (i) => _CartItemTile(
                            item: _items[i],
                            onRemove: () => _removeItem(i),
                            onQtyChanged: (q) => _updateQty(i, q),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Order summary ───────────────────────
                        _OrderSummaryCard(
                          totalCredits: _totalCredits,
                          totalCash: _totalCash,
                          availableCredits: _availableCredits,
                          hasEnoughCredits: _hasEnoughCredits,
                        ),

                        const SizedBox(height: 12),

                        // ── Balance warning ─────────────────────
                        if (!_hasEnoughCredits && _totalCredits > 0)
                          const CalloutCard(
                            message:
                                'Insufficient CRF Credits. Change one or more items to Cash on Delivery.',
                            type: CalloutType.warning,
                          ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),

                  // ── Sticky CTA ──────────────────────────────────
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 12,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    child: CrrfPrimaryButton(
                      label: _hasEnoughCredits
                          ? 'Continue to Delivery'
                          : 'Check Credit Balance',
                      onPressed: _hasEnoughCredits
                          ? () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.deliveryDetails)
                          : () => Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.voucher),
                      leadingIcon: _hasEnoughCredits
                          ? Icons.local_shipping_outlined
                          : Icons.account_balance_wallet_outlined,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─── Cart item tile ───────────────────────────────────────────
class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final void Function(int) onQtyChanged;

  const _CartItemTile({
    required this.item,
    required this.onRemove,
    required this.onQtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    final isCredits = item.paymentMethod == 'credits';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          Row(
            children: [
              // Emoji thumb
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.greenLighter,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Center(
                  child: Text(p.emoji, style: const TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(p.unitLabel, style: AppTextStyles.caption),
                    const SizedBox(height: 4),
                    // Payment badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isCredits
                            ? AppColors.greenLighter
                            : AppColors.brownLighter,
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusPill,
                        ),
                      ),
                      child: Text(
                        isCredits ? '♻ Credits' : '💵 Cash on Delivery',
                        style: AppTextStyles.caption.copyWith(
                          color: isCredits
                              ? AppColors.forestGreen
                              : AppColors.earthBrown,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Remove button
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.errorRed,
                  size: 20,
                ),
                onPressed: onRemove,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Qty stepper
              Row(
                children: [
                  _StepBtn(
                    icon: Icons.remove_rounded,
                    onTap: item.quantity > 1
                        ? () => onQtyChanged(item.quantity - 1)
                        : null,
                  ),
                  Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: Text('${item.quantity}', style: AppTextStyles.h4),
                  ),
                  _StepBtn(
                    icon: Icons.add_rounded,
                    onTap: item.quantity < p.stockQty
                        ? () => onQtyChanged(item.quantity + 1)
                        : null,
                  ),
                ],
              ),
              // Subtotal
              Text(
                isCredits
                    ? '${item.totalCredits} pts'
                    : 'XAF ${item.totalCash.toStringAsFixed(0)}',
                style: AppTextStyles.h4.copyWith(color: AppColors.forestGreen),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _StepBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.greenLighter : AppColors.surfaceGray,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 17,
          color: onTap != null ? AppColors.forestGreen : AppColors.textHint,
        ),
      ),
    );
  }
}

// ─── Order summary card ───────────────────────────────────────
class _OrderSummaryCard extends StatelessWidget {
  final int totalCredits, availableCredits;
  final double totalCash;
  final bool hasEnoughCredits;

  const _OrderSummaryCard({
    required this.totalCredits,
    required this.totalCash,
    required this.availableCredits,
    required this.hasEnoughCredits,
  });

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
          Text('Order Summary', style: AppTextStyles.h4),
          const SizedBox(height: 14),
          if (totalCredits > 0) ...[
            _SummaryRow(
              label: 'Credits subtotal',
              value: '$totalCredits pts',
              color: hasEnoughCredits
                  ? AppColors.forestGreen
                  : AppColors.errorRed,
            ),
            _SummaryRow(
              label: 'Your balance',
              value: '$availableCredits pts',
              color: AppColors.textSecondary,
            ),
            const Divider(height: 16),
          ],
          if (totalCash > 0)
            _SummaryRow(
              label: 'Cash on delivery',
              value: 'XAF ${totalCash.toStringAsFixed(0)}',
              color: AppColors.earthBrown,
            ),
          const SizedBox(height: 8),
          _SummaryRow(
            label: 'Delivery',
            value: 'Free',
            color: AppColors.successGreen,
            isBold: false,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final Color color;
  final bool isBold;
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.color,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
