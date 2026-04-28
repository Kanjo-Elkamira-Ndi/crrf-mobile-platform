import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// Shared login screen for all roles.
/// Social sign-in: Google, Facebook, Instagram.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      // Navigate based on stored role — default to household for now
      Navigator.of(context).pushNamed(AppRoutes.householdHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingL,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),

                  // Logo
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.greenLighter,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.borderGreen,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.recycling_rounded,
                            size: 32,
                            color: AppColors.forestGreen,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppConstants.appName,
                          style: AppTextStyles.h3.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Headline
                  Center(
                    child: Text(
                      'Welcome Back',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.forestGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Center(
                    child: Text(
                      'Log in to continue',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email field
                  _BorderedField(
                    child: CrrfTextField(
                      label: 'Email',
                      hint: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        size: 20,
                        color: AppColors.textHint,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || !v.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Password field
                  _BorderedField(
                    child: CrrfTextField(
                      label: 'Password',
                      hint: 'Password',
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                        color: AppColors.textHint,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20,
                          color: AppColors.textHint,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (v) {
                        if (v == null || v.isEmpty)
                          return 'Password is required';
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Remember me + Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              value: _rememberMe,
                              activeColor: AppColors.forestGreen,
                              onChanged: (v) {
                                setState(() => _rememberMe = v ?? false);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Remember me',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.forgotPassword),
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.forestGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Log In button
                  CrrfPrimaryButton(
                    label: 'Log In',
                    isLoading: _isLoading,
                    onPressed: _submit,
                  ),

                  const SizedBox(height: 20),

                  // Social divider
                  const LabeledDivider(label: 'or log in with'),

                  const SizedBox(height: 16),

                  // Social buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(
                        iconAsset: 'assets/icons/google.png',
                        fallbackIcon: Icons.g_mobiledata_rounded,
                        fallbackColor: const Color(0xFFEA4335),
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      _SocialButton(
                        iconAsset: 'assets/icons/facebook.png',
                        fallbackIcon: Icons.facebook_rounded,
                        fallbackColor: const Color(0xFF1877F2),
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      _SocialButton(
                        iconAsset: 'assets/icons/instagram.png',
                        fallbackIcon: Icons.camera_alt_outlined,
                        fallbackColor: const Color(0xFFE1306C),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Sign up link
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(
                        context,
                      ).pushNamed(AppRoutes.roleSelection),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wraps a form field with a light green border and subtle box shadow
class _BorderedField extends StatelessWidget {
  final Widget child;

  const _BorderedField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        child: child,
      ),
    );
  }
}

/// Social sign-in button
class _SocialButton extends StatelessWidget {
  final String iconAsset;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final VoidCallback onTap;

  const _SocialButton({
    required this.iconAsset,
    required this.fallbackIcon,
    required this.fallbackColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(color: AppColors.borderLight, width: 1.5),
        ),
        child: Center(
          child: Image.asset(
            iconAsset,
            width: 26,
            height: 26,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) =>
                Icon(fallbackIcon, color: fallbackColor, size: 28),
          ),
        ),
      ),
    );
  }
}
