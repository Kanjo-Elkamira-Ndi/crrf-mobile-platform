import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// F-09 — Micro-Loan Info Screen
// ═════════════════════════════════════════════════════════════
/// Read-only informational screen explaining:
///   • What the micro-loan program is
///   • Eligibility criteria
///   • How offtake agreements work
///   • "Express Interest" button — sends email, no in-app application for MVP
class MicroLoanInfoScreen extends StatelessWidget {
  const MicroLoanInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FarmerScaffold(
      currentTab: FarmerNavTab.insights,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Micro-Loan Program'),
          leading: const BackButton(),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ── Hero banner ───────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF92400E), AppColors.earthBrown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusXL),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🌾', style: TextStyle(fontSize: 44)),
                  const SizedBox(height: 12),
                  Text(
                    'CRRF Farmer Micro-Loan',
                    style: AppTextStyles.h2.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Access affordable credit to expand your farm — repaid through the manure you purchase.',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.white.withValues(alpha: 0.85),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── What is it ────────────────────────────────────────
            _InfoSection(
              title: '💡 What is it?',
              content:
                  'The CRRF Micro-Loan Program provides smallholder farmers with access to low-interest input financing. Instead of cash repayments, loans are collateralised by an Offtake Agreement — a commitment to purchase a defined quantity of CRRF manure over a set period.',
            ),

            const SizedBox(height: 16),

            // ── How offtake agreements work ───────────────────────
            _InfoSection(
              title: '📄 How Offtake Agreements Work',
              content:
                  'An offtake agreement is a simple document that commits you to purchasing a set amount of manure from CRRF each month. This commitment acts as your loan collateral — no land title or bank account required. As you make purchases, your loan balance reduces automatically.',
            ),

            const SizedBox(height: 16),

            // ── Eligibility ───────────────────────────────────────
            Text('✅ Eligibility Criteria', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            ...[
              'At least 3 completed manure orders with CRRF',
              'Verified farm address in a CRRF service district',
              'Active CRRF Farmer account (phone verified)',
              'No outstanding cancelled orders in the past 90 days',
              'Minimum farm size: 0.5 hectares',
            ].map(
              (c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
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
                    Expanded(
                      child: Text(
                        c,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Loan tiers ────────────────────────────────────────
            Text('💰 Available Loan Tiers', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            ...[
              _LoanTier(
                tier: 'Starter',
                amount: 'XAF 25,000',
                term: '3 months',
                commitment: '25 kg/month',
              ),
              _LoanTier(
                tier: 'Growth',
                amount: 'XAF 75,000',
                term: '6 months',
                commitment: '50 kg/month',
              ),
              _LoanTier(
                tier: 'Expansion',
                amount: 'XAF 150,000',
                term: '12 months',
                commitment: '100 kg/month',
              ),
            ].map((t) => _LoanTierCard(tier: t)),

            const SizedBox(height: 20),

            const CalloutCard(
              message:
                  'Interest rate: 5% flat per annum — significantly below commercial microfinance rates in Cameroon.',
              type: CalloutType.success,
            ),

            const SizedBox(height: 24),

            // ── FAQ ───────────────────────────────────────────────
            Text('Frequently Asked Questions', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            ...[
              _LoanFaq(
                'Is my farm data shared with banks?',
                'No. CRRF manages all loan administration internally. Your data is never shared with third-party financial institutions without your explicit consent.',
              ),
              _LoanFaq(
                'What happens if I miss a purchase?',
                'Missed monthly purchases are flagged after 7 days. CRRF will contact you to discuss alternatives before any default action is taken.',
              ),
              _LoanFaq(
                'Can I apply entirely in the app?',
                'Not yet. In-app loan application will be available in a future update. For now, express your interest below and our team will contact you within 3 business days.',
              ),
            ].map((f) => _FaqTile(faq: f)),

            const SizedBox(height: 28),

            // ── CTA ───────────────────────────────────────────────
            CrrfPrimaryButton(
              label: 'Express Interest',
              onPressed: () {
                // TODO: launch mailto: or open expression of interest form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Thank you! Our team will contact you within 3 business days.',
                    ),
                  ),
                );
              },
              leadingIcon: Icons.send_rounded,
            ),
            const SizedBox(height: 12),
            CrrfSecondaryButton(
              label: 'Back to Dashboard',
              onPressed: () => Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.farmerHome, (_) => false),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─── Info section ─────────────────────────────────────────────
class _InfoSection extends StatelessWidget {
  final String title, content;
  const _InfoSection({required this.title, required this.content});

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
          const SizedBox(height: 10),
          Text(
            content,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Loan tier model + card ───────────────────────────────────
class _LoanTier {
  final String tier, amount, term, commitment;
  const _LoanTier({
    required this.tier,
    required this.amount,
    required this.term,
    required this.commitment,
  });
}

class _LoanTierCard extends StatelessWidget {
  final _LoanTier tier;
  const _LoanTierCard({required this.tier});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: AppColors.borderBrown),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
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
              Icons.account_balance_rounded,
              color: AppColors.earthBrown,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${tier.tier} Loan',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${tier.term} · ${tier.commitment} commitment',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            tier.amount,
            style: AppTextStyles.h4.copyWith(color: AppColors.earthBrown),
          ),
        ],
      ),
    );
  }
}

// ─── FAQ tile ─────────────────────────────────────────────────
class _LoanFaq {
  final String q, a;
  const _LoanFaq(this.q, this.a);
}

class _FaqTile extends StatefulWidget {
  final _LoanFaq faq;
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
            color: AppColors.earthBrown,
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
