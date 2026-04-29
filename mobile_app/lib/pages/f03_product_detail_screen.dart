import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';
// Importing shared model + data
import 'f02_marketplace_catalog_screen.dart';

// ═════════════════════════════════════════════════════════════
// F-03 — Product Detail Screen
// ═════════════════════════════════════════════════════════════

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _StockBadge extends StatelessWidget {
  final ManureProduct product;
  const _StockBadge({required this.product});

  @override
  Widget build(BuildContext context) {
    if (product.isOutOfStock) {
      return _badge('Out of Stock', AppColors.errorRed, AppColors.errorLight);
    }
    if (product.isLowStock) {
      return _badge(
        'Only ${product.stockQty} left',
        AppColors.warningAmber,
        AppColors.warningLight,
      );
    }
    return _badge('In Stock', AppColors.successGreen, AppColors.successLight);
  }

  Widget _badge(String label, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 9,
        ),
      ),
    );
  }
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String _paymentMethod = 'credits'; // 'credits' or 'cash'

  ManureProduct get _product => kDemoProducts.firstWhere(
    (p) => p.id == widget.productId,
    orElse: () => kDemoProducts.first,
  );

  int get _totalCredits => _product.creditPrice * _quantity;
  double get _totalCash => _product.cashPriceXaf * _quantity;

  void _addToCart() {
    // TODO: CartBloc.add(AddItem(product: _product, qty: _quantity, payMethod: _paymentMethod))
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity × ${_product.name} to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: AppColors.creditGold,
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = _product;

    // Wrap with FarmerScaffold and set currentTab to FarmerNavTab.orders
    return FarmerScaffold(
      currentTab: FarmerNavTab.orders, // Highlights the Orders tab
      body: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            // ── Hero SliverAppBar ────────────────────────────────
            SliverAppBar(
              expandedHeight: 240,
              pinned: true,
              leading: const BackButton(color: AppColors.white),
              backgroundColor: AppColors.forestGreen,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.white,
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.cart),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: [
                    Container(
                      color: AppColors.greenLighter,
                      child: Center(
                        child: Text(
                          p.emoji,
                          style: const TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: _StockBadge(product: p),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Name & unit ──────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.name, style: AppTextStyles.h2),
                              const SizedBox(height: 4),
                              Text(
                                p.unitLabel,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greenLighter,
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusPill,
                            ),
                          ),
                          child: Text(
                            p.npkProfile,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.forestGreen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Description ──────────────────────────────
                    Text(
                      p.description,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.65,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Benefits ─────────────────────────────────
                    Text('Key Benefits', style: AppTextStyles.h4),
                    const SizedBox(height: 10),
                    ...p.benefits.map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: AppColors.successLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_rounded,
                                color: AppColors.successGreen,
                                size: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(b, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Payment method toggle ────────────────────
                    Text('Payment Method', style: AppTextStyles.h4),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _PaymentToggle(
                          label: 'CRF Credits',
                          icon: Icons.stars_rounded,
                          value: 'credits',
                          selected: _paymentMethod,
                          onTap: () =>
                              setState(() => _paymentMethod = 'credits'),
                          color: AppColors.forestGreen,
                          bg: AppColors.greenLighter,
                        ),
                        const SizedBox(width: 10),
                        _PaymentToggle(
                          label: 'Cash on Delivery',
                          icon: Icons.payments_outlined,
                          value: 'cash',
                          selected: _paymentMethod,
                          onTap: () => setState(() => _paymentMethod = 'cash'),
                          color: AppColors.earthBrown,
                          bg: AppColors.brownLighter,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ── Price display ─────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusL,
                        ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Unit price',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                _paymentMethod == 'credits'
                                    ? '${p.creditPrice} pts'
                                    : 'XAF ${p.cashPriceXaf.toStringAsFixed(0)}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Quantity stepper
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quantity',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              _QuantityStepper(
                                value: _quantity,
                                max: p.stockQty > 0 ? p.stockQty : 0,
                                onChanged: (v) => setState(() => _quantity = v),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: AppTextStyles.h4),
                              Text(
                                _paymentMethod == 'credits'
                                    ? '$_totalCredits pts'
                                    : 'XAF ${_totalCash.toStringAsFixed(0)}',
                                style: AppTextStyles.h3.copyWith(
                                  color: AppColors.forestGreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ── Sticky bottom CTA ────────────────────────────────────
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          color: AppColors.white,
          child: CrrfPrimaryButton(
            label: p.isOutOfStock ? 'Out of Stock' : 'Add to Cart',
            onPressed: p.isOutOfStock ? null : _addToCart,
            leadingIcon: Icons.shopping_cart_rounded,
          ),
        ),
      ),
    );
  }
}

// ─── Payment method toggle tile ───────────────────────────────
class _PaymentToggle extends StatelessWidget {
  final String label, value, selected;
  final IconData icon;
  final Color color, bg;
  final VoidCallback onTap;

  const _PaymentToggle({
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
    required this.onTap,
    required this.color,
    required this.bg,
  });

  bool get isSelected => value == selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? bg : AppColors.surfaceGray,
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? color : AppColors.textHint,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? color : AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle_rounded, color: color, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Quantity stepper ─────────────────────────────────────────
class _QuantityStepper extends StatelessWidget {
  final int value, max;
  final void Function(int) onChanged;

  const _QuantityStepper({
    required this.value,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepBtn(
          icon: Icons.remove_rounded,
          onTap: value > 1 ? () => onChanged(value - 1) : null,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          child: Text('$value', style: AppTextStyles.h4),
        ),
        _StepBtn(
          icon: Icons.add_rounded,
          onTap: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
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
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: onTap != null ? AppColors.greenLighter : AppColors.surfaceGray,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18,
          color: onTap != null ? AppColors.forestGreen : AppColors.textHint,
        ),
      ),
    );
  }
}
