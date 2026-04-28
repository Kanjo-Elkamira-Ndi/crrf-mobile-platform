import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/common_widgets.dart';

// H-04 — Pickup History Screen
class PickupHistoryScreen extends StatefulWidget {
  const PickupHistoryScreen({super.key});

  @override
  State<PickupHistoryScreen> createState() => _PickupHistoryScreenState();
}

class _PickupHistoryScreenState extends State<PickupHistoryScreen> {
  PickupStatus? _filterStatus;

  final List<_PickupEntry> _pickups = [
    _PickupEntry(ref: 'CRRF-2026-00142', date: '30 Apr 2026', window: '7–10 AM', types: 'Plastic + Organic', status: PickupStatus.pending, credits: null),
    _PickupEntry(ref: 'CRRF-2026-00130', date: '25 Apr 2026', window: '10 AM–2 PM', types: 'Plastic', status: PickupStatus.completed, credits: 30),
    _PickupEntry(ref: 'CRRF-2026-00118', date: '18 Apr 2026', window: '2–6 PM', types: 'Organic', status: PickupStatus.completed, credits: 15),
    _PickupEntry(ref: 'CRRF-2026-00103', date: '10 Apr 2026', window: '7–10 AM', types: 'Plastic + Organic', status: PickupStatus.cancelled, credits: null),
    _PickupEntry(ref: 'CRRF-2026-00089', date: '2 Apr 2026', window: '10 AM–2 PM', types: 'Plastic', status: PickupStatus.completed, credits: 20),
  ];

  List<_PickupEntry> get _filtered => _filterStatus == null ? _pickups : _pickups.where((p) => p.status == _filterStatus).toList();

  @override
  Widget build(BuildContext context) {
    return CrrfScaffold(
      currentTab: CrrfNavTab.history,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Text('Pickup History', style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingL, vertical: AppConstants.spacingS),
              children: [
                _FilterChip(label: 'All', isActive: _filterStatus == null, onTap: () => setState(() => _filterStatus = null)),
                _FilterChip(label: 'Pending', isActive: _filterStatus == PickupStatus.pending, onTap: () => setState(() => _filterStatus = PickupStatus.pending)),
                _FilterChip(label: 'Completed', isActive: _filterStatus == PickupStatus.completed, onTap: () => setState(() => _filterStatus = PickupStatus.completed)),
                _FilterChip(label: 'Cancelled', isActive: _filterStatus == PickupStatus.cancelled, onTap: () => setState(() => _filterStatus = PickupStatus.cancelled)),
              ],
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const EmptyStateWidget(icon: Icons.recycling_rounded, title: 'No pickups found', subtitle: 'Schedule your first waste collection to start earning credits.')
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppConstants.spacingL, AppConstants.spacingS, AppConstants.spacingL, AppConstants.spacingXL),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _PickupCard(
                      entry: _filtered[i],
                      onTap: () => Navigator.of(context).pushNamed(AppRoutes.pickupDetail, arguments: {'ref': _filtered[i].ref}),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PickupEntry {
  final String ref, date, window, types;
  final PickupStatus status;
  final int? credits;
  const _PickupEntry({required this.ref, required this.date, required this.window, required this.types, required this.status, this.credits});
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animFast,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.forestGreen : AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
          border: Border.all(color: isActive ? AppColors.forestGreen : AppColors.borderLight),
        ),
        child: Center(
          child: Text(label, style: AppTextStyles.buttonSmall.copyWith(color: isActive ? AppColors.white : AppColors.textSecondary)),
        ),
      ),
    );
  }
}

class _PickupCard extends StatelessWidget {
  final _PickupEntry entry;
  final VoidCallback onTap;
  const _PickupCard({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          boxShadow: const [BoxShadow(color: AppColors.shadow, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(color: AppColors.greenLighter, borderRadius: BorderRadius.circular(AppConstants.radiusM)),
              child: const Icon(Icons.recycling_rounded, color: AppColors.forestGreen, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.ref, style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
                      StatusBadge.fromPickupStatus(entry.status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${entry.date} · ${entry.window}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.types, style: AppTextStyles.caption),
                      if (entry.credits != null) CreditChip(amount: entry.credits!, isEarned: true),
                    ],
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
