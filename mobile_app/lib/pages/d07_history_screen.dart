import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/common_widgets.dart';
// import 'd02_daily_route_screen.dart';

// Define PickupTaskStatus enum if not already defined elsewhere
enum PickupTaskStatus { pending, completed, skipped }

// ═════════════════════════════════════════════════════════════
// D-07 — Driver Pickup History Screen
// ═════════════════════════════════════════════════════════════
/// Shows all past completed and skipped pickups for the driver.
/// Features:
///   • Date-grouped sections (Today / Yesterday / This Week / Older)
///   • Filter: All / Completed / Skipped
///   • Per-day totals: weight collected, credits issued
///   • Tap any row for a read-only detail view
class DriverHistoryListScreen extends StatefulWidget {
  const DriverHistoryListScreen({super.key});

  @override
  State<DriverHistoryListScreen> createState() =>
      _DriverHistoryListScreenState();
}

class _DriverHistoryListScreenState extends State<DriverHistoryListScreen> {
  PickupTaskStatus? _filter; // null = all (completed + skipped)

  // TODO: Replace with DriverBloc history data
  final List<_HistoryDay> _history = [
    _HistoryDay(
      label: 'Today — Apr 29, 2026',
      totalWeightKg: 12.4,
      creditsIssued: 94,
      entries: [
        _HistoryEntry(
          seq: 1,
          household: 'Ama Mbarga',
          address: 'Bastos',
          time: '8:14 AM',
          plasticKg: 3.0,
          organicKg: 1.5,
          credits: 38,
          status: PickupTaskStatus.completed,
        ),
        _HistoryEntry(
          seq: 2,
          household: 'Jean-Paul Essomba',
          address: 'Essos',
          time: '9:02 AM',
          plasticKg: 0,
          organicKg: 0,
          credits: 0,
          status: PickupTaskStatus.skipped,
          skipReason: 'Household absent',
        ),
        _HistoryEntry(
          seq: 3,
          household: 'Marie Atangana',
          address: 'Ngousso',
          time: '10:45 AM',
          plasticKg: 2.0,
          organicKg: 3.0,
          credits: 56,
          status: PickupTaskStatus.completed,
        ),
      ],
    ),
    _HistoryDay(
      label: 'Yesterday — Apr 28, 2026',
      totalWeightKg: 18.0,
      creditsIssued: 152,
      entries: [
        _HistoryEntry(
          seq: 1,
          household: 'Christelle Biya',
          address: 'Melen',
          time: '7:30 AM',
          plasticKg: 4.0,
          organicKg: 0,
          credits: 40,
          status: PickupTaskStatus.completed,
        ),
        _HistoryEntry(
          seq: 2,
          household: 'Paul Fotso',
          address: 'Mvog-Ada',
          time: '9:15 AM',
          plasticKg: 2.5,
          organicKg: 2.0,
          credits: 35,
          status: PickupTaskStatus.completed,
        ),
        _HistoryEntry(
          seq: 3,
          household: 'Solange Nkouandjio',
          address: 'Mendong',
          time: '11:00 AM',
          plasticKg: 0,
          organicKg: 0,
          credits: 0,
          status: PickupTaskStatus.skipped,
          skipReason: 'No waste ready',
        ),
        _HistoryEntry(
          seq: 4,
          household: 'Eric Mbozo',
          address: 'Omnisport',
          time: '2:30 PM',
          plasticKg: 5.0,
          organicKg: 4.5,
          credits: 77,
          status: PickupTaskStatus.completed,
        ),
      ],
    ),
    _HistoryDay(
      label: 'Apr 25, 2026',
      totalWeightKg: 9.5,
      creditsIssued: 70,
      entries: [
        _HistoryEntry(
          seq: 1,
          household: 'Blandine Tchoua',
          address: 'Mfoundi',
          time: '8:00 AM',
          plasticKg: 1.5,
          organicKg: 2.0,
          credits: 25,
          status: PickupTaskStatus.completed,
        ),
        _HistoryEntry(
          seq: 2,
          household: 'Roger Nguetse',
          address: 'Biyem-Assi',
          time: '10:30 AM',
          plasticKg: 3.0,
          organicKg: 3.0,
          credits: 45,
          status: PickupTaskStatus.completed,
        ),
      ],
    ),
  ];

  List<_HistoryEntry> _filteredEntries(List<_HistoryEntry> entries) {
    if (_filter == null)
      return entries
          .where((e) => e.status != PickupTaskStatus.pending)
          .toList();
    return entries.where((e) => e.status == _filter).toList();
  }

  // Aggregate stats across all time
  double get _totalWeightAllTime =>
      _history.fold(0.0, (s, d) => s + d.totalWeightKg);
  int get _totalCreditsAllTime =>
      _history.fold(0, (s, d) => s + d.creditsIssued);
  int get _totalPickups => _history.fold(
    0,
    (s, d) =>
        s +
        d.entries.where((e) => e.status == PickupTaskStatus.completed).length,
  );
  int get _totalSkipped => _history.fold(
    0,
    (s, d) =>
        s + d.entries.where((e) => e.status == PickupTaskStatus.skipped).length,
  );

