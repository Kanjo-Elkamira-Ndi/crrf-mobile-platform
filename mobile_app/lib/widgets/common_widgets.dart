import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../core/constants/app_constants.dart';

// ─────────────────────────────────────────────────────────────
/// Primary CTA button — full width, forest green
// ─────────────────────────────────────────────────────────────
class CrrfPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? leadingIcon;

  const CrrfPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.forestGreen.withValues(alpha: 0.6),
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          elevation: 2,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(label),
                ],
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Secondary outlined button
// ─────────────────────────────────────────────────────────────
class CrrfSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;

  const CrrfSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(label),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Branded text input with floating label
// ─────────────────────────────────────────────────────────────
class CrrfTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final int? maxLines;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const CrrfTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.borderGreen, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(
            color: AppColors.forestGreen,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          borderSide: BorderSide(
            color: AppColors.borderLight.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Status badge pill (Pending, Confirmed, etc.)
// ─────────────────────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color backgroundColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  factory StatusBadge.fromPickupStatus(PickupStatus status) {
    switch (status) {
      case PickupStatus.pending:
        return StatusBadge(
          label: status.label,
          color: AppColors.warningAmber,
          backgroundColor: AppColors.warningLight,
        );
      case PickupStatus.assigned:
        return StatusBadge(
          label: status.label,
          color: AppColors.infoBlue,
          backgroundColor: AppColors.infoLight,
        );
      case PickupStatus.confirmed:
      case PickupStatus.completed:
        return StatusBadge(
          label: status.label,
          color: AppColors.successGreen,
          backgroundColor: AppColors.successLight,
        );
      case PickupStatus.cancelled:
        return StatusBadge(
          label: status.label,
          color: AppColors.errorRed,
          backgroundColor: AppColors.errorLight,
        );
    }
  }

  factory StatusBadge.fromOrderStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.ordered:
        return StatusBadge(
          label: status.label,
          color: AppColors.warningAmber,
          backgroundColor: AppColors.warningLight,
        );
      case OrderStatus.processing:
        return StatusBadge(
          label: status.label,
          color: AppColors.infoBlue,
          backgroundColor: AppColors.infoLight,
        );
      case OrderStatus.outForDelivery:
        return StatusBadge(
          label: status.label,
          color: AppColors.earthBrown,
          backgroundColor: AppColors.brownLight,
        );
      case OrderStatus.delivered:
        return StatusBadge(
          label: status.label,
          color: AppColors.successGreen,
          backgroundColor: AppColors.successLight,
        );
      case OrderStatus.cancelled:
        return StatusBadge(
          label: status.label,
          color: AppColors.errorRed,
          backgroundColor: AppColors.errorLight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Credit chip — shows CRF credit amount in gold
// ─────────────────────────────────────────────────────────────
class CreditChip extends StatelessWidget {
  final int amount;
  final bool isEarned; // true = green +, false = red -

  const CreditChip({super.key, required this.amount, this.isEarned = true});

  @override
  Widget build(BuildContext context) {
    final color = isEarned ? AppColors.forestGreen : AppColors.errorRed;
    final bg = isEarned ? AppColors.greenLighter : AppColors.errorLight;
    final prefix = isEarned ? '+' : '-';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('♻', style: TextStyle(fontSize: 11, color: color)),
          const SizedBox(width: 3),
          Text(
            '$prefix$amount pts',
            style: AppTextStyles.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Section header with optional "See All" link
// ─────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h4),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(actionLabel!, style: AppTextStyles.buttonSmall),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Empty state placeholder
// ─────────────────────────────────────────────────────────────
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.greenLighter,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: AppColors.forestGreen),
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text(title, style: AppTextStyles.h3, textAlign: TextAlign.center),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              subtitle,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: AppConstants.spacingL),
              SizedBox(
                width: 200,
                child: CrrfPrimaryButton(
                  label: actionLabel!,
                  onPressed: onAction,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Full-screen loading overlay
// ─────────────────────────────────────────────────────────────
class CrrfLoadingOverlay extends StatelessWidget {
  final String? message;
  const CrrfLoadingOverlay({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusXL),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: AppColors.forestGreen),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(message!, style: AppTextStyles.body),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Divider with centered label
// ─────────────────────────────────────────────────────────────
class LabeledDivider extends StatelessWidget {
  final String label;
  const LabeledDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Info callout card (green / amber / red tinted)
// ─────────────────────────────────────────────────────────────
enum CalloutType { info, success, warning, error }

class CalloutCard extends StatelessWidget {
  final String message;
  final CalloutType type;
  final IconData? icon;

  const CalloutCard({
    super.key,
    required this.message,
    this.type = CalloutType.info,
    this.icon,
  });

  Color get _bg {
    switch (type) {
      case CalloutType.info:
        return AppColors.greenLighter;
      case CalloutType.success:
        return AppColors.successLight;
      case CalloutType.warning:
        return AppColors.warningLight;
      case CalloutType.error:
        return AppColors.errorLight;
    }
  }

  Color get _fg {
    switch (type) {
      case CalloutType.info:
        return AppColors.forestGreen;
      case CalloutType.success:
        return AppColors.successGreen;
      case CalloutType.warning:
        return AppColors.warningAmber;
      case CalloutType.error:
        return AppColors.errorRed;
    }
  }

  IconData get _icon =>
      icon ??
      switch (type) {
        CalloutType.info => Icons.info_outline_rounded,
        CalloutType.success => Icons.check_circle_outline_rounded,
        CalloutType.warning => Icons.warning_amber_rounded,
        CalloutType.error => Icons.error_outline_rounded,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        border: Border.all(color: _fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, color: _fg, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(color: _fg),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════
//  NAVIGATION
// ═════════════════════════════════════════════════════════════

/// The five nav destinations. The center [pickup] item renders
/// as a raised FAB-style button rather than a normal tab.
enum CrrfNavTab { home, schedule, pickup, history, profile }

// ─────────────────────────────────────────────────────────────
/// Persistent bottom navigation bar — matches the ZyroBin design:
/// Home | Schedule | [Pickup FAB] | History | Profile
///
/// Usage — wrap any authenticated screen with [CrrfScaffold]
/// instead of plain [Scaffold]. See [CrrfScaffold] below.
// ─────────────────────────────────────────────────────────────
class CrrfBottomNavBar extends StatelessWidget {
  final CrrfNavTab current;
  final ValueChanged<CrrfNavTab> onTap;

  const CrrfBottomNavBar({
    super.key,
    required this.current,
    required this.onTap,
  });

  static const _kBarHeight = 68.0;
  static const _kFabSize = 58.0;
  // static const _kFabElevation = 6.0;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: _kBarHeight + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // ── Bar background ─────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _kBarHeight + bottomPadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              // Row of 4 items (the center slot is an invisible spacer)
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      tab: CrrfNavTab.home,
                      current: current,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.calendar_month_rounded,
                      label: 'Schedule',
                      tab: CrrfNavTab.schedule,
                      current: current,
                      onTap: onTap,
                    ),

                    // Centre spacer — the FAB floats above this gap
                    const SizedBox(width: _kFabSize + 8),

                    _NavItem(
                      icon: Icons.history_rounded,
                      label: 'History',
                      tab: CrrfNavTab.history,
                      current: current,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.person_outline_rounded,
                      label: 'Profile',
                      tab: CrrfNavTab.profile,
                      current: current,
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Centre raised FAB ───────────────────────────────
          Positioned(
            // Lifts the FAB so its centre sits at the bar's top edge
            top: -(_kFabSize / 2) + 4,
            child: GestureDetector(
              onTap: () => onTap(CrrfNavTab.pickup),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _kFabSize,
                height: _kFabSize,
                decoration: BoxDecoration(
                  color: AppColors.forestGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.forestGreen.withOpacity(0.45),
                      blurRadius: 14,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    // Location-pin style icon matching the reference image
                    Icons.location_on_rounded,
                    color: Colors.white,
                    size: current == CrrfNavTab.pickup ? 30 : 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Single nav item ──────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final CrrfNavTab tab;
  final CrrfNavTab current;
  final ValueChanged<CrrfNavTab> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.tab,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = tab == current;

    return GestureDetector(
      onTap: () => onTap(tab),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.forestGreen.withOpacity(0.10)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 22,
                color: isActive
                    ? AppColors.forestGreen
                    : const Color(0xFFAAAAAA),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive
                    ? AppColors.forestGreen
                    : const Color(0xFFAAAAAA),
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
/// Drop-in replacement for [Scaffold] that wires up the
/// persistent [CrrfBottomNavBar] automatically.
///
/// Example:
/// ```dart
/// class HomeScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return CrrfScaffold(
///       currentTab: CrrfNavTab.home,
///       body: YourHomeBody(),
///     );
///   }
/// }
/// ```
///
/// Navigation is handled via [Navigator.pushReplacementNamed] so
/// that the back-stack stays clean. Adjust [_routeFor] to match
/// your actual named routes.
// ─────────────────────────────────────────────────────────────
class CrrfScaffold extends StatelessWidget {
  final CrrfNavTab currentTab;
  final Widget body;

  /// Optional: pass a custom [AppBar]. Most inner screens won't need one
  /// since each screen manages its own header area.
  final PreferredSizeWidget? appBar;

  /// Optional: extra widget above the nav bar (e.g. a bottom sheet handle).
  final Widget? persistentFooter;

  const CrrfScaffold({
    super.key,
    required this.currentTab,
    required this.body,
    this.appBar,
    this.persistentFooter,
  });

  static String _routeFor(CrrfNavTab tab) {
    switch (tab) {
      case CrrfNavTab.home:
        return AppRoutes.householdHome; // adjust to your route names
      case CrrfNavTab.schedule:
        return AppRoutes.schedulePickup;
      case CrrfNavTab.pickup:
        return AppRoutes.schedulePickup; // opens schedule as the pickup flow
      case CrrfNavTab.history:
        return AppRoutes.pickupHistory;
      case CrrfNavTab.profile:
        return AppRoutes.profile;
    }
  }

  void _handleTap(BuildContext context, CrrfNavTab tab) {
    if (tab == currentTab) return; // already here — no-op
    Navigator.of(context).pushReplacementNamed(_routeFor(tab));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      appBar: appBar,
      // Prevent the body from going behind the nav bar
      body: body,
      // We build the nav bar ourselves via bottomNavigationBar so Flutter
      // automatically reserves space and handles safe-area insets.
      bottomNavigationBar: CrrfBottomNavBar(
        current: currentTab,
        onTap: (tab) => _handleTap(context, tab),
      ),
    );
  }
}
