import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// S-04 — Registration Form
///
/// Accepts [UserRole] via route arguments.
/// Fields: Full name, phone (+237), password, confirm password,
///         district (dropdown). Farmer also gets: farm name, acreage.
class RegisterScreen extends StatefulWidget {
  final UserRole role;
  const RegisterScreen({super.key, required this.role});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _acreageController = TextEditingController();

  String? _selectedDistrict;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  bool get isFarmer => widget.role == UserRole.farmer;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _farmNameController.dispose();
    _acreageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Conditions.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Call AuthRepository.register(...)
    await Future.delayed(const Duration(seconds: 1)); // simulate network

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pushNamed(
        AppRoutes.otpVerification,
        arguments: {
          'phone': '+237${_phoneController.text.trim()}',
          'role': widget.role,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          'Create ${widget.role.displayName} Account',
          style: AppTextStyles.appBarTitle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Role badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.greenLighter,
                borderRadius: BorderRadius.circular(AppConstants.radiusPill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFarmer ? Icons.agriculture_rounded : Icons.home_rounded,
                    color: AppColors.forestGreen,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Registering as: ${widget.role.displayName}',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.forestGreen,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Personal Info ─────────────────────────────────
            Text('Personal Information', style: AppTextStyles.h4),
            const SizedBox(height: 16),

            CrrfTextField(
              label: 'Full Name',
              hint: 'e.g. Ama Mbarga',
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline_rounded),
              textInputAction: TextInputAction.next,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Name is required';
                if (v.trim().split(' ').length < 2)
                  return 'Enter your full name';
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Phone field with Cameroon prefix
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(9),
              ],
              style: AppTextStyles.body,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Phone number is required';
                if (v.length != 9) return 'Enter 9-digit Cameroon number';
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '6XX XXX XXX',
                filled: true,
                fillColor: AppColors.inputBackground,
                prefixIcon: Container(
                  width: 64,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.greenLighter,
                    borderRadius: BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Text(
                    '🇨🇲 +237',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.forestGreen,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.errorRed),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // District dropdown
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              decoration: InputDecoration(
                labelText: 'District',
                prefixIcon: const Icon(Icons.location_on_outlined),
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.forestGreen,
                    width: 1.5,
                  ),
                ),
              ),
              style: AppTextStyles.body,
              items: AppConstants.districts.map((d) {
                return DropdownMenuItem(value: d, child: Text(d));
              }).toList(),
              onChanged: (v) => setState(() => _selectedDistrict = v),
              validator: (v) =>
                  v == null ? 'Please select your district' : null,
            ),

            // ── Farmer-only fields ─────────────────────────────
            if (isFarmer) ...[
              const SizedBox(height: 28),
              Text('Farm Details', style: AppTextStyles.h4),
              const SizedBox(height: 16),

              CrrfTextField(
                label: 'Farm Name (optional)',
                hint: 'e.g. Nkodo Family Farm',
                controller: _farmNameController,
                prefixIcon: const Icon(Icons.cabin_outlined),
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              CrrfTextField(
                label: 'Approximate Farm Size',
                hint: 'e.g. 3 hectares',
                controller: _acreageController,
                prefixIcon: const Icon(Icons.square_foot_rounded),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ],

            // ── Security ──────────────────────────────────────
            const SizedBox(height: 28),
            Text('Account Security', style: AppTextStyles.h4),
            const SizedBox(height: 16),

            CrrfTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: _obscurePassword,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              textInputAction: TextInputAction.next,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Password is required';
                if (v.length < 8) return 'Minimum 8 characters';
                return null;
              },
            ),

            const SizedBox(height: 16),

            CrrfTextField(
              label: 'Confirm Password',
              controller: _confirmController,
              obscureText: _obscureConfirm,
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              textInputAction: TextInputAction.done,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              validator: (v) {
                if (v != _passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),

            const SizedBox(height: 24),

            // ── Terms checkbox ─────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _agreedToTerms = !_agreedToTerms),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to the ',
                          style: AppTextStyles.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.forestGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' of CRRF.'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            CrrfPrimaryButton(
              label: 'Create Account',
              onPressed: _submit,
              isLoading: _isLoading,
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.login),
                child: Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: AppTextStyles.bodySmall,
                    children: [
                      TextSpan(
                        text: 'Log in',
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
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
