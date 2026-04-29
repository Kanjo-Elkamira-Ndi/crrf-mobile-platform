import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ─── Shared product model (used across F-02, F-03, F-04) ─────
class ManureProduct {
  final String id, name, description, unitLabel, category;
  final int creditPrice;
  final double cashPriceXaf;
  final int stockQty;
  final String emoji;
  final List<String> benefits;
  final String npkProfile;
  final bool isAvailable;

  const ManureProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.unitLabel,
    required this.category,
    required this.creditPrice,
    required this.cashPriceXaf,
    required this.stockQty,
    required this.emoji,
    required this.benefits,
    required this.npkProfile,
    this.isAvailable = true,
  });

  bool get isLowStock => stockQty > 0 && stockQty <= 5;
  bool get isOutOfStock => stockQty == 0;
}

// ── Demo catalogue data ────────────────────────────────────────
const List<ManureProduct> kDemoProducts = [
  ManureProduct(
    id: 'p-001',
    name: 'Premium Organic Manure',
    description:
        'Fully composted household organic waste. Rich in nitrogen and phosphorus. Ideal for maize, cassava, and vegetable gardens.',
    unitLabel: '25 kg bag',
    category: 'compost',
    creditPrice: 80,
    cashPriceXaf: 2500,
    stockQty: 42,
    emoji: '🌿',
    benefits: [
      'Improves soil structure',
      'Boosts crop yield by up to 30%',
      'Slow-release nutrients',
      'Reduces chemical fertiliser need',
    ],
    npkProfile: 'N: 2.1% · P: 1.4% · K: 1.8%',
  ),
  ManureProduct(
    id: 'p-002',
    name: 'Standard Compost Mix',
    description:
        'General-purpose compost blend. Suitable for all soil types. Great for small farms and home gardens.',
    unitLabel: '10 kg bag',
    category: 'compost',
    creditPrice: 35,
    cashPriceXaf: 1200,
    stockQty: 78,
    emoji: '🪴',
    benefits: [
      'Improves water retention',
      'Balances soil pH',
      'Supports microbial activity',
    ],
    npkProfile: 'N: 1.4% · P: 0.9% · K: 1.2%',
  ),
  ManureProduct(
    id: 'p-003',
    name: 'Liquid Bio-Fertiliser',
    description:
        'Concentrated liquid extract from fermented organic waste. Applied as foliar spray or soil drench for fast results.',
    unitLabel: '5 litre bottle',
    category: 'liquid',
    creditPrice: 60,
    cashPriceXaf: 2000,
    stockQty: 15,
    emoji: '💧',
    benefits: [
      'Fast-acting nutrient delivery',
      'Foliar or root application',
      'Enhances plant immunity',
    ],
    npkProfile: 'N: 3.0% · P: 0.8% · K: 2.5%',
  ),
  ManureProduct(
    id: 'p-004',
    name: 'Premium Bulk Compost',
    description:
        'Economy bulk compost for large-scale farming. Same premium quality at a reduced per-kg rate.',
    unitLabel: '50 kg bag',
    category: 'compost',
    creditPrice: 150,
    cashPriceXaf: 4500,
    stockQty: 0,
    emoji: '🌾',
    benefits: [
      'Best value per kg',
      'Ideal for 1+ hectare plots',
      'Long-lasting soil improvement',
    ],
    npkProfile: 'N: 2.1% · P: 1.4% · K: 1.8%',
    isAvailable: false,
  ),
  ManureProduct(
    id: 'p-005',
    name: 'Vermicompost (Worm Castings)',
    description:
        'Premium worm castings — nature\'s finest fertiliser. High humus content for exceptional soil health.',
    unitLabel: '5 kg pack',
    category: 'premium',
    creditPrice: 45,
    cashPriceXaf: 1800,
    stockQty: 4,
    emoji: '🪱',
    benefits: [
      'Highest nutrient density',
      'Excellent for seedlings',
      'Improves root development',
      'Odour-free',
    ],
    npkProfile: 'N: 3.5% · P: 2.1% · K: 2.8%',
  ),
];

// ═════════════════════════════════════════════════════════════
// F-02 — Marketplace Catalog Screen
// ═════════════════════════════════════════════════════════════

class MarketplaceCatalogScreen extends StatefulWidget {
  const MarketplaceCatalogScreen({super.key});

