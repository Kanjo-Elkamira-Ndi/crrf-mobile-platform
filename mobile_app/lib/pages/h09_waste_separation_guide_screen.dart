import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-09 — Waste Separation Guide Screen
// ═════════════════════════════════════════════════════════════
/// Swipeable illustrated cards per waste category.
/// Helps households reduce contamination before pickup.
class WasteSeparationGuideScreen extends StatefulWidget {
  const WasteSeparationGuideScreen({super.key});

  @override
  State<WasteSeparationGuideScreen> createState() =>
      _WasteSeparationGuideScreenState();
}

class _WasteSeparationGuideScreenState
    extends State<WasteSeparationGuideScreen> {
  int _page = 0;
  final PageController _controller = PageController();

  static const _guides = <_GuideSlide>[
    _GuideSlide(
      emoji: '♳',
      title: 'Plastic Waste',
      color: AppColors.infoBlue,
      bg: AppColors.infoLight,
      creditsPerKg: 10,
      accepted: [
        'Water & soda bottles (PET)',
        'Plastic bags & packaging',
        'Food containers (clean)',
        'Shampoo / cosmetic bottles',
        'Plastic buckets & crates',
      ],
      rejected: [
        'Styrofoam / foam packaging',
        'Plastic mixed with food waste',
        'Medical / hazardous plastics',
        'PVC pipes',
      ],
      tip: 'Rinse containers before sorting. Dirty plastic earns zero credits.',
    ),
    _GuideSlide(
      emoji: '🌿',
      title: 'Organic Waste',
      color: AppColors.forestGreen,
      bg: AppColors.greenLighter,
      creditsPerKg: 5,
      accepted: [
        'Fruit & vegetable peels',
        'Food scraps & leftovers',
        'Coffee grounds & tea bags',
        'Eggshells',
        'Garden clippings & leaves',
      ],
      rejected: [
        'Meat, fish, or dairy products',
        'Oily or heavily seasoned food',
        'Diseased plant material',
        'Non-biodegradable items',
      ],
      tip: 'Store organic waste in a covered bin to avoid odour and pests.',
    ),
    _GuideSlide(
      emoji: '🚫',
      title: 'What We Don\'t Accept',
      color: AppColors.errorRed,
      bg: AppColors.errorLight,
      creditsPerKg: 0,
      accepted: [],
      rejected: [
        'Electronic waste (phones, cables)',
        'Glass or ceramics',
        'Metal / aluminium cans',
        'Medical or chemical waste',
        'Batteries or light bulbs',
        'Mixed or contaminated waste',
      ],
      tip:
          'For electronics and glass, contact your local district council for disposal options.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CrrfScaffold(
      currentTab: CrrfNavTab.history,
      appBar: AppBar(
        title: const Text('Waste Separation Guide'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // ── Page carousel ────────────────────────────────────
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _guides.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) => _GuideCard(slide: _guides[i]),
            ),
          ),

          // ── Dots + arrows ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back arrow
                IconButton(
                  onPressed: _page > 0
                      ? () => _controller.previousPage(
                          duration: AppConstants.animNormal,
                          curve: Curves.easeInOut,
                        )
                      : null,
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: _page > 0 ? AppColors.forestGreen : AppColors.textHint,
                ),

                // Dots
                Row(
                  children: List.generate(_guides.length, (i) {
                    return AnimatedContainer(
                      duration: AppConstants.animFast,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _page == i ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _page == i
                            ? AppColors.forestGreen
                            : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusPill,
                        ),
                      ),
                    );
                  }),
                ),

                // Next arrow
                IconButton(
                  onPressed: _page < _guides.length - 1
                      ? () => _controller.nextPage(
                          duration: AppConstants.animNormal,
                          curve: Curves.easeInOut,
                        )
                      : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  color: _page < _guides.length - 1
                      ? AppColors.forestGreen
                      : AppColors.textHint,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideSlide {
  final String emoji;
  final String title;
  final Color color;
  final Color bg;
  final int creditsPerKg;
  final List<String> accepted;
  final List<String> rejected;
  final String tip;

  const _GuideSlide({
    required this.emoji,
    required this.title,
    required this.color,
    required this.bg,
    required this.creditsPerKg,
    required this.accepted,
    required this.rejected,
    required this.tip,
  });
}

class _GuideCard extends StatelessWidget {
  final _GuideSlide slide;
  const _GuideCard({required this.slide});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        children: [
          // Hero
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: slide.bg,
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            ),
            child: Column(
              children: [
                Text(slide.emoji, style: const TextStyle(fontSize: 56)),
                const SizedBox(height: 10),
                Text(
                  slide.title,
                  style: AppTextStyles.h2.copyWith(color: slide.color),
                ),
                if (slide.creditsPerKg > 0) ...[
                  const SizedBox(height: 8),
                  CreditChip(amount: slide.creditsPerKg, isEarned: true),
                  Text(' per kg', style: AppTextStyles.caption),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Accepted list
          if (slide.accepted.isNotEmpty) ...[
            _ListCard(
              title: '✅  Accepted',
              items: slide.accepted,
              color: AppColors.successGreen,
              bg: AppColors.successLight,
            ),
            const SizedBox(height: 12),
          ],

          // Rejected list
          _ListCard(
            title: '❌  Not Accepted',
            items: slide.rejected,
            color: AppColors.errorRed,
            bg: AppColors.errorLight,
          ),

          const SizedBox(height: 12),

          // Tip callout
          CalloutCard(message: '💡  ${slide.tip}', type: CalloutType.info),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final Color bg;

  const _ListCard({
    required this.title,
    required this.items,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h4.copyWith(color: color)),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
