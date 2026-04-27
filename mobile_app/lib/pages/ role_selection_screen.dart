import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/common_widgets.dart';

/// S-03 — Role Selection Screen
///
/// User chooses: Household or Farmer (Drivers are admin-created only).
/// Selection is stored and forwarded to the registration form.
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? _selected;

  static const List<_RoleOption> _roles = [
    _RoleOption(
      role: UserRole.household,
      icon: Icons.home_rounded,
      title: 'Household',
      subtitle: 'I want to sort waste\nand earn credits',
      detail: 'Schedule pickups · Earn CRF Credits · Track your impact',
      color: AppColors.forestGreen,
      bgColor: AppColors.greenLighter,
    ),
    _RoleOption(
      role: UserRole.farmer,
      icon: Icons.agriculture_rounded,
      title: 'Farmer',
      subtitle: 'I want to buy quality\norganic manure',
      detail: 'Browse marketplace · Pay with vouchers · Request delivery',
      color: AppColors.earthBrown,
      bgColor: AppColors.brownLighter,
    ),
  ];

  void _continue() {
    if (_selected == null) return;
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.register, arguments: {'role': _selected});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // ── Header ──────────────────────────────────────
              Text('I am a...', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Choose your role to get the experience built for you.',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 40),

              // ── Role cards ──────────────────────────────────
              Expanded(
                child: Column(
                  children: _roles.map((option) {
                    final isSelected = _selected == option.role;
                    return _RoleCard(
                      option: option,
                      isSelected: isSelected,
                      onTap: () => setState(() => _selected = option.role),
                    );
                  }).toList(),
                ),
              ),

              // ── CTA ─────────────────────────────────────────
              CrrfPrimaryButton(
                label: 'Continue',
                onPressed: _selected != null ? _continue : null,
                leadingIcon: Icons.arrow_forward_rounded,
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
class _RoleOption {
  final UserRole role;
  final IconData icon;
  final String title;
  final String subtitle;
  final String detail;
  final Color color;
  final Color bgColor;

  const _RoleOption({
    required this.role,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.color,
    required this.bgColor,
  });
}

class _RoleCard extends StatelessWidget {
  final _RoleOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusXL),
            border: Border.all(
              color: isSelected ? option.color : AppColors.borderLight,
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: option.color.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    const BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: isSelected ? option.color : option.bgColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  ),
                  child: Icon(
                    option.icon,
                    color: isSelected ? AppColors.white : option.color,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 20),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(option.title, style: AppTextStyles.h3),
                      const SizedBox(height: 4),
                      Text(
                        option.subtitle,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        option.detail,
                        style: AppTextStyles.caption.copyWith(
                          color: option.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Check indicator
                AnimatedContainer(
                  duration: AppConstants.animFast,
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected ? option.color : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? option.color : AppColors.borderLight,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.white,
                          size: 16,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
