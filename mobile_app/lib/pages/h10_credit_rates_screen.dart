import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-10 — Credit Earning Rates Screen
// ═════════════════════════════════════════════════════════════
class CreditRatesScreen extends StatelessWidget {
  const CreditRatesScreen({super.key});

  static const _faqs = [
    _FAQ(
      'When are credits issued?',
      'Credits are added to your wallet within minutes of your driver confirming the pickup and logging the actual weight.',
    ),
    _FAQ(
      'What if my weight is less than 0.5 kg?',
      'Pickups below 0.5 kg of any waste type do not generate credits. Weights are rounded down to the nearest 0.5 kg.',
    ),
    _FAQ(
      'Do credits expire?',
      'Yes. All CRF Credits expire 12 months after they are issued. You\'ll receive a notification 30 days before expiry.',
    ),
    _FAQ(
      'Can I transfer credits to someone else?',
      'No. Credits are tied to your household account and cannot be transferred in the current version.',
    ),
    _FAQ(
      'What can I buy with credits?',
      'Credits can be used in the CRRF Marketplace to purchase processed organic manure for farming or personal use.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CrrfScaffold(
      currentTab: CrrfNavTab.history,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text(
          'Credit Earning Rates',
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ── Rates table ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.forestGreen, AppColors.greenMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            ),
            child: Column(
              children: [
                Text(
                  'CRF Credit Rates',
                  style: AppTextStyles.h3.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Per confirmed kilogram',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _RateTile(
                      emoji: '♳',
                      label: 'Plastic',
                      rate: AppConstants.creditsPerKgPlastic,
                    ),
                    const SizedBox(width: 12),
                    _RateTile(
                      emoji: '🌿',
                      label: 'Organic',
                      rate: AppConstants.creditsPerKgOrganic,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Calculation example ───────────────────────────────
          Container(
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
                Text('Example Calculation', style: AppTextStyles.h4),
                const SizedBox(height: 14),
                _CalcRow(desc: '3.0 kg plastic × 10 pts', result: '+30 pts'),
                const SizedBox(height: 8),
                _CalcRow(desc: '1.5 kg organic × 5 pts', result: '+8 pts'),
                const Divider(height: 20),
                _CalcRow(
                  desc: 'Total for this pickup',
                  result: '38 pts',
                  isBold: true,
                ),
                const SizedBox(height: 12),
                const CalloutCard(
                  message:
                      'Weights are rounded down to the nearest 0.5 kg before calculation.',
                  type: CalloutType.info,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text('Frequently Asked Questions', style: AppTextStyles.h3),
          const SizedBox(height: 12),

          // ── FAQ accordion ─────────────────────────────────────
          ..._faqs.map((faq) => _FaqTile(faq: faq)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _RateTile extends StatelessWidget {
  final String emoji;
  final String label;
  final int rate;
  const _RateTile({
    required this.emoji,
    required this.label,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.label.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 4),
            Text(
              '$rate pts / kg',
              style: AppTextStyles.h3.copyWith(color: AppColors.creditGold),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  final String desc;
  final String result;
  final bool isBold;
  const _CalcRow({
    required this.desc,
    required this.result,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          desc,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          result,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            color: isBold ? AppColors.forestGreen : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _FAQ {
  final String q;
  final String a;
  const _FAQ(this.q, this.a);
}

class _FaqTile extends StatefulWidget {
  final _FAQ faq;
  const _FaqTile({required this.faq});

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.faq.q,
            style: AppTextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          trailing: Icon(
            _expanded ? Icons.remove_rounded : Icons.add_rounded,
            color: AppColors.forestGreen,
            size: 20,
          ),
          onExpansionChanged: (v) => setState(() => _expanded = v),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              widget.faq.a,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
