import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';
import 'd02_daily_route_screen.dart';

// ═════════════════════════════════════════════════════════════
// D-04 — Confirm Pickup Screen
// ═════════════════════════════════════════════════════════════
/// Driver enters the actual weights per waste type.
/// System calculates credits in real-time as driver types.
/// On submit → backend credits the household → navigate to D-05.
///
/// Key rules enforced in UI:
///   • At least one weight field must be > 0
///   • Minimum weight of 0.5 kg per type to earn credits
///   • Weight rounded down to nearest 0.5 kg (shown live)
///   • Cannot confirm same pickup twice (guarded by backend too)
class ConfirmPickupScreen extends StatefulWidget {
  final String taskId;
  const ConfirmPickupScreen({super.key, required this.taskId});

  @override
  State<ConfirmPickupScreen> createState() => _ConfirmPickupScreenState();
}

class _ConfirmPickupScreenState extends State<ConfirmPickupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plasticController = TextEditingController(text: '0');
  final _organicController = TextEditingController(text: '0');
  bool _isLoading = false;

  PickupTask get _task => kDemoTasks.firstWhere(
    (t) => t.id == widget.taskId,
    orElse: () => kDemoTasks[2],
  );

  // ── Live credit calculation ────────────────────────────────
  double get _plasticKg => double.tryParse(_plasticController.text) ?? 0;
  double get _organicKg => double.tryParse(_organicController.text) ?? 0;
  double get _totalKg => _plasticKg + _organicKg;

  double _roundedKg(double kg) =>
      (kg / AppConstants.weightRoundingStep).floor() *
      AppConstants.weightRoundingStep;

  int get _plasticCredits => _roundedKg(_plasticKg) >= AppConstants.minWeightKg
      ? (_roundedKg(_plasticKg) * AppConstants.creditsPerKgPlastic).toInt()
      : 0;

  int get _organicCredits => _roundedKg(_organicKg) >= AppConstants.minWeightKg
      ? (_roundedKg(_organicKg) * AppConstants.creditsPerKgOrganic).toInt()
      : 0;

  int get _totalCredits => _plasticCredits + _organicCredits;

  bool get _canSubmit => _totalKg > 0;

  // ─────────────────────────────────────────────────────────
  Future<void> _confirm() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_canSubmit) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least one weight above 0 kg.')),
      );
      return;
    }
    setState(() => _isLoading = true);
    // TODO: DriverBloc.confirmPickup(taskId, plasticKg, organicKg)
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.confirmSuccess,
      arguments: {
        'taskId': widget.taskId,
        'plasticKg': _plasticKg,
        'organicKg': _organicKg,
        'totalCredits': _totalCredits,
        'householdName': _task.householdName,
      },
    );
  }

  @override
  void dispose() {
    _plasticController.dispose();
    _organicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DriverScaffold(
      currentTab: DriverNavTab.myRoute,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text('Confirm — Stop #${_task.sequenceNumber}'),
          leading: const BackButton(),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    // ── Household reminder ───────────────────────
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.infoLight,
                        borderRadius: BorderRadius.circular(
                          AppConstants.radiusL,
                        ),
                        border: Border.all(
                          color: AppColors.infoBlue.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.infoBlue.withValues(
                              alpha: 0.2,
                            ),
                            child: Text(
                              _task.householdName[0],
                              style: AppTextStyles.h4.copyWith(
                                color: AppColors.infoBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _task.householdName,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '${_task.address} · ${_task.timeWindow}',
                                  style: AppTextStyles.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Weight entry ─────────────────────────────
                    Text('Enter Actual Weights', style: AppTextStyles.h3),
                    const SizedBox(height: 6),
                    Text(
                      'Weigh each waste type separately. Minimum 0.5 kg to earn credits.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Plastic weight
                    if (_task.wasteTypes.contains('Plastic'))
                      _WeightField(
                        emoji: '♳',
                        label: 'Plastic Weight (kg)',
                        color: AppColors.infoBlue,
                        bg: AppColors.infoLight,
                        controller: _plasticController,
                        onChanged: (_) => setState(() {}),
                        validator: (v) {
                          final val = double.tryParse(v ?? '');
                          if (val == null || val < 0)
                            return 'Enter a valid weight';
                          return null;
                        },
                      ),

                    if (_task.wasteTypes.contains('Plastic') &&
                        _task.wasteTypes.contains('Organic'))
                      const SizedBox(height: 12),

                    // Organic weight
                    if (_task.wasteTypes.contains('Organic'))
                      _WeightField(
                        emoji: '🌿',
                        label: 'Organic Weight (kg)',
                        color: AppColors.forestGreen,
                        bg: AppColors.greenLighter,
                        controller: _organicController,
                        onChanged: (_) => setState(() {}),
                        validator: (v) {
                          final val = double.tryParse(v ?? '');
                          if (val == null || val < 0)
                            return 'Enter a valid weight';
                          return null;
                        },
                      ),

                    const SizedBox(height: 24),

                    // ── Live credit calculation ──────────────────
                    _CreditCalculator(
                      plasticKg: _plasticKg,
                      organicKg: _organicKg,
                      plasticCredits: _plasticCredits,
                      organicCredits: _organicCredits,
                      totalCredits: _totalCredits,
                      roundedPlastic: _roundedKg(_plasticKg),
                      roundedOrganic: _roundedKg(_organicKg),
                    ),

                    const SizedBox(height: 16),

                    const CalloutCard(
                      message:
                          'Credits are issued instantly after you submit. The household will be notified automatically.',
                      type: CalloutType.info,
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // ── Submit CTA ──────────────────────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                color: AppColors.white,
                child: CrrfPrimaryButton(
                  label: _totalCredits > 0
                      ? 'Confirm & Issue $_totalCredits Credits'
                      : 'Confirm Pickup (no credits)',
                  onPressed: _canSubmit ? _confirm : null,
                  isLoading: _isLoading,
                  leadingIcon: Icons.check_circle_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Weight entry field ───────────────────────────────────────
class _WeightField extends StatelessWidget {
  final String emoji, label;
  final Color color, bg;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? Function(String?) validator;

  const _WeightField({
    required this.emoji,
    required this.label,
    required this.color,
    required this.bg,
    required this.controller,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Emoji badge
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              onChanged: onChanged,
              validator: validator,
              style: AppTextStyles.h3.copyWith(color: color),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: label,
                labelStyle: AppTextStyles.inputLabel.copyWith(color: color),
                suffixText: 'kg',
                suffixStyle: AppTextStyles.label.copyWith(
                  color: color.withValues(alpha: 0.6),
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Live credit calculator card ──────────────────────────────
class _CreditCalculator extends StatelessWidget {
  final double plasticKg, organicKg, roundedPlastic, roundedOrganic;
  final int plasticCredits, organicCredits, totalCredits;

  const _CreditCalculator({
    required this.plasticKg,
    required this.organicKg,
    required this.plasticCredits,
    required this.organicCredits,
    required this.totalCredits,
    required this.roundedPlastic,
    required this.roundedOrganic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: totalCredits > 0
            ? AppColors.greenLighter
            : AppColors.surfaceGray,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: totalCredits > 0
              ? AppColors.borderGreen
              : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Credits Calculation',
            style: AppTextStyles.h4.copyWith(
              color: totalCredits > 0
                  ? AppColors.forestGreen
                  : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          if (plasticKg > 0)
            _CalcLine(
              desc:
                  '${roundedPlastic.toStringAsFixed(1)} kg plastic × ${AppConstants.creditsPerKgPlastic} pts',
              result: '$plasticCredits pts',
              color: AppColors.infoBlue,
            ),
          if (organicKg > 0)
            _CalcLine(
              desc:
                  '${roundedOrganic.toStringAsFixed(1)} kg organic × ${AppConstants.creditsPerKgOrganic} pts',
              result: '$organicCredits pts',
              color: AppColors.forestGreen,
            ),
          if (plasticKg > 0 || organicKg > 0) ...[
            const Divider(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total to be issued', style: AppTextStyles.h4),
                CreditChip(amount: totalCredits, isEarned: true),
              ],
            ),
          ] else
            Text(
              'Enter weights above to see credit preview.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _CalcLine extends StatelessWidget {
  final String desc, result;
  final Color color;
  const _CalcLine({
    required this.desc,
    required this.result,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            desc,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            result,
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
