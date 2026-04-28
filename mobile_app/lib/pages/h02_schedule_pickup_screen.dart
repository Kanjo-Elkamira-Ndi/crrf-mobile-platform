import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

/// H-02 — Schedule Pickup Screen
class SchedulePickupScreen extends StatefulWidget {
  const SchedulePickupScreen({super.key});

  @override
  State<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String? _selectedTimeWindow;
  final Set<String> _selectedWasteTypes = {};
  double _estimatedWeightKg = 2.0;
  final _notesController = TextEditingController();
  bool _isLoading = false;

  final Map<int, List<String>> _scheduledDots = {
    6: ['organic', 'recycling'],
    8: ['organic', 'general'],
    13: ['recycling'],
    16: ['general'],
    20: ['organic'],
    23: ['organic', 'general'],
    28: ['recycling', 'organic'],
  };

  final List<_UpcomingPickup> _upcomingPickups = const [
    _UpcomingPickup(weekday: 'Thu', day: 8, time: '07:00 AM – 09:00 AM', types: ['Organic Waste', 'General Waste']),
    _UpcomingPickup(weekday: 'Mon', day: 13, time: '09:00 AM – 11:00 AM', types: ['Recycling']),
  ];

  int get _estimatedCredits {
    int total = 0;
    final roundedKg = (_estimatedWeightKg / 0.5).floor() * 0.5;
    if (_selectedWasteTypes.contains('plastic')) total += (roundedKg * AppConstants.creditsPerKgPlastic).toInt();
    if (_selectedWasteTypes.contains('organic')) total += (roundedKg * AppConstants.creditsPerKgOrganic).toInt();
    return total;
  }

  bool get _canSubmit => _selectedTimeWindow != null && _selectedWasteTypes.isNotEmpty;

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacementNamed(AppRoutes.pickupConfirmation);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _prevMonth() => setState(() => _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1, 1));
  void _nextMonth() => setState(() => _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 1));

  Color _dotColor(String type) => switch (type) {
    'organic' => AppColors.forestGreen,
    'recycling' => AppColors.infoBlue,
    _ => AppColors.textTertiary,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Collection Schedule', style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary)),
            Text('Track your waste pickup dates', style: AppTextStyles.caption),
          ],
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.greenLighter,
            child: const Icon(Icons.person_rounded, color: AppColors.forestGreen, size: 20),
          ),
          const SizedBox(width: AppConstants.spacingM),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingM),
              children: [
                _buildCalendar(),
                _buildUpcomingPickups(),
                _buildScheduleSection(),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final year = _focusedMonth.year;
    final month = _focusedMonth.month;
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startOffset = firstDay.weekday % 7;
    final rows = ((startOffset + daysInMonth) / 7).ceil();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: _prevMonth, icon: const Icon(Icons.arrow_back_ios_rounded, size: 16, color: AppColors.textSecondary)),
              Text('${_monthNames[month - 1]} $year', style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w700)),
              IconButton(onPressed: _nextMonth, icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textSecondary)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _weekdayLabels.map((d) => SizedBox(width: 36, child: Text(d, textAlign: TextAlign.center, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, color: AppColors.textTertiary)))).toList(),
          ),
          const SizedBox(height: AppConstants.spacingS),
          ...List.generate(rows, (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (col) {
              final cellIndex = row * 7 + col;
              final dayNum = cellIndex - startOffset + 1;
              if (dayNum < 1 || dayNum > daysInMonth) return const SizedBox(width: 36, height: 52);
              final thisDate = DateTime(year, month, dayNum);
              final isSelected = thisDate.day == _selectedDate.day && thisDate.month == _selectedDate.month && thisDate.year == _selectedDate.year;
              final isToday = thisDate.day == DateTime.now().day && thisDate.month == DateTime.now().month && thisDate.year == DateTime.now().year;
              final dots = _scheduledDots[dayNum] ?? [];
              return GestureDetector(
                onTap: () => setState(() => _selectedDate = thisDate),
                child: SizedBox(
                  width: 36,
                  height: 52,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: AppConstants.animFast,
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.forestGreen : isToday ? AppColors.greenLighter : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Text('$dayNum', style: AppTextStyles.bodySmall.copyWith(fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w400, color: isSelected ? AppColors.white : isToday ? AppColors.forestGreen : AppColors.textPrimary))),
                      ),
                      if (dots.isNotEmpty) ...[const SizedBox(height: 3), Row(mainAxisAlignment: MainAxisAlignment.center, children: dots.take(3).map((type) => Container(width: 5, height: 5, margin: const EdgeInsets.symmetric(horizontal: 1), decoration: BoxDecoration(color: _dotColor(type), shape: BoxShape.circle))).toList())],
                    ],
                  ),
                ),
              );
            }),
          )),
          const SizedBox(height: AppConstants.spacingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_LegendDot(color: AppColors.forestGreen, label: 'Organic'), const SizedBox(width: 16), _LegendDot(color: AppColors.infoBlue, label: 'Recycling'), const SizedBox(width: 16), _LegendDot(color: AppColors.textTertiary, label: 'General')],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingPickups() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.fromLTRB(AppConstants.spacingL, AppConstants.spacingL, AppConstants.spacingL, AppConstants.spacingM), child: Text('Upcoming Pickups', style: AppTextStyles.h4)),
        ..._upcomingPickups.map((p) => _UpcomingPickupCard(pickup: p)),
      ],
    );
  }

  Widget _buildScheduleSection() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabeledDivider(label: 'Schedule New Pickup'),
          const SizedBox(height: AppConstants.spacingM),
          if (_selectedWasteTypes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingM),
              child: CalloutCard(message: 'Estimated credits for this pickup: ~$_estimatedCredits pts', type: CalloutType.info, icon: Icons.stars_rounded),
            ),
          _StepLabel(number: '1', label: 'Selected date'),
          const SizedBox(height: AppConstants.spacingS),
          _SelectedDateBadge(date: _selectedDate),
          const SizedBox(height: AppConstants.spacingL),
          _StepLabel(number: '2', label: 'Preferred time window'),
          const SizedBox(height: AppConstants.spacingS),
          _TimeWindowSelector(selected: _selectedTimeWindow, onSelect: (v) => setState(() => _selectedTimeWindow = v)),
          const SizedBox(height: AppConstants.spacingL),
          _StepLabel(number: '3', label: 'What will you be sorting?'),
          const SizedBox(height: AppConstants.spacingXS),
          Text('Select all that apply. Credits differ by type.', style: AppTextStyles.caption),
          const SizedBox(height: AppConstants.spacingS),
          _WasteTypeSelector(selected: _selectedWasteTypes, onToggle: (key) => setState(() => _selectedWasteTypes.contains(key) ? _selectedWasteTypes.remove(key) : _selectedWasteTypes.add(key))),
          const SizedBox(height: AppConstants.spacingL),
          _StepLabel(number: '4', label: 'Estimated weight'),
          const SizedBox(height: AppConstants.spacingS),
          _WeightSlider(value: _estimatedWeightKg, onChanged: (v) => setState(() => _estimatedWeightKg = v)),
          const SizedBox(height: AppConstants.spacingL),
          _StepLabel(number: '5', label: 'Notes for driver (optional)'),
          const SizedBox(height: AppConstants.spacingS),
          CrrfTextField(label: 'e.g. Gate code, call before arrival', controller: _notesController, maxLines: 3, prefixIcon: const Icon(Icons.notes_rounded)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(AppConstants.spacingL, AppConstants.spacingM, AppConstants.spacingL, AppConstants.spacingXL),
      decoration: BoxDecoration(color: AppColors.white, boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, -4))]),
      child: CrrfPrimaryButton(
        label: _canSubmit ? 'Confirm Pickup Request' : 'Select time & waste type',
        onPressed: _canSubmit ? _submit : null,
        isLoading: _isLoading,
        leadingIcon: Icons.check_circle_outline_rounded,
      ),
    );
  }

  static const _weekdayLabels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  static const _monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
}

