import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// Shared screen for Household and Farmer actors.
/// Visual-first fields: crop image grid, farm size icons, GPS location.
/// Social sign-in: Google, Facebook, Instagram.
class RegisterScreen extends StatefulWidget {
  final UserRole role;
  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  // Location (shared by both roles)
  String? _locationText;
  bool _fetchingLocation = false;

  // Farmer-only
  String? _selectedCrop;
  _FarmSize? _selectedFarmSize;
  final _otherCropController = TextEditingController();

  bool get isFarmer => widget.role == UserRole.farmer;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _otherCropController.dispose();
    super.dispose();
  }

  Future<void> _fetchGps() async {
    setState(() => _fetchingLocation = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _locationText = '3.8667° N, 11.5167° E — Near Yaoundé';
        _fetchingLocation = false;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please accept the Terms & Conditions to continue.',
            style: AppTextStyles.bodySmall,
          ),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(
        context,
      ).pushNamed(AppRoutes.otpVerification, arguments: {'role': widget.role});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingL,
            ),
            children: [
              const SizedBox(height: 32),

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

              const SizedBox(height: 20),

              // Headline
              Center(
                child: Text(
                  isFarmer
                      ? 'Create your Farmer Account'
                      : 'Create your ${AppConstants.appName} Account',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.forestGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Core fields
              _BorderedField(
                child: CrrfTextField(
                  label: 'Full Name',
                  hint: 'Full Name',
                  controller: _nameController,
                  prefixIcon: const Icon(
                    Icons.person_outline_rounded,
                    size: 20,
                    color: AppColors.textHint,
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return 'Name is required';
                    if (v.trim().split(' ').length < 2)
                      return 'Enter full name';
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 14),

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
                    if (v == null || !v.contains('@'))
                      return 'Enter a valid email';
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 14),

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
                    if (v == null || v.length < 8)
                      return 'Minimum 8 characters';
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 14),

              // Location (GPS)
              _LocationPicker(
                locationText: _locationText,
                isLoading: _fetchingLocation,
                onTap: _fetchGps,
                onManualEntry: (text) => setState(() => _locationText = text),
              ),

              // Farmer-only visual fields
              if (isFarmer) ...[
                const SizedBox(height: 24),
                _SectionLabel(
                  label: 'Primary Crop Type',
                  subtitle: 'Tap what you grow',
                ),
                const SizedBox(height: 12),
                _CropPicker(
                  selected: _selectedCrop,
                  onSelect: (crop) => setState(() => _selectedCrop = crop),
                  otherController: _otherCropController,
                ),

                const SizedBox(height: 24),
                _SectionLabel(
                  label: 'Farm Size',
                  subtitle: 'Choose the closest match',
                ),
                const SizedBox(height: 12),
                _FarmSizePicker(
                  selected: _selectedFarmSize,
                  onSelect: (size) => setState(() => _selectedFarmSize = size),
                ),
              ],

              const SizedBox(height: 28),

              // Sign Up button
              CrrfPrimaryButton(
                label: 'Sign Up',
                isLoading: _isLoading,
                onPressed: _submit,
              ),

              const SizedBox(height: 20),

              // Social divider
              const LabeledDivider(label: 'or sign up with'),

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

              // ── Terms and Conditions Checkbox (NEW) ─────────────
              GestureDetector(
                onTap: () {
                  setState(() => _agreedToTerms = !_agreedToTerms);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _agreedToTerms
                            ? AppColors.forestGreen
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreedToTerms
                              ? AppColors.forestGreen
                              : AppColors.borderLight,
                          width: 2,
                        ),
                      ),
                      child: _agreedToTerms
                          ? const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to the ',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Login link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(AppRoutes.login),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
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
            ],
          ),
        ),
      ),
    );
  }
}

// GPS Location Picker
class _LocationPicker extends StatelessWidget {
  final String? locationText;
  final bool isLoading;
  final VoidCallback onTap;
  final ValueChanged<String> onManualEntry;

