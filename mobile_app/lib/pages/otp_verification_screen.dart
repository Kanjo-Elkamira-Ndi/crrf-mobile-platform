import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// S-05 — OTP Verification Screen
///
/// Receives [phone] and [role] via route arguments.
/// 6 individual digit boxes. Countdown timer with resend option.
/// Auto-submits when all 6 digits are entered.
class OtpVerificationScreen extends StatefulWidget {
  final String phone;
  final UserRole role;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
    required this.role,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _otpLength = AppConstants.otpLength;
  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  int _countdown = AppConstants.otpResendCooldownSec;
  Timer? _timer;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _countdown = AppConstants.otpResendCooldownSec;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown <= 0) {
        t.cancel();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  String get _currentOtp => _controllers.map((c) => c.text).join();

  bool get _isComplete => _currentOtp.length == _otpLength;

  void _onDigitChanged(int index, String value) {
    setState(() => _hasError = false);

    if (value.length == 1 && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    if (_isComplete) {
      Future.delayed(const Duration(milliseconds: 100), _verify);
    }
    setState(() {});
  }

  Future<void> _verify() async {
    if (!_isComplete) return;
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    final isValid = _currentOtp == '123456';

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (isValid) {
      final route = switch (widget.role) {
        UserRole.household => AppRoutes.householdHome,
        UserRole.farmer => AppRoutes.farmerHome,
        UserRole.driver => AppRoutes.driverHome,
        UserRole.admin => AppRoutes.adminHome,
      };
      Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
    } else {
      setState(() => _hasError = true);
      for (final c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }

  Future<void> _resend() async {
    _startTimer();
    for (final c in _controllers) {
      c.clear();
    }
    setState(() => _hasError = false);
    _focusNodes[0].requestFocus();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('A new code has been sent.')));
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maskedPhone = _maskPhone(widget.phone);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.greenLighter,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sms_outlined,
                      color: AppColors.forestGreen,
                      size: 36,
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Verify your number',
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Enter the 6-digit code sent to\n$maskedPhone',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_otpLength, (i) {
                      return _OtpBox(
                        controller: _controllers[i],
                        focusNode: _focusNodes[i],
                        hasError: _hasError,
                        onChanged: (v) => _onDigitChanged(i, v),
                      );
                    }),
                  ),

                  const SizedBox(height: 12),

                  AnimatedSwitcher(
                    duration: AppConstants.animFast,
                    child: _hasError
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              'Incorrect code. Please try again.',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.errorRed,
                              ),
                              key: const ValueKey('error'),
                            ),
                          )
                        : const SizedBox(key: ValueKey('no-error')),
                  ),

                  const SizedBox(height: 32),

                  CrrfPrimaryButton(
                    label: 'Verify & Continue',
                    onPressed: _isComplete && !_isLoading ? _verify : null,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  _countdown > 0
                      ? Text.rich(
                          TextSpan(
                            text: 'Resend code in ',
                            style: AppTextStyles.bodySmall,
                            children: [
                              TextSpan(
                                text: '${_countdown}s',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.forestGreen,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      : TextButton(
                          onPressed: _resend,
                          child:
                              const Text("Didn't receive a code? Resend"),
                        ),

                  const SizedBox(height: 16),

                  CalloutCard(
                    message:
                        'Demo mode: use 1 2 3 4 5 6 as the verification code.',
                    type: CalloutType.info,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _maskPhone(String phone) {
    if (phone.length < 6) return phone;
    final start = phone.substring(0, phone.length - 4);
    final masked = start.replaceRange(4, start.length, '••• ');
    return '$masked${phone.substring(phone.length - 4)}';
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final void Function(String) onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 58,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTextStyles.h2.copyWith(
          color: hasError ? AppColors.errorRed : AppColors.forestGreen,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: controller.text.isNotEmpty
              ? (hasError ? AppColors.errorLight : AppColors.greenLighter)
              : AppColors.inputBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            borderSide: BorderSide(
              color: hasError
                  ? AppColors.errorRed
                  : controller.text.isNotEmpty
                  ? AppColors.forestGreen
                  : AppColors.borderLight,
              width: controller.text.isNotEmpty ? 1.5 : 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            borderSide: BorderSide(
              color: hasError
                  ? AppColors.errorRed
                  : controller.text.isNotEmpty
                  ? AppColors.forestGreen
                  : AppColors.borderLight,
              width: controller.text.isNotEmpty ? 1.5 : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            borderSide: BorderSide(
              color: hasError ? AppColors.errorRed : AppColors.forestGreen,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}