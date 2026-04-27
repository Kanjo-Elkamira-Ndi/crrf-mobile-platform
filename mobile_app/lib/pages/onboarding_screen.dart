import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// S-02 — Onboarding Carousel
///
/// 4 illustrated slides explaining the CRRF concept.
/// Shown only on first launch. After completion, sets
/// [AppConstants.keyOnboardingDone] = true.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      icon: Icons.home_rounded,
      iconColor: AppColors.forestGreen,
      iconBg: AppColors.greenLighter,
      title: 'Sort your waste,\nearn rewards',
      body:
          'Separate your plastic and organic waste at home. Every kilogram you sort earns you CRF Credits — real value from what you throw away.',
      accentColor: AppColors.forestGreen,
    ),
    _OnboardingSlide(
      icon: Icons.local_shipping_rounded,
      iconColor: AppColors.earthBrown,
      iconBg: AppColors.brownLighter,
      title: 'We collect it\nfrom your door',
      body:
          'Schedule a free pickup directly from the app. Our drivers come to you — no more burning waste or illegal dumping.',
      accentColor: AppColors.earthBrown,
    ),
    _OnboardingSlide(
      icon: Icons.account_balance_wallet_rounded,
      iconColor: AppColors.creditGold,
      iconBg: AppColors.goldLighter,
      title: 'Your credits\ngrow with every pickup',
      body:
          'Plastic earns 10 credits/kg. Organic earns 5 credits/kg. Watch your wallet grow with every confirmed collection.',
      accentColor: AppColors.creditGold,
    ),
    _OnboardingSlide(
      icon: Icons.agriculture_rounded,
      iconColor: AppColors.forestGreen,
      iconBg: AppColors.greenLighter,
      title: 'Farmers grow\nbetter crops',
      body:
          'Farmers use your waste-turned-manure to improve their yields. Your household connects directly to Cameroon\'s food supply chain.',
      accentColor: AppColors.greenMid,
    ),
  ];

  void _next() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: AppConstants.animNormal,
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _skip() => _finish();

  void _finish() {
    // TODO: prefs.setBool(AppConstants.keyOnboardingDone, true);
    Navigator.of(context).pushReplacementNamed(AppRoutes.roleSelection);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _slides.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button ──────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.buttonSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            // ── Slides ──────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) =>
                    _OnboardingSlideWidget(slide: _slides[i]),
              ),
            ),

            // ── Dots + CTA ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                children: [
                  // Page dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slides.length, (i) {
                      final isActive = i == _currentPage;
                      return AnimatedContainer(
                        duration: AppConstants.animFast,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.forestGreen
                              : AppColors.borderLight,
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusPill,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 28),

                  // CTA button
                  CrrfPrimaryButton(
                    label: isLast ? 'Get Started' : 'Next',
                    onPressed: _next,
                    leadingIcon: isLast ? Icons.arrow_forward_rounded : null,
                  ),

                  if (!isLast) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Already have an account? Log in',
                        style: AppTextStyles.buttonSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _OnboardingSlide {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String body;
  final Color accentColor;

  const _OnboardingSlide({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.body,
    required this.accentColor,
  });
}

class _OnboardingSlideWidget extends StatelessWidget {
  final _OnboardingSlide slide;
  const _OnboardingSlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration placeholder
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: slide.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(slide.icon, size: 88, color: slide.iconColor),
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            slide.title,
            style: AppTextStyles.h1.copyWith(
              height: 1.25,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Body
          Text(
            slide.body,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              height: 1.7,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
