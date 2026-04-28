import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

/// S-03 — Role Selection Screen (ZyroBin-style)
///
/// Layout mirrors the ZyroBin "Select category" pattern:
///   Logo + App name
///   Bold green heading
///   Subtitle
///   List rows: [icon]  [label + sublabel]  [radio]
///   Bottom "Continue" button (enabled when role selected)
///   "Log in" link
///
/// On tap: radio animates green → Continue button enabled
/// On continue: pushNamed to [AppRoutes.register] with {role: UserRole}.
class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  UserRole? _selected;

  void _onContinue() {
    if (_selected == null) return;
    Navigator.of(context).pushNamed(
      AppRoutes.register,
      arguments: {'role': _selected},
    );
  }

  static const _roles = <_RoleItem>[
    _RoleItem(
      role: UserRole.household,
      icon: Icons.home_outlined,
      label: 'Household',
      sublabel: 'Sort waste, earn credits, schedule pickups',
    ),
    _RoleItem(
      role: UserRole.farmer,
      icon: Icons.agriculture_outlined,
      label: 'Farmer',
      sublabel: 'Buy organic manure, pay with vouchers',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ─────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 52),

                    // Logo
                    _Logo(),

                    const SizedBox(height: 36),

                    // Heading
                    Text(
                      'Select the category\nyou belong to',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h1.copyWith(
                        color: AppColors.forestGreen,
                        fontSize: 24,
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'Choose your role to get the experience\nbuilt for you.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.65,
                      ),
                    ),

                    const SizedBox(height: 44),

                    // ── Selectable rows ──────────────────────
                    _RoleRow(
                      item: _roles[0],
                      isSelected: _selected == _roles[0].role,
                      onTap: () => setState(() => _selected = _roles[0].role),
                    ),

                    const SizedBox(height: 16),

                    _RoleRow(
                      item: _roles[1],
                      isSelected: _selected == _roles[1].role,
                      onTap: () => setState(() => _selected = _roles[1].role),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // ── Bottom fixed bar ───────────────────────────
            _BottomBar(
              onLogin: () => Navigator.of(context).pushNamed(AppRoutes.login),
              onContinue: _onContinue,
              isContinueEnabled: _selected != null,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Role Row
// ─────────────────────────────────────────────────────────────
class _RoleRow extends StatelessWidget {
  final _RoleItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleRow({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.forestGreen.withValues(alpha: 0.05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Icon
                Icon(
                  item.icon,
                  size: 34,
                  color: isSelected
                      ? AppColors.forestGreen
                      : AppColors.textSecondary,
                ),

                const SizedBox(width: 20),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.label,
                        style: AppTextStyles.h4.copyWith(
                          color: isSelected
                              ? AppColors.forestGreen
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.sublabel,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Radio dot
                _Radio(isSelected: isSelected),
              ],
            ),
          ),

          // Divider
          Divider(height: 1, thickness: 1, color: AppColors.borderLighter),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Animated radio indicator
// ─────────────────────────────────────────────────────────────
class _Radio extends StatelessWidget {
  final bool isSelected;
  const _Radio({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.forestGreen : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.forestGreen : AppColors.borderLight,
          width: isSelected ? 0 : 1.5,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: AppColors.white, size: 16)
          : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Logo block — recycling icon + "CRRF" wordmark
// ─────────────────────────────────────────────────────────────
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.greenLighter,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.borderGreen, width: 1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.recycling_rounded,
                size: 34,
                color: AppColors.forestGreen,
              ),
              Positioned(
                bottom: 9,
                right: 9,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.creditGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.eco_rounded,
                    size: 9,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppConstants.appName,
          style: AppTextStyles.h3.copyWith(
            color: AppColors.forestGreen,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Bottom bar — green pill + "Log in" link
// ─────────────────────────────────────────────────────────────
class _BottomBar extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onContinue;
  final bool isContinueEnabled;
  const _BottomBar({
    required this.onLogin,
    required this.onContinue,
    required this.isContinueEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderLighter, width: 1),
        ),
      ),
      child: Column(
        children: [
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isContinueEnabled ? onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.forestGreen,
                disabledBackgroundColor: AppColors.borderLight,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.textHint,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue',
                style: AppTextStyles.h4.copyWith(
                  color: isContinueEnabled
                      ? AppColors.white
                      : AppColors.textHint,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Green pill — matches ZyroBin bottom bar indicator
          Container(
            width: 52,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.forestGreen,
              borderRadius: BorderRadius.circular(999),
            ),
          ),

          const SizedBox(height: 18),

          GestureDetector(
            onTap: onLogin,
            child: Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: 'Log in',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.forestGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────────────────────
class _RoleItem {
  final UserRole role;
  final IconData icon;
  final String label;
  final String sublabel;

  const _RoleItem({
    required this.role,
    required this.icon,
    required this.label,
    required this.sublabel,
  });
}
