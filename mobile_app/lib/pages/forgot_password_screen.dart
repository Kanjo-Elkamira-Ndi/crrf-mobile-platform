import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// Forgot password screen — sends OTP to email/phone.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pushNamed(
        AppRoutes.otpVerification,
        arguments: {'role': null, 'isPasswordReset': true},
      );
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

                  const SizedBox(height: 32),

                  // Icon
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.greenLighter,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        size: 36,
                        color: AppColors.forestGreen,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Headline
                  Center(
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.forestGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      'Enter your email or phone number and we\'ll send you a verification code to reset your password.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Email/Phone field
                  _BorderedField(
                    child: CrrfTextField(
                      label: 'Email or Phone',
                      hint: 'Email or Phone',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                        size: 20,
                        color: AppColors.textHint,
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Email or phone is required';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Send code button
                  CrrfPrimaryButton(
                    label: 'Send Code',
                    isLoading: _isLoading,
                    onPressed: _sendOtp,
                  ),

                  const SizedBox(height: 20),

                  // Back to login
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text.rich(
                        TextSpan(
                          text: 'Remember your password? ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: 'Log In',
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

                  // Bottom green bar
                  Center(
                    child: Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.forestGreen,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
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