  @override
  State<MarketplaceCatalogScreen> createState() =>
      _MarketplaceCatalogScreenState();
}

class _MarketplaceCatalogScreenState extends State<MarketplaceCatalogScreen> {
  String _selectedCategory = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int _cartItemCount = 0;

  static const _categories = [
    {'key': 'all', 'label': 'All Products'},
    {'key': 'compost', 'label': 'Compost'},
    {'key': 'liquid', 'label': 'Liquid'},
    {'key': 'premium', 'label': 'Premium'},
  ];

  List<ManureProduct> get _filtered {
    var list = kDemoProducts.where((p) {
      final matchesCat =
          _selectedCategory == 'all' || p.category == _selectedCategory;
      final matchesSearch =
          _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCat && matchesSearch;
    }).toList();
    return list;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FarmerScaffold(
      currentTab: FarmerNavTab.orders, // This highlights the shop icon
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Marketplace'),
          leading: const BackButton(),
          actions: [
            // Cart icon with badge
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.cart),
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.errorRed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_cartItemCount',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            // ── Search + filters ──────────────────────────────────
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  // Search bar
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    style: AppTextStyles.body,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: AppTextStyles.inputHint,
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.textHint,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Category chips
                  SizedBox(
                    height: 34,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _categories.map((c) {
                        final isActive = _selectedCategory == c['key'];
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = c['key']!),
                          child: AnimatedContainer(
                            duration: AppConstants.animFast,
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.earthBrown
                                  : AppColors.surfaceGray,
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusPill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                c['label']!,
                                style: AppTextStyles.buttonSmall.copyWith(
                                  color: isActive
                                      ? AppColors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Product grid ──────────────────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? EmptyStateWidget(
                      icon: Icons.search_off_rounded,
                      title: 'No products found',
                      subtitle: 'Try a different search or category.',
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: _filtered.length,
                      itemBuilder: (_, i) => _ProductCard(
                        product: _filtered[i],
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.productDetail,
                          arguments: {'productId': _filtered[i].id},
                        ),
                        onAddToCart: _filtered[i].isOutOfStock
                            ? null
                            : () => setState(() => _cartItemCount++),
                      ),
                    ),
            ),
          ],
        ),

        // ── Floating cart button ──────────────────────────────────
        floatingActionButton: _cartItemCount > 0
            ? FloatingActionButton.extended(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.cart),
                backgroundColor: AppColors.earthBrown,
                foregroundColor: AppColors.white,
                icon: const Icon(Icons.shopping_cart_rounded),
                label: Text(
                  'View Cart ($_cartItemCount)',
                  style: AppTextStyles.button,
                ),
              )
            : null,
      ),
    );
  }
}

// ─── Product Card ──────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final ManureProduct product;
  final VoidCallback onTap;
  final VoidCallback? onAddToCart;

  const _ProductCard({
    required this.product,
    required this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // ── Image / Emoji area ────────────────────────────
            Stack(
              children: [
                Container(
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greenLighter,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      product.emoji,
                      style: const TextStyle(fontSize: 52),
                    ),
                  ),
                ),
                // Stock badge top-right
                Positioned(
                  top: 8,
                  right: 8,
                  child: _StockBadge(product: product),
                ),
              ],
            ),

            // ── Info area ─────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(product.unitLabel, style: AppTextStyles.caption),
                    const Spacer(),

                    // Price row
                    Text(
                      '${product.creditPrice} pts',
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.forestGreen,
                      ),
                    ),
                    Text(
                      'or XAF ${product.cashPriceXaf.toStringAsFixed(0)}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Add to cart button
                    SizedBox(
                      width: double.infinity,
                      height: 34,
                      child: ElevatedButton(
                        onPressed: onAddToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: product.isOutOfStock
                              ? AppColors.surfaceGray
                              : AppColors.earthBrown,
                          foregroundColor: product.isOutOfStock
                              ? AppColors.textHint
                              : AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusM,
                            ),
                          ),
                          textStyle: AppTextStyles.buttonSmall,
                        ),
                        child: Text(
                          product.isOutOfStock
                              ? 'Out of Stock'
                              : '+ Add to Cart',
                        ),
                      ),
                    ),
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

// ─── Stock Badge ──────────────────────────────────────────────
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
