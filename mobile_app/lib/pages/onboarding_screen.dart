import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
// import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
// import '../widgets/common_widgets.dart';

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
      illustration: 'assets/illustrations/onboarding_sort.jpg',
      title: 'Sort your waste, earn rewards.',
      tagline: '(Separate plastic & organic — every kg earns CRF Credits)',
    ),
    _OnboardingSlide(
      illustration: 'assets/illustrations/onboarding_pickup.png',
      title: 'We collect it\nfrom your door.',
      tagline:
          'Schedule a free pickup directly from the app. \n Our drivers come to you — no more burning waste or illegal dumping.',
    ),
    _OnboardingSlide(
      illustration: 'assets/illustrations/onboarding_credits.jpg',
      title: 'Your credits grow with every pickup.',
      tagline: '(Plastic earns 10 credits/kg while organic earns 5 credits/kg)',
    ),
    _OnboardingSlide(
      illustration: 'assets/illustrations/onboarding_farmers.png',
      title: 'Farmers grow better crops.',
      tagline:
          '(Your waste connects directly to Cameroon\'s food supply chain)',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
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

                  const SizedBox(height: 24),

                  // Next / Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forestGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLast ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Skip / Login button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _skip,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.forestGreen,
                        side: BorderSide(
                          color: AppColors.forestGreen,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLast ? 'Already have an account? Log in' : 'Skip',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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

// ─────────────────────────────────────────────────────────────
class _OnboardingSlide {
  final String illustration; // asset path
  final String title;
  final String tagline;

  const _OnboardingSlide({
    required this.illustration,
    required this.title,
    required this.tagline,
  });
}

class _OnboardingSlideWidget extends StatelessWidget {
  final _OnboardingSlide slide;
  const _OnboardingSlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Illustration ─────────────────────────────────
          SizedBox(
            height: 280,
            child: Image.asset(
              slide.illustration,
              fit: BoxFit.contain,
              // Fallback while illustrations aren't wired up:
              errorBuilder: (_, __, ___) => Container(
                height: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F9EE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  size: 64,
                  color: Color(0xFFB0CCA8),
                ),
              ),
            ),
          ),

          const SizedBox(height: 36),

          // ── Title ────────────────────────────────────────
          Text(
            slide.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // ── Tagline ──────────────────────────────────────
          Text(
            slide.tagline,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF888888),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