class _UpcomingPickup {
  final String weekday, time;
  final int day;
  final List<String> types;
  const _UpcomingPickup({required this.weekday, required this.day, required this.time, required this.types});
}

class _SelectedDateBadge extends StatelessWidget {
  final DateTime date;
  const _SelectedDateBadge({required this.date});
  static const _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  static const _months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM, vertical: 12),
      decoration: BoxDecoration(color: AppColors.greenLighter, borderRadius: BorderRadius.circular(AppConstants.radiusM), border: Border.all(color: AppColors.forestGreen, width: 1.5)),
      child: Row(
        children: [
          const Icon(Icons.event_rounded, color: AppColors.forestGreen, size: 20),
          const SizedBox(width: 12),
          Text('${_weekdays[date.weekday - 1]}, ${date.day} ${_months[date.month - 1]} ${date.year}', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, color: AppColors.greenDark)),
          const Spacer(),
          const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen, size: 18),
        ],
      ),
    );
  }
}

class _UpcomingPickupCard extends StatelessWidget {
  final _UpcomingPickup pickup;
  const _UpcomingPickupCard({required this.pickup});

  Color _chipColor(String type) => switch (true) {
    _ when type.toLowerCase().contains('organic') => AppColors.greenLighter,
    _ when type.toLowerCase().contains('recycl') => AppColors.infoLight,
    _ => AppColors.surfaceGray,
  };

