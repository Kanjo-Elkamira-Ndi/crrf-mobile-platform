import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import 'd02_daily_route_screen.dart';

// ═════════════════════════════════════════════════════════════
// D-06 — Report Issue / Skip Screen
// ═════════════════════════════════════════════════════════════
/// Driver marks a pickup as Unable to Complete.
/// Reason selection + optional free-text note.
/// On submit → task marked skipped, driver returns to route.
class ReportIssueScreen extends StatefulWidget {
  final String taskId;
  const ReportIssueScreen({super.key, required this.taskId});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  String? _selectedReason;
  final _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a reason before submitting.'),
        ),
      );
      return;
    }
    setState(() => _isLoading = true);
    // TODO: DriverBloc.skipPickup(taskId, reason, note)
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    // Pop all the way back to route list
    Navigator.of(context)
      ..pop() // skip screen
      ..pop(); // task detail
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pickup marked as skipped. Dispatch has been notified.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = kDemoTasks.firstWhere(
      (t) => t.id == widget.taskId,
      orElse: () => kDemoTasks[2],
    );

    return DriverScaffold(
      currentTab: DriverNavTab.myRoute,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Report Issue — Stop #${task.sequenceNumber}'),
          leading: const BackButton(),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // ── Household reminder ───────────────────────
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.errorLight,
                      borderRadius: BorderRadius.circular(AppConstants.radiusL),
                      border: Border.all(
                        color: AppColors.errorRed.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.errorRed,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skipping: ${task.householdName}',
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.errorRed,
                                ),
                              ),
                              Text(
                                '${task.address} · ${task.timeWindow}',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.errorRed.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  const CalloutCard(
                    message:
                        'Skipping a pickup means no credits are issued. Dispatch will contact the household to reschedule.',
                    type: CalloutType.warning,
                  ),

                  const SizedBox(height: 24),

                  // ── Reason selector ──────────────────────────
                  Text('Reason for Skipping', style: AppTextStyles.h4),
                  const SizedBox(height: 12),

                  ...AppConstants.skipReasons.map((reason) {
                    final isSelected = _selectedReason == reason;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedReason = reason),
                      child: AnimatedContainer(
                        duration: AppConstants.animFast,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.errorLight
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusL,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.errorRed
                                : AppColors.borderLight,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                reason,
                                style: AppTextStyles.body.copyWith(
                                  color: isSelected
                                      ? AppColors.errorRed
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.errorRed,
                                size: 20,
                              )
                            else
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.borderLight,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // ── Optional note ────────────────────────────
                  Text('Additional Note (optional)', style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  CrrfTextField(
                    label: 'Describe the issue for dispatch...',
                    controller: _noteController,
                    maxLines: 3,
                    prefixIcon: const Icon(Icons.notes_rounded),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // ── CTAs ─────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              color: AppColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CrrfSecondaryButton(
                      label: 'Go Back',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 54,
                      child: ElevatedButton.icon(
                        icon: _isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: AppColors.white,
                                ),
                              )
                            : const Icon(Icons.report_rounded, size: 18),
                        label: Text(
                          _isLoading ? 'Submitting...' : 'Submit & Skip',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorRed,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          textStyle: AppTextStyles.button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _isLoading ? null : _submit,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