  @override
  Widget build(BuildContext context) {
    return DriverScaffold(
      currentTab: DriverNavTab.history,
      body: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Pickup History'),
          leading: const BackButton(),
        ),
        body: Column(
          children: [
            // ── All-time summary ──────────────────────────────────
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _TotalStat(
                        value: '$_totalPickups',
                        label: 'Completed',
                        color: AppColors.successGreen,
                        bg: AppColors.successLight,
                      ),
                      const SizedBox(width: 8),
                      _TotalStat(
                        value: '$_totalSkipped',
                        label: 'Skipped',
                        color: AppColors.warningAmber,
                        bg: AppColors.warningLight,
                      ),
                      const SizedBox(width: 8),
                      _TotalStat(
                        value: '${_totalWeightAllTime.toStringAsFixed(1)} kg',
                        label: 'Weight',
                        color: AppColors.infoBlue,
                        bg: AppColors.infoLight,
                      ),
                      const SizedBox(width: 8),
                      _TotalStat(
                        value: '$_totalCreditsAllTime pts',
                        label: 'Credits',
                        color: AppColors.forestGreen,
                        bg: AppColors.greenLighter,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Filter chips ───────────────────────────────────
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                height: 34,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'All',
                      isActive: _filter == null,
                      onTap: () => setState(() => _filter = null),
                    ),
                    _FilterChip(
                      label: 'Completed',
                      isActive: _filter == PickupTaskStatus.completed,
                      onTap: () =>
                          setState(() => _filter = PickupTaskStatus.completed),
                    ),
                    _FilterChip(
                      label: 'Skipped',
                      isActive: _filter == PickupTaskStatus.skipped,
                      onTap: () =>
                          setState(() => _filter = PickupTaskStatus.skipped),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),

            // ── Grouped list ──────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                itemCount: _history.length,
                itemBuilder: (_, di) {
                  final day = _history[di];
                  final entries = _filteredEntries(day.entries);
                  if (entries.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Day header
                      _DayHeader(day: day, entryCount: entries.length),
                      const SizedBox(height: 10),
                      // Entries
                      ...entries.map((e) => _HistoryEntryCard(entry: e)),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── All-time stat tile ───────────────────────────────────────
class _TotalStat extends StatelessWidget {
  final String value, label;
  final Color color, bg;
  const _TotalStat({
    required this.value,
    required this.label,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: color.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Day section header ───────────────────────────────────────
class _DayHeader extends StatelessWidget {
  final _HistoryDay day;
  final int entryCount;
  const _DayHeader({required this.day, required this.entryCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
      ),
      child: Row(
        children: [
          Text(
            day.label,
            style: AppTextStyles.label.copyWith(
              color: AppColors.infoBlue,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Text(
            '${day.totalWeightKg.toStringAsFixed(1)} kg',
            style: AppTextStyles.caption.copyWith(color: AppColors.infoBlue),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 12,
            color: AppColors.infoBlue.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8),
          Text(
            '${day.creditsIssued} pts',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.forestGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── History entry card ───────────────────────────────────────
class _HistoryEntryCard extends StatelessWidget {
  final _HistoryEntry entry;
  const _HistoryEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final isDone = entry.status == PickupTaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
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
          // Sequence + status icon
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.successLight : AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check_rounded : Icons.close_rounded,
                  color: isDone ? AppColors.successGreen : AppColors.errorRed,
                  size: 16,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '#${entry.seq}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.household,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(entry.time, style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(height: 2),
                Text(entry.address, style: AppTextStyles.caption),
                const SizedBox(height: 4),

                if (isDone)
                  Row(
                    children: [
                      if (entry.plasticKg > 0)
                        _WeightTag(
                          label:
                              '${entry.plasticKg.toStringAsFixed(1)}kg plastic',
                          color: AppColors.infoBlue,
                          bg: AppColors.infoLight,
                        ),
                      if (entry.plasticKg > 0 && entry.organicKg > 0)
                        const SizedBox(width: 5),
                      if (entry.organicKg > 0)
                        _WeightTag(
                          label:
                              '${entry.organicKg.toStringAsFixed(1)}kg organic',
                          color: AppColors.forestGreen,
                          bg: AppColors.greenLighter,
                        ),
                      const Spacer(),
                      CreditChip(amount: entry.credits, isEarned: true),
                    ],
                  )
                else
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 12,
                        color: AppColors.warningAmber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        entry.skipReason ?? 'Skipped',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.warningAmber,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightTag extends StatelessWidget {
  final String label;
  final Color color, bg;
  const _WeightTag({
    required this.label,
    required this.color,
    required this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppConstants.radiusPill),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 9,
        ),
      ),
    );
  }
}

// ─── Filter chip ──────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animFast,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.infoBlue : AppColors.surfaceGray,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.buttonSmall.copyWith(
              color: isActive ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Data models ──────────────────────────────────────────────
class _HistoryDay {
  final String label;
  final double totalWeightKg;
  final int creditsIssued;
  final List<_HistoryEntry> entries;

  const _HistoryDay({
    required this.label,
    required this.totalWeightKg,
    required this.creditsIssued,
    required this.entries,
  });
}

class _HistoryEntry {
  final int seq, credits;
  final String household, address, time;
  final double plasticKg, organicKg;
  final PickupTaskStatus status;
  final String? skipReason;

  const _HistoryEntry({
    required this.seq,
    required this.household,
    required this.address,
    required this.time,
    required this.plasticKg,
    required this.organicKg,
    required this.credits,
    required this.status,
    this.skipReason,
  });
}