  Color _chipTextColor(String type) => switch (true) {
    _ when type.toLowerCase().contains('organic') => AppColors.forestGreen,
    _ when type.toLowerCase().contains('recycl') => AppColors.infoBlue,
    _ => AppColors.textSecondary,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(AppConstants.spacingM, 0, AppConstants.spacingM, AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppConstants.radiusL), boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 2))]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppConstants.radiusS)),
            child: Column(children: [Text(pickup.weekday, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)), Text('${pickup.day}', style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.w800))]),
          ),
          const SizedBox(width: AppConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [const Icon(Icons.access_time_rounded, size: 13, color: AppColors.textTertiary), const SizedBox(width: 4), Text(pickup.time, style: AppTextStyles.caption)]),
                const SizedBox(height: AppConstants.spacingS),
                Wrap(
                  spacing: 6, runSpacing: 6,
                  children: pickup.types.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: _chipColor(t), borderRadius: BorderRadius.circular(AppConstants.radiusPill)),
                    child: Text(t, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, color: _chipTextColor(t))),
                  )).toList(),
                ),
              ],
            ),
          ),
          Row(children: [_IconActionButton(icon: Icons.edit_rounded, color: AppColors.forestGreen, bgColor: AppColors.greenLighter, onTap: () {}), const SizedBox(width: 6), _IconActionButton(icon: Icons.delete_outline_rounded, color: AppColors.errorRed, bgColor: AppColors.errorLight, onTap: () {})]),
        ],
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final Color color, bgColor;
  final VoidCallback onTap;
  const _IconActionButton({required this.icon, required this.color, required this.bgColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: 32, height: 32, decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(AppConstants.radiusS)), child: Icon(icon, size: 16, color: color)),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 5), Text(label, style: AppTextStyles.caption)]);
  }
}

class _StepLabel extends StatelessWidget {
  final String number, label;
  const _StepLabel({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24, height: 24,
          decoration: const BoxDecoration(color: AppColors.forestGreen, shape: BoxShape.circle),
          child: Center(child: Text(number, style: AppTextStyles.caption.copyWith(color: AppColors.white, fontWeight: FontWeight.w700))),
        ),
        const SizedBox(width: 10),
        Text(label, style: AppTextStyles.h4),
      ],
    );
  }
}

class _TimeWindowSelector extends StatelessWidget {
  final String? selected;
  final void Function(String) onSelect;
  const _TimeWindowSelector({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: AppConstants.pickupTimeWindows.map((w) {
        final isSelected = selected == w['key'];
        return GestureDetector(
          onTap: () => onSelect(w['key']!),
          child: AnimatedContainer(
            duration: AppConstants.animFast,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.greenLighter : AppColors.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
              border: Border.all(color: isSelected ? AppColors.forestGreen : AppColors.borderLight, width: isSelected ? 1.5 : 1),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded, color: isSelected ? AppColors.forestGreen : AppColors.textHint, size: 20),
                const SizedBox(width: 12),
                Text(w['label']!, style: AppTextStyles.body.copyWith(color: isSelected ? AppColors.forestGreen : AppColors.textPrimary, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
                const Spacer(),
                if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen, size: 20),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _WasteTypeSelector extends StatelessWidget {
  final Set<String> selected;
  final void Function(String) onToggle;
  const _WasteTypeSelector({required this.selected, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AppConstants.wasteTypes.map((w) {
        final key = w['key'] as String;
        final isSelected = selected.contains(key);
        final credits = w['credits'] as int;
        return Expanded(
          child: GestureDetector(
            onTap: () => onToggle(key),
            child: AnimatedContainer(
              duration: AppConstants.animFast,
              margin: EdgeInsets.only(right: key == 'plastic' ? 8 : 0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.greenLighter : AppColors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                border: Border.all(color: isSelected ? AppColors.forestGreen : AppColors.borderLight, width: isSelected ? 1.5 : 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(w['emoji'] as String, style: const TextStyle(fontSize: 28)), if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen, size: 18)],
                  ),
                  const SizedBox(height: 8),
                  Text(w['label'] as String, style: AppTextStyles.h4.copyWith(color: isSelected ? AppColors.forestGreen : AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('$credits pts / kg', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _WeightSlider extends StatelessWidget {
  final double value;
  final void Function(double) onChanged;
  const _WeightSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppConstants.radiusL), border: Border.all(color: AppColors.borderLight)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Estimated weight', style: AppTextStyles.bodySmall),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: AppColors.greenLighter, borderRadius: BorderRadius.circular(AppConstants.radiusPill)),
                child: Text('${value.toStringAsFixed(1)} kg', style: AppTextStyles.label.copyWith(color: AppColors.forestGreen)),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.forestGreen,
              inactiveTrackColor: AppColors.greenLight,
              thumbColor: AppColors.forestGreen,
              overlayColor: AppColors.forestGreen.withValues(alpha: 0.1),
              trackHeight: 4,
            ),
            child: Slider(value: value, min: 0.5, max: 20.0, divisions: 39, onChanged: onChanged),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('0.5 kg', style: AppTextStyles.caption), Text('20 kg', style: AppTextStyles.caption)],
          ),
        ],
      ),
    );
  }
}
