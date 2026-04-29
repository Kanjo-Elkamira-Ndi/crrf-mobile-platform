import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';

// H-06 — Cancel Pickup Modal (BottomSheet)
class CancelPickupSheet extends StatefulWidget {
  final String refNumber;
  const CancelPickupSheet({super.key, required this.refNumber});

  @override
  State<CancelPickupSheet> createState() => _CancelPickupSheetState();
}

class _CancelPickupSheetState extends State<CancelPickupSheet> {
  String? _selectedReason;
  bool _isLoading = false;

  static const _reasons = [
    _CancelReason(title: 'Changed my plans', icon: Icons.event_busy_rounded),
    _CancelReason(title: 'Waste not ready yet', icon: Icons.delete_outline_rounded),
    _CancelReason(title: 'Scheduled on wrong date', icon: Icons.calendar_today_rounded),
    _CancelReason(title: 'Personal emergency', icon: Icons.warning_rounded),
    _CancelReason(title: 'Other', icon: Icons.more_horiz_rounded),
  ];

  Future<void> _confirm() async {
    if (_selectedReason == null) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.radiusXL)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.spacingXL,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.errorRed.withValues(alpha: 0.1), AppColors.errorLight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(AppConstants.radiusL),
                        ),
                        child: const Icon(Icons.cancel_outlined, color: AppColors.errorRed, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cancel Pickup', style: AppTextStyles.h3.copyWith(decoration: TextDecoration.none)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceGray,
                                borderRadius: BorderRadius.circular(AppConstants.radiusS),
                              ),
                              child: Text(widget.refNumber, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, decoration: TextDecoration.none)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Warning callout
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.warningLight.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppConstants.radiusM),
                      border: Border.all(color: AppColors.warningAmber.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.warningAmber.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.access_time_rounded, color: AppColors.warningAmber, size: 18),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Cancellations are only allowed up to 2 hours before your scheduled window.',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.earthBrown, decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Section title
                  Text('Why are you cancelling?', style: AppTextStyles.h4.copyWith(decoration: TextDecoration.none)),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // Reason list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: _reasons.map((reason) {
                  final isSelected = _selectedReason == reason.title;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedReason = reason.title),
                    child: AnimatedContainer(
                      duration: AppConstants.animFast,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.errorLight : AppColors.surfaceGray,
                        borderRadius: BorderRadius.circular(AppConstants.radiusM),
                        border: Border.all(
                          color: isSelected ? AppColors.errorRed : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.errorRed.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.errorRed.withValues(alpha: 0.15)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(AppConstants.radiusS),
                            ),
                            child: Icon(
                              reason.icon,
                              color: isSelected ? AppColors.errorRed : AppColors.textTertiary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              reason.title,
                              style: AppTextStyles.body.copyWith(
                                color: isSelected ? AppColors.errorRed : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: AppConstants.animFast,
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.errorRed : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppColors.errorRed : AppColors.borderLight,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Icon(Icons.check_rounded, color: AppColors.white, size: 14)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(color: AppColors.borderLight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.radiusM),
                          ),
                        ),
                        child: Text('Go Back', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, decoration: TextDecoration.none)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _selectedReason != null && !_isLoading ? _confirm : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorRed,
                          disabledBackgroundColor: AppColors.errorRed.withValues(alpha: 0.4),
                          foregroundColor: AppColors.white,
                          disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.radiusM),
                          ),
                          elevation: 2,
                          shadowColor: AppColors.errorRed.withValues(alpha: 0.4),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.white),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.cancel_rounded, size: 20),
                                  const SizedBox(width: 8),
                                  Text('Cancel Pickup', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, color: AppColors.white, decoration: TextDecoration.none)),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _CancelReason {
  final String title;
  final IconData icon;
  const _CancelReason({required this.title, required this.icon});
}
