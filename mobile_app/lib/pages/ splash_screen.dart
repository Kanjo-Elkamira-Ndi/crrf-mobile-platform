import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

/// S-01 — Splash / Launch Screen
///
/// Shown on every app launch for ~2.5 seconds.
/// Checks auth state and routes accordingly:
///   - Not seen onboarding → /onboarding
///   - Seen onboarding, not logged in → /login
///   - Logged in → /<role>-home
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _textOpacity;
  late Animation<double> _taglineOpacity;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Logo controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0, 0.5)),
    );

    // Text controller
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Tagline controller
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 0.8).animate(
      CurvedAnimation(parent: _taglineController, curve: Curves.easeIn),
    );

    // Sequence: logo → text → tagline → navigate
    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _textController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    await _taglineController.forward();
    await Future.delayed(const Duration(milliseconds: 800));
    _navigate();
  }

  void _navigate() {
    if (!mounted) return;
    // TODO: Replace with actual auth check via AuthBloc / SharedPreferences
    // For now, always go to onboarding for demo purposes.
    // Real implementation:
    //   final prefs = await SharedPreferences.getInstance();
    //   final onboardingDone = prefs.getBool(AppConstants.keyOnboardingDone) ?? false;
    //   final token = await SecureStorage.read(AppConstants.keyAccessToken);
    //   if (!onboardingDone) { go('/onboarding'); }
    //   else if (token == null) { go('/login'); }
    //   else { go('/<role>-home'); }
    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.forestGreen,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Logo mark ──────────────────────────────────
              ScaleTransition(
                scale: _logoScale,
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: _LogoMark(),
                ),
              ),

              const SizedBox(height: 28),

              // ── App name ───────────────────────────────────
              SlideTransition(
                position: _textSlide,
                child: FadeTransition(
                  opacity: _textOpacity,
                  child: Column(
                    children: [
                      Text(
                        AppConstants.appName,
                        style: AppTextStyles.displayLarge.copyWith(
                          color: AppColors.white,
                          fontFamily: 'DMSerifDisplay',
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppConstants.appFullName.toUpperCase(),
                        style: AppTextStyles.labelUppercase.copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                          letterSpacing: 2.5,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Tagline ────────────────────────────────────
              FadeTransition(
                opacity: _taglineOpacity,
                child: Text(
                  AppConstants.appTagline,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              const SizedBox(height: 80),

              // ── Loading indicator ──────────────────────────
              FadeTransition(
                opacity: _taglineOpacity,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular logo mark widget
class _LogoMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Recycling + leaf icon composition
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.recycling_rounded, size: 44, color: AppColors.white),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.creditGold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco_rounded,
                      size: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