  const _LocationPicker({
    required this.locationText,
    required this.isLoading,
    required this.onTap,
    required this.onManualEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              border: Border.all(color: AppColors.borderLight, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textHint,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: isLoading
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.forestGreen,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Fetching location...',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          locationText ?? 'Farm Location (tap to use GPS)',
                          style: AppTextStyles.body.copyWith(
                            color: locationText != null
                                ? AppColors.textPrimary
                                : AppColors.textHint,
                          ),
                        ),
                ),
                const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.forestGreen,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Or type the nearest village/town',
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 6),
        TextFormField(
          onChanged: onManualEntry,
          style: AppTextStyles.body,
          decoration: InputDecoration(
            hintText: 'e.g. Bafoussam, Dschang, Limbe...',
            hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            filled: true,
            fillColor: AppColors.surfaceGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              borderSide: BorderSide(color: AppColors.borderLighter, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              borderSide: BorderSide(color: AppColors.borderLighter, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              borderSide: const BorderSide(
                color: AppColors.forestGreen,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Section label with subtitle
class _SectionLabel extends StatelessWidget {
  final String label;
  final String subtitle;

  const _SectionLabel({required this.label, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// Crop image grid picker
class _CropItem {
  final String name;
  final String emoji;
  final String asset;

  const _CropItem({
    required this.name,
    required this.emoji,
    required this.asset,
  });
}

const List<_CropItem> _crops = [
  _CropItem(name: 'Beans', emoji: '🫘', asset: 'assets/crops/beans.png'),
  _CropItem(name: 'Yam', emoji: '🍠', asset: 'assets/crops/yam.png'),
  _CropItem(name: 'Potatoes', emoji: '🥔', asset: 'assets/crops/potatoes.png'),
  _CropItem(name: 'Cocoa', emoji: '🍫', asset: 'assets/crops/cocoa.png'),
  _CropItem(name: 'Maize', emoji: '🌽', asset: 'assets/crops/maize.png'),
  _CropItem(name: 'Plantain', emoji: '🍌', asset: 'assets/crops/plantain.png'),
  _CropItem(name: 'Tomato', emoji: '🍅', asset: 'assets/crops/tomato.png'),
  _CropItem(name: 'Other', emoji: '🌿', asset: ''),
];

class _CropPicker extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final TextEditingController otherController;

  const _CropPicker({
    required this.selected,
    required this.onSelect,
    required this.otherController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _crops.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (_, i) {
            final crop = _crops[i];
            final isSelected = selected == crop.name;
            return GestureDetector(
              onTap: () => onSelect(crop.name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.greenLighter
                      : AppColors.surfaceGray,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.forestGreen
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    crop.asset.isNotEmpty
                        ? Image.asset(
                            crop.asset,
                            width: 36,
                            height: 36,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, _) => Text(
                              crop.emoji,
                              style: const TextStyle(fontSize: 30),
                            ),
                          )
                        : Text(
                            crop.emoji,
                            style: const TextStyle(fontSize: 30),
                          ),
                    const SizedBox(height: 6),
                    Text(
                      crop.name,
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: isSelected
                            ? AppColors.forestGreen
                            : AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (selected == 'Other') ...[
          const SizedBox(height: 10),
          TextField(
            controller: otherController,
            decoration: InputDecoration(
              hintText: 'Specify your crop...',
              hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              filled: true,
              fillColor: AppColors.surfaceGray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                borderSide: BorderSide(
                  color: AppColors.borderLighter,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                borderSide: BorderSide(
                  color: AppColors.borderLighter,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                borderSide: const BorderSide(
                  color: AppColors.forestGreen,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// Farm Size visual picker
enum _FarmSize { small, medium, large }

class _FarmSizeOption {
  final _FarmSize size;
  final String label;
  final String range;
  final IconData icon;
  final double iconScale;

  const _FarmSizeOption({
    required this.size,
    required this.label,
    required this.range,
    required this.icon,
    required this.iconScale,
  });
}

const List<_FarmSizeOption> _farmSizes = [
  _FarmSizeOption(
    size: _FarmSize.small,
    label: 'Small Garden',
    range: '< 1 ha',
    icon: Icons.yard_outlined,
    iconScale: 0.6,
  ),
  _FarmSizeOption(
    size: _FarmSize.medium,
    label: 'Medium Plot',
    range: '1 – 5 ha',
    icon: Icons.agriculture_outlined,
    iconScale: 0.8,
  ),
  _FarmSizeOption(
    size: _FarmSize.large,
    label: 'Large Plantation',
    range: '> 5 ha',
    icon: Icons.landscape_outlined,
    iconScale: 1.0,
  ),
];

class _FarmSizePicker extends StatelessWidget {
  final _FarmSize? selected;
  final ValueChanged<_FarmSize> onSelect;

  const _FarmSizePicker({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _farmSizes.map((opt) {
        final isSelected = selected == opt.size;
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(opt.size),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.only(
                right: opt.size != _FarmSize.large ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.greenLighter
                    : AppColors.surfaceGray,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
                border: Border.all(
                  color: isSelected
                      ? AppColors.forestGreen
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    opt.icon,
                    size: 20 + (opt.iconScale * 16),
                    color: isSelected
                        ? AppColors.forestGreen
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    opt.label,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.forestGreen
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    opt.range,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Social sign-in button
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
            errorBuilder: (_, __, _) =>
                Icon(fallbackIcon, color: fallbackColor, size: 28),
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
