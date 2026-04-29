import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// ═════════════════════════════════════════════════════════════
// H-12 — Support / Help Screen
// ═════════════════════════════════════════════════════════════
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  static const _faqs = [
    _FAQ(
      'How do I schedule a pickup?',
      'From your dashboard, tap "Request Collection". Select your preferred date, time window, waste types, and estimated weight. Submit to confirm.',
    ),
    _FAQ(
      'Why did I not receive credits after my pickup?',
      'Credits are only issued once your driver confirms the pickup and logs the actual weight. If 24 hours have passed, contact us via the form below.',
    ),
    _FAQ(
      'My driver did not show up — what do I do?',
      'Report the missed pickup using the button below. Our dispatch team will follow up within 2 business hours.',
    ),
    _FAQ(
      'Can I reschedule a pickup?',
      'Cancel your current pending request and submit a new one. Cancellations are allowed up to 2 hours before the scheduled window.',
    ),
    _FAQ(
      'How do credits expire?',
      'Credits expire 12 months after they are issued. You\'ll receive an in-app notification 30 days before expiry.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CrrfScaffold(
      currentTab: CrrfNavTab.profile,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text(
          'Help & Support',
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
          // ── Contact options ───────────────────────────────────
          SectionHeader(title: 'Contact Us'),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _ContactCard(
                  icon: Icons.sms_rounded,
                  label: 'SMS',
                  sublabel: '+237 6XX XXX XXX',
                  color: AppColors.forestGreen,
                  bg: AppColors.greenLighter,
                  onTap: () {}, // TODO: launch sms:
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ContactCard(
                  icon: Icons.phone_in_talk_rounded,
                  label: 'WhatsApp',
                  sublabel: 'Chat with us',
                  color: Color(0xFF25D366),
                  bg: Color(0xFFE9FBF0),
                  onTap: () {}, // TODO: launch wa.me/
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Report missed pickup
          GestureDetector(
            onTap: () {}, // TODO: Open report form
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.brownLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(color: AppColors.borderBrown),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.earthBrown,
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                    ),
                    child: const Icon(
                      Icons.report_problem_outlined,
                      color: AppColors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Report a Missed Pickup',
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.earthBrown,
                          ),
                        ),
                        Text(
                          'Driver did not arrive? Let us know.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: AppColors.earthBrown,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ── FAQ ───────────────────────────────────────────────
          SectionHeader(title: 'Frequently Asked Questions'),
          const SizedBox(height: 12),
          ..._faqs.map((faq) => _FaqTile(faq: faq)),

          const SizedBox(height: 28),

          // ── App version ───────────────────────────────────────
          Center(
            child: Text(
              '${AppConstants.appName} v${AppConstants.appVersion}',
              style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final Color bg;
  final VoidCallback onTap;
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(label, style: AppTextStyles.h4.copyWith(color: color)),
            Text(sublabel, style: AppTextStyles.caption),
          ],
        ),
      ),
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
